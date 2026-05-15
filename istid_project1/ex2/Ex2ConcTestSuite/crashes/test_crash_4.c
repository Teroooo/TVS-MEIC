/*
 * Crash property: replay of AFL++ crash input.
 * Source input: id:000003,sig:06,src:000012,time:2419,execs:37006,op:havoc,rep:7
 * Input bytes: 116, replayed commands: 12
 * Ignored trailing bytes: 8
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
    int keys[8];
    int values[8];
    size_t add_index = 0;

    assert(treetable_new(&table) == CC_OK);

    keys[add_index] = -1751383908;
    values[add_index] = 14720156;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1751695209;
    values[add_index] = -1751654249;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1751654244;
    values[add_index] = -1751672937;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    treetable_get_first_key(table, &out);
    keys[add_index] = -1751344128;
    values[add_index] = -1746887552;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1751672937; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = 1692424006;
    values[add_index] = -1751673024;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    treetable_get_first_key(table, &out);
    keys[add_index] = 1464245404;
    values[add_index] = 1094795585;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 174154081; treetable_get(table, &key, &out); }
    keys[add_index] = -1671931748;
    values[add_index] = -1669555044;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 1107296167;
    values[add_index] = 1631666498;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;

    (void)add_index;
    treetable_destroy(table);
    return 0;
}
