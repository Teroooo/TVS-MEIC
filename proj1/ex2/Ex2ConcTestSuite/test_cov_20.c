/*
 * Property: replay of minimized AFL++ input preserving the API-call
 * sequence and checking invariants after state-modifying operations.
 * Source minimized input: id:000017,src:000009,time:7323,execs:111025,op:havoc,rep:28,+cov
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
    treetable_get_first_key(table, &out);
    { int key = -1751672937; treetable_get_greater_than(table, &key, &out); }
    { int key = -1751672937; treetable_get_greater_than(table, &key, &out); }
    { int key = -1751672937; treetable_get_greater_than(table, &key, &out); }
    { int key = -526936169; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = 1637636184;
    values[add_index] = 1100767585;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 1633771873; treetable_get(table, &key, &out); }
    keys[add_index] = -1667475368;
    values[add_index] = -1667466084;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    treetable_get_first_key(table, &out);
    { int key = -1751672937; treetable_get_greater_than(table, &key, &out); }
    { int key = -1667457793; treetable_get_greater_than(table, &key, &out); }
    { int key = -1667464553; treetable_get_greater_than(table, &key, &out); }
    { int key = 1637636184; treetable_get_greater_than(table, &key, &out); }

    treetable_destroy(table);
    return 0;
}
