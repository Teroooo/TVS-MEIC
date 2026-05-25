/*
 * Crash property: replay of AFL++ crash input.
 * Source input: id:000010,sig:06,src:000017,time:7447,execs:113025,op:havoc,rep:4
 * Input bytes: 181, replayed commands: 20
 * Ignored trailing bytes: 1
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
    int keys[6];
    int values[6];
    size_t add_index = 0;

    assert(treetable_new(&table) == CC_OK);

    keys[add_index] = -1667459177;
    values[add_index] = -1751672864;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    treetable_get_first_key(table, &out);
    { int key = -1749575785; treetable_get_greater_than(table, &key, &out); }
    { int key = -1751672937; treetable_get_greater_than(table, &key, &out); }
    { int key = -1751672937; treetable_get_greater_than(table, &key, &out); }
    { int key = -1751672937; treetable_get_greater_than(table, &key, &out); }
    { int key = -1751672962; treetable_get_greater_than(table, &key, &out); }
    { int key = -1751669353; treetable_get_greater_than(table, &key, &out); }
    { int key = -1667459177; treetable_get_greater_than(table, &key, &out); }
    { int key = 1094818913; treetable_get(table, &key, &out); }
    treetable_get_first_key(table, &out);
    keys[add_index] = 849124476;
    values[add_index] = -1750623140;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1751672937; treetable_get_greater_than(table, &key, &out); }
    { int key = -6842498; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = 1633763649;
    values[add_index] = -1760927391;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 1482202268; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -1671679332;
    values[add_index] = -1667457881;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1751672937;
    values[add_index] = -1667464555;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1483891812;
    values[add_index] = 1637636184;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 1094818913; treetable_get(table, &key, &out); }

    (void)add_index;
    treetable_destroy(table);
    return 0;
}
