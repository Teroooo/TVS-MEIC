/*
 * Crash property: replay of AFL++ crash input.
 * Source input: id:000011,sig:06,src:000018,time:12402,execs:178066,op:havoc,rep:17
 * Input bytes: 259, replayed commands: 28
 * Ignored trailing bytes: 7
 */

#include <assert.h>
#include <stddef.h>

#include "../../treetable.h"

int balanced(TreeTable *t);
int sorted(TreeTable *t);

int main(void)
{
    TreeTable *table = NULL;
    void *out = NULL;
    int keys[17];
    int values[17];
    size_t add_index = 0;

    assert(treetable_new(&table) == CC_OK);

    keys[add_index] = -1635084393;
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
    values[add_index] = -1365468030;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1667461732;
    values[add_index] = -1749090080;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 1482849943;
    values[add_index] = -1667457940;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1667475368;
    values[add_index] = -1751654313;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1667786857; treetable_get_greater_than(table, &key, &out); }
    { int key = 1482203804; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -1676630116;
    values[add_index] = 1486658716;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1667457892;
    values[add_index] = -1667457892;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 1117559964;
    values[add_index] = -1751654313;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 1482203804; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -1676630116;
    values[add_index] = 178035868;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -5792612;
    values[add_index] = 127;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1751671652;
    values[add_index] = -1751672937;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 2123863959; treetable_get_greater_than(table, &key, &out); }
    { int key = -2019190889; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -1684564073;
    values[add_index] = 1201471359;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1746893160; treetable_get(table, &key, &out); }
    keys[add_index] = -1700483428;
    values[add_index] = -1746878720;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1746233705; treetable_get_greater_than(table, &key, &out); }
    { int key = -1757374569; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = 1637636184;
    values[add_index] = -1667464095;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1751343972;
    values[add_index] = -1746887524;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1751672937; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -1667457892;
    values[add_index] = 1692424006;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 1486658711; treetable_get_greater_than(table, &key, &out); }
    { int key = 1486348439; treetable_get_greater_than(table, &key, &out); }

    (void)add_index;
    treetable_destroy(table);
    return 0;
}
