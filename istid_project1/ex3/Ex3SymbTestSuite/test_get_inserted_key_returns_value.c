/*
 * test_get_inserted_key_returns_value.c
 *
 * PROPERTY: treetable_get returns CC_OK and the exact value pointer that
 * was supplied to treetable_add for any key that was previously inserted.
 *
 * KLEE build (from Ex3SymbTestSuite/):
 *   clang -I. -I../../ex2 -emit-llvm -c -g -O0 -Xclang -disable-O0-optnone \
 *         test_get_inserted_key_returns_value.c \
 *         -o test_get_inserted_key_returns_value.bc
 *   klee test_get_inserted_key_returns_value.bc
 */

#include <assert.h>
#include "klee_helpers.h"

void test_get_inserted_key_returns_value(void)
{
    int key   = symbolic_int("get_found_key",   7);
    int value = symbolic_int("get_found_value", 70);
    void *out = NULL;

    TreeTable *table = make_table();

    klee_assert(treetable_add(table, &key, &value) == CC_OK);

    /* The exact same value pointer must come back. */
    klee_assert(treetable_get(table, &key, &out) == CC_OK);
    klee_assert(out == &value);

    treetable_destroy(table);
}

int main(void)
{
    test_get_inserted_key_returns_value();
    return 0;
}
