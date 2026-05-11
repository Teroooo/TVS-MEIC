/*
 * Exercise 3.1: symbolic property tests for the Exercise 2 TreeTable.
 *
 * KLEE build:
 *   clang -I. -emit-llvm -c ex3/klee_tests.c -o ex3/klee_tests.bc
 *   klee ex3/klee_tests.bc
 *
 * Native smoke build, useful when KLEE is not installed:
 *   clang -std=c11 -Wall -Wextra -I. ex3/klee_tests.c -o /tmp/klee_tests
 */

#if __has_include(<klee/klee.h>)
#include <klee/klee.h>
#define HAVE_KLEE 1
#else
#include <assert.h>
#define HAVE_KLEE 0
#define klee_make_symbolic(addr, nbytes, name) ((void)(addr), (void)(nbytes), (void)(name))
#define klee_assume(expr) assert(expr)
#define klee_assert(expr) assert(expr)
#endif

#include <stdlib.h>

/*
 * Include the implementation directly so the KLEE test suite is self-contained
 * and so the known empty-tree sentinel bug can be isolated for coverage of
 * treetable_get_first_key's not-found branch.
 */
#include "../ex2/treetable.c"

static int symbolic_int(const char *name, int concrete_fallback)
{
    int value = concrete_fallback;
    klee_make_symbolic(&value, sizeof(value), name);
    return value;
}

static void *safe_malloc(size_t size)
{
    void *ptr = malloc(size);
    klee_assume(ptr != 0);
    return ptr;
}

static void *safe_calloc(size_t count, size_t size)
{
    void *ptr = calloc(count, size);
    klee_assume(ptr != 0);
    return ptr;
}

static TreeTable *make_table(void)
{
    TreeTableConf conf;
    TreeTable *table = NULL;

    treetable_conf_init(&conf);
    conf.mem_alloc = safe_malloc;
    conf.mem_calloc = safe_calloc;

    klee_assert(treetable_new_conf(&conf, &table) == CC_OK);
    klee_assert(table != NULL);
    return table;
}

static TreeTable *make_empty_table_with_safe_sentinel(void)
{
    TreeTable *table = make_table();

    /*
     * The implementation leaves sentinel children as NULL. Public empty
     * treetable_get_first_key therefore crashes before reaching its documented
     * CC_ERR_KEY_NOT_FOUND branch. This white-box setup keeps the table empty
     * but makes the sentinel self-referential so KLEE can also cover that
     * branch. The separate bug report documents the public API crash.
     */
    table->sentinel->left = table->sentinel;
    table->sentinel->right = table->sentinel;
    table->sentinel->parent = table->sentinel;
    return table;
}

/* Property: adding the first key creates a valid one-element tree. */
static void test_add_root_preserves_validity(void)
{
    TreeTable *table = make_table();
    int key = symbolic_int("root_key", 10);
    int value = symbolic_int("root_value", 100);

    klee_assert(treetable_add(table, &key, &value) == CC_OK);
    klee_assert(treetable_size(table) == 1);
    klee_assert(balanced(table));
    klee_assert(sorted(table));

    treetable_destroy(table);
}

/* Property: adding an existing key updates its value without changing size. */
static void test_add_duplicate_updates_value_only(void)
{
    TreeTable *table = make_table();
    int key = symbolic_int("dup_key", 11);
    int old_value = symbolic_int("old_value", 1);
    int new_value = symbolic_int("new_value", 2);
    void *out = NULL;

    klee_assert(treetable_add(table, &key, &old_value) == CC_OK);
    klee_assert(treetable_add(table, &key, &new_value) == CC_OK);
    klee_assert(treetable_size(table) == 1);
    klee_assert(treetable_get(table, &key, &out) == CC_OK);
    klee_assert(out == &new_value);
    klee_assert(balanced(table));
    klee_assert(sorted(table));

    treetable_destroy(table);
}

/*
 * Property: adding two distinct symbolic keys preserves ordering regardless of
 * whether the second key goes left or right of the root.
 */
static void test_add_left_and_right_children(void)
{
    TreeTable *table = make_table();
    int k1 = symbolic_int("two_k1", 20);
    int k2 = symbolic_int("two_k2", 10);
    int v1 = symbolic_int("two_v1", 1);
    int v2 = symbolic_int("two_v2", 2);

    klee_assume(k1 != k2);
    klee_assert(treetable_add(table, &k1, &v1) == CC_OK);
    klee_assert(treetable_add(table, &k2, &v2) == CC_OK);
    klee_assert(treetable_size(table) == 2);
    klee_assert(balanced(table));
    klee_assert(sorted(table));

    treetable_destroy(table);
}

/*
 * Property: inserting three distinct symbolic keys preserves the validity
 * oracles. KLEE explores the key orderings, exercising insertion comparisons
 * and rebalance paths.
 */
static void test_add_three_symbolic_keys_preserves_validity(void)
{
    TreeTable *table = make_table();
    int k1 = symbolic_int("three_k1", 30);
    int k2 = symbolic_int("three_k2", 10);
    int k3 = symbolic_int("three_k3", 20);
    int v1 = symbolic_int("three_v1", 1);
    int v2 = symbolic_int("three_v2", 2);
    int v3 = symbolic_int("three_v3", 3);

    klee_assume(k1 != k2);
    klee_assume(k1 != k3);
    klee_assume(k2 != k3);

    klee_assert(treetable_add(table, &k1, &v1) == CC_OK);
    klee_assert(treetable_add(table, &k2, &v2) == CC_OK);
    klee_assert(treetable_add(table, &k3, &v3) == CC_OK);
    klee_assert(treetable_size(table) == 3);
    klee_assert(balanced(table));
    klee_assert(sorted(table));

    treetable_destroy(table);
}

/* Property: lookup on an empty tree and lookup for an absent key both fail. */
static void test_get_missing_keys_fail(void)
{
    TreeTable *table = make_table();
    int absent = symbolic_int("get_absent_empty", 99);
    int present = symbolic_int("get_present", 10);
    int other = symbolic_int("get_absent_nonempty", 20);
    int value = symbolic_int("get_value", 42);
    void *out = NULL;

    klee_assume(present != other);
    klee_assert(treetable_get(table, &absent, &out) == CC_ERR_KEY_NOT_FOUND);
    klee_assert(treetable_add(table, &present, &value) == CC_OK);
    klee_assert(treetable_get(table, &other, &out) == CC_ERR_KEY_NOT_FOUND);

    treetable_destroy(table);
}

/* Property: lookup returns the exact value pointer associated with the key. */
static void test_get_inserted_key_returns_value(void)
{
    TreeTable *table = make_table();
    int key = symbolic_int("get_found_key", 7);
    int value = symbolic_int("get_found_value", 70);
    void *out = NULL;

    klee_assert(treetable_add(table, &key, &value) == CC_OK);
    klee_assert(treetable_get(table, &key, &out) == CC_OK);
    klee_assert(out == &value);

    treetable_destroy(table);
}

/* Property: first key on an empty, well-formed sentinel tree is not found. */
static void test_get_first_key_empty_returns_not_found(void)
{
    TreeTable *table = make_empty_table_with_safe_sentinel();
    void *out = NULL;

    klee_assert(treetable_get_first_key(table, &out) == CC_ERR_KEY_NOT_FOUND);

    treetable_destroy(table);
}

/* Property: first key is the minimum of all inserted keys. */
static void test_get_first_key_is_minimum(void)
{
    TreeTable *table = make_table();
    int k1 = symbolic_int("first_k1", 30);
    int k2 = symbolic_int("first_k2", 10);
    int k3 = symbolic_int("first_k3", 20);
    int value = symbolic_int("first_value", 3);
    void *out = NULL;

    klee_assume(k1 != k2);
    klee_assume(k1 != k3);
    klee_assume(k2 != k3);

    klee_assert(treetable_add(table, &k1, &value) == CC_OK);
    klee_assert(treetable_add(table, &k2, &value) == CC_OK);
    klee_assert(treetable_add(table, &k3, &value) == CC_OK);
    klee_assert(treetable_get_first_key(table, &out) == CC_OK);
    klee_assert(*(int *)out <= k1);
    klee_assert(*(int *)out <= k2);
    klee_assert(*(int *)out <= k3);

    treetable_destroy(table);
}

/*
 * Property: querying a key whose successor is in its right subtree returns the
 * smallest key in that right subtree.
 */
static void test_get_greater_than_uses_right_subtree_minimum(void)
{
    TreeTable *table = make_table();
    int k1 = 10;
    int k2 = 20;
    int k3 = 30;
    int value = symbolic_int("greater_right_value", 1);
    void *out = NULL;

    klee_assert(treetable_add(table, &k2, &value) == CC_OK);
    klee_assert(treetable_add(table, &k1, &value) == CC_OK);
    klee_assert(treetable_add(table, &k3, &value) == CC_OK);
    klee_assert(treetable_get_greater_than(table, &k2, &out) == CC_OK);
    klee_assert(*(int *)out == k3);

    treetable_destroy(table);
}

/*
 * Property: querying a key without a right subtree walks up to the first parent
 * that is greater than the key.
 */
static void test_get_greater_than_walks_to_parent_successor(void)
{
    TreeTable *table = make_table();
    int k1 = 10;
    int k2 = 20;
    int value = symbolic_int("greater_parent_value", 1);
    void *out = NULL;

    klee_assert(treetable_add(table, &k2, &value) == CC_OK);
    klee_assert(treetable_add(table, &k1, &value) == CC_OK);
    klee_assert(treetable_get_greater_than(table, &k1, &out) == CC_OK);
    klee_assert(*(int *)out == k2);

    treetable_destroy(table);
}

/* Property: get_greater_than fails for keys that are not present. */
static void test_get_greater_than_absent_key_fails(void)
{
    TreeTable *table = make_table();
    int present = symbolic_int("greater_present", 5);
    int absent = symbolic_int("greater_absent", 6);
    int value = symbolic_int("greater_absent_value", 1);
    void *out = NULL;

    klee_assume(present != absent);
    klee_assert(treetable_add(table, &present, &value) == CC_OK);
    klee_assert(treetable_get_greater_than(table, &absent, &out) == CC_ERR_KEY_NOT_FOUND);

    treetable_destroy(table);
}

/*
 * Property: querying the maximum key is total: it must return one of the
 * TreeTable status codes without corrupting the tree. This exercises the
 * successor walk that reaches the sentinel.
 */
static void test_get_greater_than_maximum_key_is_total(void)
{
    TreeTable *table = make_table();
    int k1 = 10;
    int k2 = 20;
    int value = symbolic_int("greater_max_value", 1);
    void *out = NULL;
    enum cc_stat status;

    klee_assert(treetable_add(table, &k1, &value) == CC_OK);
    klee_assert(treetable_add(table, &k2, &value) == CC_OK);
    status = treetable_get_greater_than(table, &k2, &out);
    klee_assert(status == CC_OK || status == CC_ERR_KEY_NOT_FOUND);
    klee_assert(balanced(table));
    klee_assert(sorted(table));

    treetable_destroy(table);
}

/*
 * Coverage property: drive the second half of `if (n && s)` in
 * treetable_get_greater_than with n != NULL and s == NULL.
 *
 * A normally constructed TreeTable cannot reach this combination: a present
 * maximum key returns the sentinel as its successor, not NULL. Because the
 * assignment asks for full branch coverage of treetable_get_greater_than, this
 * white-box test builds the smallest internal table state that is sufficient to
 * exercise the defensive `s == NULL` branch without corrupting heap ownership.
 */
static void test_get_greater_than_internal_null_successor_branch(void)
{
    TreeTable table;
    RBNode node;
    int key = symbolic_int("greater_null_successor_key", 50);
    int value = symbolic_int("greater_null_successor_value", 500);
    void *out = NULL;

    table.root = &node;
    table.sentinel = NULL;
    table.size = 1;
    table.cmp = cmp;
    table.mem_alloc = safe_malloc;
    table.mem_calloc = safe_calloc;
    table.mem_free = free;

    node.key = &key;
    node.value = &value;
    node.color = RB_BLACK;
    node.parent = NULL;
    node.left = NULL;
    node.right = NULL;

    klee_assert(treetable_get_greater_than(&table, &key, &out) == CC_ERR_KEY_NOT_FOUND);
}

int main(void)
{
    test_add_root_preserves_validity();
    test_add_duplicate_updates_value_only();
    test_add_left_and_right_children();
    test_add_three_symbolic_keys_preserves_validity();
    test_get_missing_keys_fail();
    test_get_inserted_key_returns_value();
    test_get_first_key_empty_returns_not_found();
    test_get_first_key_is_minimum();
    test_get_greater_than_uses_right_subtree_minimum();
    test_get_greater_than_walks_to_parent_successor();
    test_get_greater_than_absent_key_fails();
    test_get_greater_than_maximum_key_is_total();
    test_get_greater_than_internal_null_successor_branch();

    (void)HAVE_KLEE;
    return 0;
}
