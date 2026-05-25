/*
 * Crash property: replay of AFL++ crash input.
 * Source input: id:000012,sig:06,src:000018,time:14329,execs:207073,op:havoc,rep:44
 * Input bytes: 264, replayed commands: 29
 * Ignored trailing bytes: 3
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
    int keys[14];
    int values[14];
    size_t add_index = 0;

    assert(treetable_new(&table) == CC_OK);

    keys[add_index] = -1751672937;
    values[add_index] = -218136833;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1667457892;
    values[add_index] = -526607219;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1751673024;
    values[add_index] = -1751673961;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1751672937; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -1751672937;
    values[add_index] = -1751672937;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1751672937; treetable_get_greater_than(table, &key, &out); }
    { int key = -1751672937; treetable_get_greater_than(table, &key, &out); }
    { int key = -1751672937; treetable_get_greater_than(table, &key, &out); }
    { int key = -1751672937; treetable_get_greater_than(table, &key, &out); }
    { int key = 1100807936; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -1365468159;
    values[add_index] = -520159078;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1667457897; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -1675584356;
    values[add_index] = 2139068297;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 2139062143; treetable_get_greater_than(table, &key, &out); }
    { int key = 2139127679; treetable_get_greater_than(table, &key, &out); }
    { int key = 2139062143; treetable_get_greater_than(table, &key, &out); }
    { int key = 2139062143; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -1667457892;
    values[add_index] = -1667457892;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1667459177; treetable_get(table, &key, &out); }
    keys[add_index] = -1516790628;
    values[add_index] = -1751672937;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 33593312; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = 2037148780;
    values[add_index] = 1819044972;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 1819044972; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -359229540;
    values[add_index] = -1751672937;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1751673085;
    values[add_index] = 1083676567;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1754425449;
    values[add_index] = -1671931748;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1677590431; treetable_get(table, &key, &out); }
    keys[add_index] = -1684234596;
    values[add_index] = 1486661517;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1667457892;
    values[add_index] = 1633763649;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;

    (void)add_index;
    treetable_destroy(table);
    return 0;
}
