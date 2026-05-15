/*
 * test_get_greater_than_maximum_key_is_total.c
 *
 * PROPERTY: Querying treetable_get_greater_than for the maximum key in the
 * tree is a total operation — it always returns a well-defined status code
 * (CC_OK or CC_ERR_KEY_NOT_FOUND) and never corrupts the tree. This
 * exercises the successor-walk that reaches the sentinel.
 *
 * KLEE build (from Ex3SymbTestSuite/):
 *   clang -I. -I../../ex2 -emit-llvm -c -g -O0 -Xclang -disable-O0-optnone \
 *         test_get_greater_than_maximum_key_is_total.c \
 *         -o test_get_greater_than_maximum_key_is_total.bc
 *   klee test_get_greater_than_maximum_key_is_total.bc
 */

#include <assert.h>
#include "klee_helpers.h"

void test_get_greater_than_maximum_key_is_total(void)
{
    int k1    = 10;
    int k2    = 20;
    int value = symbolic_int("greater_max_value", 1);
    void *out = NULL;
    enum cc_stat status;

    TreeTable *table = make_table();

    klee_assert(treetable_add(table, &k1, &value) == CC_OK);
    klee_assert(treetable_add(table, &k2, &value) == CC_OK);

    /* Query the maximum key: successor walk reaches the sentinel. */
    status = treetable_get_greater_than(table, &k2, &out);

    /* Must return one of the two documented status codes — no crash. */
    klee_assert(status == CC_OK || status == CC_ERR_KEY_NOT_FOUND);
    klee_assert(balanced(table));
    klee_assert(sorted(table));

    treetable_destroy(table);
}

int main(void)
{
    test_get_greater_than_maximum_key_is_total();
    return 0;
}
