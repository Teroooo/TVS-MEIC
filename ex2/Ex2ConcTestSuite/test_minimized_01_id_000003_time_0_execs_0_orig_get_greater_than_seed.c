/*
 * Property group: order query behavior: first-key and/or successor queries follow tree ordering.
 * Source minimized input: id:000003,time:0,execs:0,orig:get_greater_than.seed
 */

#include <assert.h>

#include "../treetable.h"

int balanced(TreeTable *t);
int sorted(TreeTable *t);

int main(void)
{
    TreeTable *table = NULL;
    void *out = NULL;
    int keys[2];
    int values[2];
    size_t add_index = 0;

    assert(treetable_new(&table) == CC_OK);

    keys[add_index] = 1094795585;
    values[add_index] = 1633771873;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 1111638594;
    values[add_index] = 1650614882;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 1094795585; treetable_get_greater_than(table, &key, &out); }

    treetable_destroy(table);
    return 0;
}
