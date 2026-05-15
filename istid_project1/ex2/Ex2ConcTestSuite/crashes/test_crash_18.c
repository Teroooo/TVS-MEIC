/*
 * Crash property: replay of AFL++ crash input.
 * Source input: id:000017,sig:06,src:000017,time:22582,execs:316132,op:havoc,rep:24
 * Input bytes: 218, replayed commands: 24
 * Ignored trailing bytes: 2
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
    int keys[12];
    int values[12];
    size_t add_index = 0;

    assert(treetable_new(&table) == CC_OK);

    keys[add_index] = -1753311337;
    values[add_index] = -1751646313;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1667786857; treetable_get_greater_than(table, &key, &out); }
    { int key = -1265133808; treetable_get(table, &key, &out); }
    keys[add_index] = -522133280;
    values[add_index] = -522133280;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -387915552;
    values[add_index] = -522133280;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -522133280;
    values[add_index] = -522133280;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1751672937;
    values[add_index] = -1667459177;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1751343972;
    values[add_index] = -1746887524;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -526936169; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = 1637631832;
    values[add_index] = 1100767585;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 1633771873; treetable_get(table, &key, &out); }
    keys[add_index] = -1667475368;
    values[add_index] = 1094818913;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1744987039; treetable_get(table, &key, &out); }
    keys[add_index] = 1754765212;
    values[add_index] = -1751672937;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1667786853; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -1751654244;
    values[add_index] = -526936169;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1667453545; treetable_get_greater_than(table, &key, &out); }
    { int key = -359229545; treetable_get(table, &key, &out); }
    { int key = 9934743; treetable_get(table, &key, &out); }
    { int key = -1751672937; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = 1487375771;
    values[add_index] = 1633787224;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1673051500; treetable_get(table, &key, &out); }
    { int key = 1633771841; treetable_get(table, &key, &out); }
    keys[add_index] = -1671923044;
    values[add_index] = 1633771841;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;

    (void)add_index;
    treetable_destroy(table);
    return 0;
}
