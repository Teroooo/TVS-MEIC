/*
 * test_add_three_symbolic_keys_preserves_validity.c
 *
 * PROPERTY: Inserting three pairwise-distinct symbolic keys always produces
 * a balanced and sorted TreeTable of size 3, regardless of their relative
 * ordering. This covers all rotation and recolouring cases in the RB-tree
 * insertion path that are reachable with three keys.
 *
 * KLEE explores up to 6 distinct orderings of (k1, k2, k3), each of which
 * may trigger different rebalancing branches inside treetable_add.
 *
 * KLEE build (from Ex3SymbTestSuite/):
 *   clang -I. -I../../ex2 -emit-llvm -c -g -O0 -Xclang -disable-O0-optnone \
 *         test_add_three_symbolic_keys_preserves_validity.c \
 *         -o test_add_three_symbolic_keys_preserves_validity.bc
 *   klee test_add_three_symbolic_keys_preserves_validity.bc
 */

#include <assert.h>
#include "klee_helpers.h"

void test_add_three_symbolic_keys_preserves_validity(void)
{
    int k1 = symbolic_int("three_k1", 30);
    int k2 = symbolic_int("three_k2", 10);
    int k3 = symbolic_int("three_k3", 20);
    int v1 = symbolic_int("three_v1",  1);
    int v2 = symbolic_int("three_v2",  2);
    int v3 = symbolic_int("three_v3",  3);

    klee_assume(k1 != k2);
    klee_assume(k1 != k3);
    klee_assume(k2 != k3);

    TreeTable *table = make_table();

    klee_assert(treetable_add(table, &k1, &v1) == CC_OK);
    klee_assert(treetable_add(table, &k2, &v2) == CC_OK);
    klee_assert(treetable_add(table, &k3, &v3) == CC_OK);

    klee_assert(treetable_size(table) == 3);
    klee_assert(balanced(table));
    klee_assert(sorted(table));

    treetable_destroy(table);
}

int main(void)
{
    test_add_three_symbolic_keys_preserves_validity();
    return 0;
}
