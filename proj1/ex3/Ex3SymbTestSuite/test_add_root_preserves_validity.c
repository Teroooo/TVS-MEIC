/*
 * test_add_root_preserves_validity.c
 *
 * PROPERTY: Inserting a single key into an empty TreeTable produces a
 * structurally valid, balanced, and sorted one-element tree.
 *
 * KLEE build (from Ex3SymbTestSuite/):
 *   clang -I. -I../../ex2 -emit-llvm -c -g -O0 -Xclang -disable-O0-optnone \
 *         test_add_root_preserves_validity.c -o test_add_root_preserves_validity.bc
 *   klee test_add_root_preserves_validity.bc
 */

#include <assert.h>
#include "klee_helpers.h"

void test_add_root_preserves_validity(void)
{
    int key   = symbolic_int("root_key",   10);
    int value = symbolic_int("root_value", 100);

    TreeTable *table = make_table();

    klee_assert(treetable_add(table, &key, &value) == CC_OK);
    klee_assert(treetable_size(table) == 1);
    klee_assert(balanced(table));
    klee_assert(sorted(table));

    treetable_destroy(table);
}

int main(void)
{
    test_add_root_preserves_validity();
    return 0;
}
