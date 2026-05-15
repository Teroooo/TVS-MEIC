/*
 * test_get_greater_than_uses_right_subtree_minimum.c
 *
 * PROPERTY: When the queried key has a non-empty right subtree,
 * treetable_get_greater_than returns the minimum key of that right subtree
 * (i.e., the in-order successor is found by descending left in the right
 * subtree rather than walking upward).
 *
 * A concrete tree {10, 20, 30} is constructed; querying 20 must return 30
 * (the minimum of the right subtree rooted at 20's right child). A single
 * symbolic value (for the inserted values, not the keys) is introduced so
 * that KLEE can still explore any path inside the implementation that might
 * branch on value contents.
 *
 * KLEE build (from Ex3SymbTestSuite/):
 *   clang -I. -I../../ex2 -emit-llvm -c -g -O0 -Xclang -disable-O0-optnone \
 *         test_get_greater_than_uses_right_subtree_minimum.c \
 *         -o test_get_greater_than_uses_right_subtree_minimum.bc
 *   klee test_get_greater_than_uses_right_subtree_minimum.bc
 */

#include <assert.h>
#include "klee_helpers.h"

void test_get_greater_than_uses_right_subtree_minimum(void)
{
    int k1    = 10;
    int k2    = 20;
    int k3    = 30;
    int value = symbolic_int("greater_right_value", 1);
    void *out = NULL;

    TreeTable *table = make_table();

    klee_assert(treetable_add(table, &k2, &value) == CC_OK);
    klee_assert(treetable_add(table, &k1, &value) == CC_OK);
    klee_assert(treetable_add(table, &k3, &value) == CC_OK);

    klee_assert(treetable_get_greater_than(table, &k2, &out) == CC_OK);
    klee_assert(*(int *)out == k3);

    treetable_destroy(table);
}

int main(void)
{
    test_get_greater_than_uses_right_subtree_minimum();
    return 0;
}
