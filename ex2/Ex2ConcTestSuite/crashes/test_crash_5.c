/*
 * Crash property: replay of AFL++ crash input.
 * Source input: id:000004,sig:06,src:000012,time:2644,execs:40007,op:havoc,rep:6
 * Input bytes: 73, replayed commands: 8
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

    keys[add_index] = -1751344000;
    values[add_index] = 14720156;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1751672937;
    values[add_index] = -2020089705;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1751654244;
    values[add_index] = -1751663977;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1666772992;
    values[add_index] = 1096238748;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 1633763649; treetable_get(table, &key, &out); }
    keys[add_index] = -1667459177;
    values[add_index] = -1667475368;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1483170692;
    values[add_index] = 1094844415;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 1633771841; treetable_get(table, &key, &out); }

    (void)add_index;
    treetable_destroy(table);
    return 0;
}
