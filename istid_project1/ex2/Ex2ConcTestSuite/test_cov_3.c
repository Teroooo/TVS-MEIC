/*
 * Property group: order query behavior: first-key and/or successor queries follow tree ordering.
 * Source minimized input: id:000007,src:000004,time:629,execs:8001,op:havoc,rep:4,+cov
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

    keys[add_index] = 1180458076;
    values[add_index] = -10724259;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 1558076160;
    values[add_index] = 1549556828;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 1549616732;
    values[add_index] = 1113948;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 1549556958; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = 1549556828;
    values[add_index] = 1549557062;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 1549556828; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = 1549616732;
    values[add_index] = 1549598556;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;

    treetable_destroy(table);
    return 0;
}
