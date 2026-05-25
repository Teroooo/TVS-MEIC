/*
 * Crash property: replay of AFL++ crash input.
 * Source input: id:000002,sig:05,src:000001,time:732,execs:10004,op:havoc,rep:11
 * Input bytes: 56, replayed commands: 6
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
    int keys[2];
    int values[2];
    size_t add_index = 0;

    assert(treetable_new(&table) == CC_OK);

    { int key = 809631615; treetable_get_greater_than(table, &key, &out); }
    treetable_get_first_key(table, &out);
    treetable_get_first_key(table, &out);
    keys[add_index] = 1649956952;
    values[add_index] = 1111643954;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    treetable_get_first_key(table, &out);
    keys[add_index] = 1479553072;
    values[add_index] = 808474712;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;

    (void)add_index;
    treetable_destroy(table);
    return 0;
}
