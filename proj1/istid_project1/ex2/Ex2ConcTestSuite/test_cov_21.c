/*
 * Property group: order query behavior: first-key and/or successor queries follow tree ordering.
 * Source minimized input: id:000017,src:000014,time:2500,execs:33006,op:havoc,rep:29,+cov
 */

#include <assert.h>

#include "../treetable.h"

int balanced(TreeTable *t);
int sorted(TreeTable *t);

int main(void)
{
    TreeTable *table = NULL;
    void *out = NULL;
    int keys[12];
    int values[12];
    size_t add_index = 0;

    assert(treetable_new(&table) == CC_OK);

    keys[add_index] = 1180458077;
    values[add_index] = 1548137565;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -10724259;
    values[add_index] = -564461552;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 1549556828;
    values[add_index] = -10724260;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 1558110464;
    values[add_index] = -2136627876;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1554228237; treetable_get_greater_than(table, &key, &out); }
    { int key = 1633771841; treetable_get(table, &key, &out); }
    keys[add_index] = -597866916;
    values[add_index] = -1381126739;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1381126739; treetable_get(table, &key, &out); }
    treetable_get_first_key(table, &out);
    { int key = 1549533406; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -520089345;
    values[add_index] = -1520673570;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1515870811; treetable_get(table, &key, &out); }
    { int key = 1549556901; treetable_get(table, &key, &out); }
    keys[add_index] = 1564892255;
    values[add_index] = 1627348060;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 1549549404;
    values[add_index] = 1547263056;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    treetable_get_first_key(table, &out);
    keys[add_index] = 1549556828;
    values[add_index] = 1549556845;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 1549616732; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = 1549553727;
    values[add_index] = 1549556899;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 1549616732;
    values[add_index] = 1549860700;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 1633770588;
    values[add_index] = 1111634017;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    treetable_get_first_key(table, &out);
    { int key = 808464449; treetable_get(table, &key, &out); }

    treetable_destroy(table);
    return 0;
}
