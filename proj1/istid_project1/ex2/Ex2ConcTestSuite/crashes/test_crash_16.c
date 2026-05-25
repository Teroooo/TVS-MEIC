/*
 * Crash property: replay of AFL++ crash input.
 * Source input: id:000015,sig:06,src:000015,time:17131,execs:238105,op:havoc,rep:4
 * Input bytes: 111, replayed commands: 12
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
    int keys[6];
    int values[6];
    size_t add_index = 0;

    assert(treetable_new(&table) == CC_OK);

    keys[add_index] = -1751343716;
    values[add_index] = -220160868;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1751672937; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -1663016377;
    values[add_index] = -64100;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1665491880;
    values[add_index] = -1482908548;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1667457892;
    values[add_index] = -1684327103;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1667457892; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -1751673024;
    values[add_index] = -1166567554;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    treetable_get_first_key(table, &out);
    treetable_get_first_key(table, &out);
    treetable_get_first_key(table, &out);
    keys[add_index] = -1669555074;
    values[add_index] = -22632;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 1631666497; treetable_get(table, &key, &out); }

    (void)add_index;
    treetable_destroy(table);
    return 0;
}
