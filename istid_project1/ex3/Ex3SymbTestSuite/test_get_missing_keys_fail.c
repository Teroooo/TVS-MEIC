/*
 * test_get_missing_keys_fail.c
 *
 * PROPERTY: treetable_get returns CC_ERR_KEY_NOT_FOUND for any key that
 * was never inserted — both on an empty tree and on a non-empty tree.
 *
 * Two failure scenarios are exercised:
 *   1. Query on an empty tree (trivial not-found).
 *   2. Query for a key that is distinct from every inserted key.
 *
 * KLEE build (from Ex3SymbTestSuite/):
 *   clang -I. -I../../ex2 -emit-llvm -c -g -O0 -Xclang -disable-O0-optnone \
 *         test_get_missing_keys_fail.c -o test_get_missing_keys_fail.bc
 *   klee test_get_missing_keys_fail.bc
 */

#include <assert.h>
#include "klee_helpers.h"

void test_get_missing_keys_fail(void)
{
    int absent  = symbolic_int("get_absent_empty",    99);
    int present = symbolic_int("get_present",         10);
    int other   = symbolic_int("get_absent_nonempty", 20);
    int value   = symbolic_int("get_value",           42);
    void *out   = NULL;

    klee_assume(present != other);

    TreeTable *table = make_table();

    /* 1. Empty tree: any key should be not found. */
    klee_assert(treetable_get(table, &absent, &out) == CC_ERR_KEY_NOT_FOUND);

    /* Insert 'present', then look up a different key 'other'. */
    klee_assert(treetable_add(table, &present, &value) == CC_OK);

    /* 2. Non-empty tree: key different from the only element is not found. */
    klee_assert(treetable_get(table, &other, &out) == CC_ERR_KEY_NOT_FOUND);

    treetable_destroy(table);
}

int main(void)
{
    test_get_missing_keys_fail();
    return 0;
}
