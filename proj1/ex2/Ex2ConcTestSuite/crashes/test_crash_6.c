/*
 * Crash property: replay of AFL++ crash input.
 * Source input: id:000005,sig:06,src:000014,time:2860,execs:43008,op:havoc,rep:56
 * Input bytes: 202, replayed commands: 22
 * Ignored trailing bytes: 4
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
    int keys[9];
    int values[9];
    size_t add_index = 0;

    assert(treetable_new(&table) == CC_OK);

    keys[add_index] = 1073781916;
    values[add_index] = 2123863938;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1751664009; treetable_get_greater_than(table, &key, &out); }
    treetable_get_first_key(table, &out);
    keys[add_index] = 1482184754;
    values[add_index] = -2147471272;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 10261276;
    values[add_index] = 1348559104;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 75208512;
    values[add_index] = 1936955136;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 1936946035; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -1667457962;
    values[add_index] = 808474780;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1751695360;
    values[add_index] = 2006417047;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    treetable_get_first_key(table, &out);
    treetable_get_first_key(table, &out);
    keys[add_index] = 16724056;
    values[add_index] = -1677787136;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 1110776373; treetable_get_greater_than(table, &key, &out); }
    treetable_get_first_key(table, &out);
    { int key = -1679753059; treetable_get(table, &key, &out); }
    { int key = 1650614850; treetable_get(table, &key, &out); }
    keys[add_index] = 1650614882;
    values[add_index] = 1482184754;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 1936928816;
    values[add_index] = -520053491;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 439721090; treetable_get_greater_than(table, &key, &out); }
    treetable_get_first_key(table, &out);
    { int key = -1667464549; treetable_get(table, &key, &out); }
    { int key = 1078018392; treetable_get_greater_than(table, &key, &out); }

    (void)add_index;
    treetable_destroy(table);
    return 0;
}
