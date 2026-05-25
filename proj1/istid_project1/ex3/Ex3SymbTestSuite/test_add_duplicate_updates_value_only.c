/*
 * test_add_duplicate_updates_value_only.c
 *
 * PROPERTY: Adding a key that is already present in the TreeTable updates
 * its associated value without changing the size of the tree, and the tree
 * remains balanced and sorted.
 *
 * KLEE build (from Ex3SymbTestSuite/):
 *   clang -I. -I../../ex2 -emit-llvm -c -g -O0 -Xclang -disable-O0-optnone \
 *         test_add_duplicate_updates_value_only.c \
 *         -o test_add_duplicate_updates_value_only.bc
 *   klee test_add_duplicate_updates_value_only.bc
 */

#include <assert.h>
#include "klee_helpers.h"

void test_add_duplicate_updates_value_only(void)
{
    int key       = symbolic_int("dup_key",    11);
    int old_value = symbolic_int("old_value",   1);
    int new_value = symbolic_int("new_value",   2);
    void *out     = NULL;

    TreeTable *table = make_table();

    klee_assert(treetable_add(table, &key, &old_value) == CC_OK);
    klee_assert(treetable_add(table, &key, &new_value) == CC_OK);

    /* Size must not grow on a duplicate insert. */
    klee_assert(treetable_size(table) == 1);

    /* Lookup must return the new value. */
    klee_assert(treetable_get(table, &key, &out) == CC_OK);
    klee_assert(out == &new_value);

    klee_assert(balanced(table));
    klee_assert(sorted(table));

    treetable_destroy(table);
}

int main(void)
{
    test_add_duplicate_updates_value_only();
    return 0;
}
