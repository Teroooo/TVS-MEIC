/*
 * test_get_greater_than_absent_key_fails.c
 *
 * PROPERTY: treetable_get_greater_than returns CC_ERR_KEY_NOT_FOUND when
 * called with a key that is not present in the tree. The lookup must
 * terminate without crashing or returning garbage.
 *
 * KLEE explores two symbolic paths: one where present < absent and one
 * where present > absent, exercising both sides of the comparison inside
 * the search loop.
 *
 * KLEE build (from Ex3SymbTestSuite/):
 *   clang -I. -I../../ex2 -emit-llvm -c -g -O0 -Xclang -disable-O0-optnone \
 *         test_get_greater_than_absent_key_fails.c \
 *         -o test_get_greater_than_absent_key_fails.bc
 *   klee test_get_greater_than_absent_key_fails.bc
 */

#include <assert.h>
#include "klee_helpers.h"

void test_get_greater_than_absent_key_fails(void)
{
    int present = symbolic_int("greater_present",       5);
    int absent  = symbolic_int("greater_absent",        6);
    int value   = symbolic_int("greater_absent_value",  1);
    void *out   = NULL;

    klee_assume(present != absent);

    TreeTable *table = make_table();

    klee_assert(treetable_add(table, &present, &value) == CC_OK);
    klee_assert(treetable_get_greater_than(table, &absent, &out)
                == CC_ERR_KEY_NOT_FOUND);

    treetable_destroy(table);
}

int main(void)
{
    test_get_greater_than_absent_key_fails();
    return 0;
}
