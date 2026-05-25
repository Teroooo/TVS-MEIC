/*
 * test_get_first_key_empty_returns_not_found.c
 *
 * PROPERTY: treetable_get_first_key returns CC_ERR_KEY_NOT_FOUND on an
 * empty TreeTable.
 *
 * NOTE (known bug): The default treetable implementation leaves the
 * sentinel's children as NULL. Calling treetable_get_first_key on a
 * freshly-created empty tree therefore crashes rather than returning
 * CC_ERR_KEY_NOT_FOUND, because the traversal dereferences a NULL pointer.
 *
 * This test uses make_empty_table_with_safe_sentinel() — a white-box
 * workaround that makes the sentinel self-referential — so KLEE can reach
 * and cover the documented not-found branch. The actual crash is
 * reproduced and reported separately.
 *
 * KLEE build (from Ex3SymbTestSuite/):
 *   clang -I. -I../../ex2 -emit-llvm -c -g -O0 -Xclang -disable-O0-optnone \
 *         test_get_first_key_empty_returns_not_found.c \
 *         -o test_get_first_key_empty_returns_not_found.bc
 *   klee test_get_first_key_empty_returns_not_found.bc
 */

#include <assert.h>
#include "klee_helpers.h"

void test_get_first_key_empty_returns_not_found(void)
{
    TreeTable *table = make_empty_table_with_safe_sentinel();
    void *out = NULL;

    klee_assert(treetable_get_first_key(table, &out) == CC_ERR_KEY_NOT_FOUND);

    treetable_destroy(table);
}

int main(void)
{
    test_get_first_key_empty_returns_not_found();
    return 0;
}
