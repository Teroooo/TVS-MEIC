/*
 * Property group: order query behavior: first-key and/or successor queries follow tree ordering.
 * Source minimized input: id:000015,src:000014,time:2037,execs:28003,op:havoc,rep:17,+cov
 */

#include <assert.h>

#include "../treetable.h"

int balanced(TreeTable *t);
int sorted(TreeTable *t);

int main(void)
{
    TreeTable *table = NULL;
    void *out = NULL;
    int keys[9];
    int values[9];
    size_t add_index = 0;

    assert(treetable_new(&table) == CC_OK);

    keys[add_index] = 1180458076;
    values[add_index] = -10701724;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -564437916; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = 1094795568;
    values[add_index] = 1549885761;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 1549556828;
    values[add_index] = 1549616732;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 1281122559;
    values[add_index] = 1012685916;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 1564892252;
    values[add_index] = 1180458076;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 285170780; treetable_get(table, &key, &out); }
    keys[add_index] = -1515870811;
    values[add_index] = -1515862619;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 1549622364; treetable_get(table, &key, &out); }
    { int key = 1549556958; treetable_get_greater_than(table, &key, &out); }
    treetable_get_first_key(table, &out);
    keys[add_index] = 1549556828;
    values[add_index] = 1549556828;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 1549556828;
    values[add_index] = 1549556828;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1515889572;
    values[add_index] = 807010213;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;

    treetable_destroy(table);
    return 0;
}
