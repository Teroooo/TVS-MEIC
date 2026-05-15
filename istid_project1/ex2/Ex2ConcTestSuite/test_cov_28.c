/*
 * Property group: order query behavior: first-key and/or successor queries follow tree ordering.
 * Source minimized input: id:000021,src:000019,time:5536,execs:67015,op:havoc,rep:8,+cov
 */

#include <assert.h>

#include "../treetable.h"

int balanced(TreeTable *t);
int sorted(TreeTable *t);

int main(void)
{
    TreeTable *table = NULL;
    void *out = NULL;
    int keys[8];
    int values[8];
    size_t add_index = 0;

    assert(treetable_new(&table) == CC_OK);

    keys[add_index] = 1180458076;
    values[add_index] = -10701731;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -564437852; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = 1549556828;
    values[add_index] = 1549556828;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -582591396;
    values[add_index] = 1627348060;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 1549556796;
    values[add_index] = 1550146652;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 1549556737;
    values[add_index] = 1549557062;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -570359792; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = 1549556828;
    values[add_index] = 1549556991;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    treetable_get_first_key(table, &out);
    keys[add_index] = 22830172;
    values[add_index] = 1560280833;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    treetable_get_first_key(table, &out);
    keys[add_index] = 1549558007;
    values[add_index] = 1113948;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;

    treetable_destroy(table);
    return 0;
}
