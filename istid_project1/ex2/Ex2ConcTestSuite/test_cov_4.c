/*
 * Property: replay of minimized AFL++ input preserving the API-call
 * sequence and checking invariants after state-modifying operations.
 * Source minimized input: id:000009,src:000006,time:1138,execs:16006,op:havoc,rep:6,+cov
 */

#include <assert.h>

#include "../treetable.h"

int balanced(TreeTable *t);
int sorted(TreeTable *t);

int main(void)
{
    TreeTable *table = NULL;
    void *out = NULL;
    int keys[3];
    int values[3];
    size_t add_index = 0;

    assert(treetable_new(&table) == CC_OK);

    keys[add_index] = -1667459177;
    values[add_index] = -1751672864;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1667459177; treetable_get_greater_than(table, &key, &out); }
    { int key = -1746887524; treetable_get_greater_than(table, &key, &out); }
    { int key = -1667457892; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -1667459177;
    values[add_index] = -1667475368;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1482908548;
    values[add_index] = -8388609;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;

    treetable_destroy(table);
    return 0;
}
