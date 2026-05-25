/*
 * test_get_first_key_is_minimum.c
 *
 * PROPERTY: treetable_get_first_key always returns a pointer to the
 * minimum key in the tree — i.e. a key that is less than or equal to
 * every other inserted key.
 *
 * Three pairwise-distinct symbolic keys are inserted and all six orderings
 * are explored by KLEE through its path enumeration.
 *
 * KLEE build (from Ex3SymbTestSuite/):
 *   clang -I. -I../../ex2 -emit-llvm -c -g -O0 -Xclang -disable-O0-optnone \
 *         test_get_first_key_is_minimum.c -o test_get_first_key_is_minimum.bc
 *   klee test_get_first_key_is_minimum.bc
 */

#include <assert.h>
#include "klee_helpers.h"

void test_get_first_key_is_minimum(void)
{
    int k1    = symbolic_int("first_k1",    30);
    int k2    = symbolic_int("first_k2",    10);
    int k3    = symbolic_int("first_k3",    20);
    int value = symbolic_int("first_value",  3);
    void *out = NULL;

    klee_assume(k1 != k2);
    klee_assume(k1 != k3);
    klee_assume(k2 != k3);

    TreeTable *table = make_table();

    klee_assert(treetable_add(table, &k1, &value) == CC_OK);
    klee_assert(treetable_add(table, &k2, &value) == CC_OK);
    klee_assert(treetable_add(table, &k3, &value) == CC_OK);

    klee_assert(treetable_get_first_key(table, &out) == CC_OK);

    /* The returned key must be <= every inserted key. */
    klee_assert(*(int *)out <= k1);
    klee_assert(*(int *)out <= k2);
    klee_assert(*(int *)out <= k3);

    treetable_destroy(table);
}

int main(void)
{
    test_get_first_key_is_minimum();
    return 0;
}
