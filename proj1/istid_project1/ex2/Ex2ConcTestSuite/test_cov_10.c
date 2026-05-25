/*
 * Property: replay of minimized AFL++ input preserving the API-call
 * sequence and checking invariants after state-modifying operations.
 * Source minimized input: id:000012,src:000009,time:2100,execs:32006,op:havoc,rep:14,+cov
 */

#include <assert.h>

#include "../treetable.h"

int balanced(TreeTable *t);
int sorted(TreeTable *t);

int main(void)
{
    TreeTable *table = NULL;
    void *out = NULL;
    int keys[5];
    int values[5];
    size_t add_index = 0;

    assert(treetable_new(&table) == CC_OK);

    keys[add_index] = -1751343972;
    values[add_index] = 14720156;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1751672937;
    values[add_index] = -1751654249;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1751654244;
    values[add_index] = -1751672937;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    treetable_get_first_key(table, &out);
    keys[add_index] = -1751695360;
    values[add_index] = 2006417047;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    treetable_get_first_key(table, &out);
    treetable_get_first_key(table, &out);
    { int key = -1754996726; treetable_get(table, &key, &out); }
    keys[add_index] = 2090638492;
    values[add_index] = -5793636;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 1094795585; treetable_get_greater_than(table, &key, &out); }

    treetable_destroy(table);
    return 0;
}
