/*
 * test_add_left_and_right_children.c
 *
 * PROPERTY: Adding two distinct symbolic keys preserves ordering regardless
 * of whether the second key is inserted to the left (k2 < k1) or to the
 * right (k2 > k1) of the root. Both orderings must leave the tree balanced
 * and sorted with exactly two elements.
 *
 * KLEE explores two paths (k2 < k1 and k2 > k1) because the comparison
 * inside treetable_add branches on the relative order of k1 and k2.
 *
 * KLEE build (from Ex3SymbTestSuite/):
 *   clang -I. -I../../ex2 -emit-llvm -c -g -O0 -Xclang -disable-O0-optnone \
 *         test_add_left_and_right_children.c \
 *         -o test_add_left_and_right_children.bc
 *   klee test_add_left_and_right_children.bc
 */

#include <assert.h>
#include "klee_helpers.h"

void test_add_left_and_right_children(void)
{
    int k1 = symbolic_int("two_k1", 20);
    int k2 = symbolic_int("two_k2", 10);
    int v1 = symbolic_int("two_v1",  1);
    int v2 = symbolic_int("two_v2",  2);

    /* Restrict to two genuinely distinct keys so we always get size == 2. */
    klee_assume(k1 != k2);

    TreeTable *table = make_table();

    klee_assert(treetable_add(table, &k1, &v1) == CC_OK);
    klee_assert(treetable_add(table, &k2, &v2) == CC_OK);

    klee_assert(treetable_size(table) == 2);
    klee_assert(balanced(table));
    klee_assert(sorted(table));

    treetable_destroy(table);
}

int main(void)
{
    test_add_left_and_right_children();
    return 0;
}
