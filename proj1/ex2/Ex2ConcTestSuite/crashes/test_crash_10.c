/*
 * Crash property: replay of AFL++ crash input.
 * Source input: id:000009,sig:06,src:000015,time:6954,execs:106022,op:havoc,rep:32
 * Input bytes: 141, replayed commands: 15
 * Ignored trailing bytes: 6
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
    int keys[10];
    int values[10];
    size_t add_index = 0;

    assert(treetable_new(&table) == CC_OK);

    keys[add_index] = -1751802723;
    values[add_index] = 14720156;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1750624361;
    values[add_index] = -1667440489;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1663019193;
    values[add_index] = -1744894563;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 16777367;
    values[add_index] = -1667458048;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    treetable_get_first_key(table, &out);
    keys[add_index] = 0;
    values[add_index] = 0;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 0;
    values[add_index] = -1667497984;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1667457881;
    values[add_index] = 893498780;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1667459173; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -1761607456;
    values[add_index] = -1753311337;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 2054847156; treetable_get_greater_than(table, &key, &out); }
    treetable_get_first_key(table, &out);
    treetable_get_first_key(table, &out);
    keys[add_index] = 893885528;
    values[add_index] = -1746888808;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 25559196;
    values[add_index] = -1532060516;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;

    (void)add_index;
    treetable_destroy(table);
    return 0;
}
