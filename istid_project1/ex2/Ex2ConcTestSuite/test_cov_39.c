/*
 * Property group: order query behavior: first-key and/or successor queries follow tree ordering.
 * Source minimized input: id:000005,src:000004,time:430,execs:5001,op:havoc,rep:2,+cov
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

    keys[add_index] = 1549556828;
    values[add_index] = -10724259;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 1549556828;
    values[add_index] = 1549557084;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -564461552; treetable_get_greater_than(table, &key, &out); }

    treetable_destroy(table);
    return 0;
}
