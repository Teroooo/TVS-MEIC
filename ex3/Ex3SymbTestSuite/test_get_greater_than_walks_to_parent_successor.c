/*
 * test_get_greater_than_walks_to_parent_successor.c
 *
 * PROPERTY: When the queried key has no right subtree, treetable_get_greater_than
 * walks up the ancestor chain until it finds a node that is strictly greater
 * than the queried key (the "parent successor" branch).
 *
 * Tree {10, 20}: querying key 10 (a leaf with no right child) must return 20,
 * because the algorithm must ascend to the root to find the first ancestor
 * that is greater.
 *
 * KLEE build (from Ex3SymbTestSuite/):
 *   clang -I. -I../../ex2 -emit-llvm -c -g -O0 -Xclang -disable-O0-optnone \
 *         test_get_greater_than_walks_to_parent_successor.c \
 *         -o test_get_greater_than_walks_to_parent_successor.bc
 *   klee test_get_greater_than_walks_to_parent_successor.bc
 */

#include <assert.h>
#include "klee_helpers.h"

void test_get_greater_than_walks_to_parent_successor(void)
{
    int k1    = 10;
    int k2    = 20;
    int value = symbolic_int("greater_parent_value", 1);
    void *out = NULL;

    TreeTable *table = make_table();

    klee_assert(treetable_add(table, &k2, &value) == CC_OK);
    klee_assert(treetable_add(table, &k1, &value) == CC_OK);

    klee_assert(treetable_get_greater_than(table, &k1, &out) == CC_OK);
    klee_assert(*(int *)out == k2);

    treetable_destroy(table);
}

int main(void)
{
    test_get_greater_than_walks_to_parent_successor();
    return 0;
}
