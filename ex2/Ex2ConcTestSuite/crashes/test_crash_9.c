/*
 * Crash property: replay of AFL++ crash input.
 * Source input: id:000008,sig:06,src:000009,time:4480,execs:65018,op:havoc,rep:64
 * Input bytes: 178, replayed commands: 19
 * Ignored trailing bytes: 7
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

    keys[add_index] = -1671260265;
    values[add_index] = 1653446624;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1819435876;
    values[add_index] = 1479697027;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 555819297; treetable_get(table, &key, &out); }
    { int key = 977560156; treetable_get(table, &key, &out); }
    { int key = -1751358144; treetable_get_greater_than(table, &key, &out); }
    { int key = 1482202255; treetable_get_greater_than(table, &key, &out); }
    { int key = -10395295; treetable_get(table, &key, &out); }
    { int key = 16751772; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -1785239401;
    values[add_index] = -1684300649;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1684300901; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -6579301;
    values[add_index] = 1547763712;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    treetable_get_first_key(table, &out);
    keys[add_index] = -530235241;
    values[add_index] = -1684275456;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -7107172; treetable_get(table, &key, &out); }
    { int key = 555833394; treetable_get(table, &key, &out); }
    treetable_get_first_key(table, &out);
    keys[add_index] = 8355642;
    values[add_index] = 1698731776;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1667786857;
    values[add_index] = -1668313444;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1665751208;
    values[add_index] = -929265222;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;

    (void)add_index;
    treetable_destroy(table);
    return 0;
}
