/*
 * Property: replay of minimized AFL++ input preserving the API-call
 * sequence and checking invariants after state-modifying operations.
 * Source minimized input: id:000018,src:000017,time:9740,execs:149033,op:havoc,rep:20,+cov
 */

#include <assert.h>

#include "../treetable.h"

int balanced(TreeTable *t);
int sorted(TreeTable *t);

int main(void)
{
    TreeTable *table = NULL;
    void *out = NULL;
    int keys[11];
    int values[11];
    size_t add_index = 0;

    assert(treetable_new(&table) == CC_OK);

    keys[add_index] = -1633904745;
    values[add_index] = -1670621086;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 1482202268;
    values[add_index] = 2090638492;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -22628;
    values[add_index] = -1667457918;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1667461732;
    values[add_index] = -1757413152;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 1482849943; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -1667475368;
    values[add_index] = -1667466230;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1669136385; treetable_get_greater_than(table, &key, &out); }
    { int key = -1751672937; treetable_get_greater_than(table, &key, &out); }
    { int key = -1516791938; treetable_get_greater_than(table, &key, &out); }
    { int key = -1751672937; treetable_get(table, &key, &out); }
    { int key = -1660977253; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = 10255511;
    values[add_index] = -1365468159;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -520159078;
    values[add_index] = -1768450153;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    treetable_get_first_key(table, &out);
    { int key = 1083676567; treetable_get_greater_than(table, &key, &out); }
    { int key = -1671931748; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -1667457892;
    values[add_index] = -526607209;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1751672937; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -531151204;
    values[add_index] = -1667786908;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1667457960;
    values[add_index] = -1666740837;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1667457960;
    values[add_index] = 1631666588;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;

    treetable_destroy(table);
    return 0;
}
