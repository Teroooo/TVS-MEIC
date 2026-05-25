/*
 * Crash property: replay of AFL++ crash input.
 * Source input: id:000006,sig:06,src:000015,time:3078,execs:46009,op:havoc,rep:4
 * Input bytes: 109, replayed commands: 12
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
    int keys[7];
    int values[7];
    size_t add_index = 0;

    assert(treetable_new(&table) == CC_OK);

    keys[add_index] = -1751343972;
    values[add_index] = 14720156;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1751672937;
    values[add_index] = -1667440489;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1663019193;
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
    { int key = 14720156; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -1166567524;
    values[add_index] = 2054847098;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    treetable_get_first_key(table, &out);
    treetable_get_first_key(table, &out);
    treetable_get_first_key(table, &out);
    keys[add_index] = 1107296167;
    values[add_index] = 1631666497;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 2054840674; treetable_get(table, &key, &out); }

    (void)add_index;
    treetable_destroy(table);
    return 0;
}
