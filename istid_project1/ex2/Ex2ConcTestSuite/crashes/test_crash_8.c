/*
 * Crash property: replay of AFL++ crash input.
 * Source input: id:000007,sig:06,src:000010,time:3458,execs:51012,op:havoc,rep:2
 * Input bytes: 84, replayed commands: 9
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
    int keys[7];
    int values[7];
    size_t add_index = 0;

    assert(treetable_new(&table) == CC_OK);

    keys[add_index] = 8361879;
    values[add_index] = -1751711744;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 1482862748; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -1751632569;
    values[add_index] = -1672062752;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 893885596;
    values[add_index] = -1746888808;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -531150948;
    values[add_index] = -1751672937;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1667457897; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -1667457960;
    values[add_index] = 1464310940;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1667786857;
    values[add_index] = -1671931748;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1667470436;
    values[add_index] = -1667493721;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;

    (void)add_index;
    treetable_destroy(table);
    return 0;
}
