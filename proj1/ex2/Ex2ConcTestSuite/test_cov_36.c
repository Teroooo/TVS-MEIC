/*
 * Property group: order query behavior: first-key and/or successor queries follow tree ordering.
 * Source minimized input: id:000025,src:000013,time:17014,execs:193060,op:havoc,rep:35,+cov
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

    keys[add_index] = 2130739200;
    values[add_index] = -1;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 1549533532;
    values[add_index] = 1648516422;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    treetable_get_first_key(table, &out);
    keys[add_index] = 1549556828;
    values[add_index] = 1547780417;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 759251248;
    values[add_index] = 1549556828;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 2136759389; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = 1560281088;
    values[add_index] = 285170752;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 1549590107;
    values[add_index] = 1549556828;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 1549556829;
    values[add_index] = -10724259;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -12166144;
    values[add_index] = 1214012508;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    treetable_get_first_key(table, &out);
    { int key = 1549556828; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = 1549556828;
    values[add_index] = 1094791260;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 1549556828; treetable_get(table, &key, &out); }
    { int key = 1549560668; treetable_get_greater_than(table, &key, &out); }
    { int key = 285212671; treetable_get_greater_than(table, &key, &out); }
    treetable_get_first_key(table, &out);
    keys[add_index] = 1543503964;
    values[add_index] = 1564892252;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 811096286; treetable_get_greater_than(table, &key, &out); }
    { int key = 1549556815; treetable_get(table, &key, &out); }

    treetable_destroy(table);
    return 0;
}
