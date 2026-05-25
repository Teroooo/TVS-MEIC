/*
 * Property: replay of minimized AFL++ input preserving the API-call
 * sequence and checking invariants after state-modifying operations.
 * Source minimized input: id:000020,src:000017,time:24988,execs:349147,op:havoc,rep:37,+cov
 */

#include <assert.h>

#include "../treetable.h"

int balanced(TreeTable *t);
int sorted(TreeTable *t);

int main(void)
{
    TreeTable *table = NULL;
    void *out = NULL;
    int keys[10];
    int values[10];
    size_t add_index = 0;

    assert(treetable_new(&table) == CC_OK);

    keys[add_index] = -1667459177;
    values[add_index] = -1667457897;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1667785572;
    values[add_index] = 319644;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1667786857; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -1667457892;
    values[add_index] = -1667457892;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1667457892;
    values[add_index] = -531168768;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1667459177;
    values[add_index] = -1751672864;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1667459177; treetable_get_greater_than(table, &key, &out); }
    { int key = -1751685940; treetable_get(table, &key, &out); }
    { int key = -90728558; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -1667457892;
    values[add_index] = -1667457892;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1751671652;
    values[add_index] = -1754753129;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1746888809; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -1665950632;
    values[add_index] = -1667457892;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 848792727;
    values[add_index] = -1751672988;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1753311350; treetable_get_greater_than(table, &key, &out); }
    { int key = -1751711489; treetable_get_greater_than(table, &key, &out); }
    { int key = -1650665217; treetable_get_greater_than(table, &key, &out); }
    { int key = -1751699200; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = 1464310940;
    values[add_index] = 94149856;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;

    treetable_destroy(table);
    return 0;
}
