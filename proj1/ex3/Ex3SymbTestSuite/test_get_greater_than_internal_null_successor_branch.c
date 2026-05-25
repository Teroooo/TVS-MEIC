/*
 * test_get_greater_than_internal_null_successor_branch.c
 *
 * PROPERTY (white-box / branch-coverage): Exercise the defensive
 * `if (n && s)` branch in treetable_get_greater_than for the case where
 * n != NULL but s == NULL.
 *
 * A normally constructed TreeTable cannot reach this combination, because
 * the implementation always returns the sentinel (not NULL) as the
 * successor of the rightmost node. This white-box test constructs the
 * minimal internal state that exercises the branch directly, without
 * corrupting heap ownership.
 *
 * This test is required for full branch coverage of treetable_get_greater_than.
 *
 * KLEE build (from Ex3SymbTestSuite/):
 *   clang -I. -I../../ex2 -emit-llvm -c -g -O0 -Xclang -disable-O0-optnone \
 *         test_get_greater_than_internal_null_successor_branch.c \
 *         -o test_get_greater_than_internal_null_successor_branch.bc
 *   klee test_get_greater_than_internal_null_successor_branch.bc
 */

#include <assert.h>
#include "klee_helpers.h"

void test_get_greater_than_internal_null_successor_branch(void)
{
    TreeTable table;
    RBNode    node;
    int key   = symbolic_int("greater_null_successor_key",   50);
    int value = symbolic_int("greater_null_successor_value", 500);
    void *out = NULL;

    /* Minimal table state: single node, NULL sentinel. */
    table.root       = &node;
    table.sentinel   = NULL;
    table.size       = 1;
    table.cmp        = cmp;
    table.mem_alloc  = safe_malloc;
    table.mem_calloc = safe_calloc;
    table.mem_free   = free;

    node.key    = &key;
    node.value  = &value;
    node.color  = RB_BLACK;
    node.parent = NULL;
    node.left   = NULL;
    node.right  = NULL;

    klee_assert(treetable_get_greater_than(&table, &key, &out)
                == CC_ERR_KEY_NOT_FOUND);
}

int main(void)
{
    test_get_greater_than_internal_null_successor_branch();
    return 0;
}
