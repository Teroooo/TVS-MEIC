/*
 * Crash property: replay of AFL++ crash input.
 * Source input: id:000014,sig:06,src:000019,time:14921,execs:213081,op:havoc,rep:15
 * Input bytes: 355, replayed commands: 39
 * Ignored trailing bytes: 4
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
    int keys[16];
    int values[16];
    size_t add_index = 0;

    assert(treetable_new(&table) == CC_OK);

    keys[add_index] = -488578848;
    values[add_index] = -1751654176;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    treetable_get_first_key(table, &out);
    { int key = 1201431166; treetable_get_greater_than(table, &key, &out); }
    { int key = 18914428; treetable_get_greater_than(table, &key, &out); }
    { int key = -1667457892; treetable_get(table, &key, &out); }
    keys[add_index] = -1750755495;
    values[add_index] = -1751695360;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1667457891;
    values[add_index] = 1482205084;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1667457857;
    values[add_index] = -1667457892;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1751672932;
    values[add_index] = -1660977253;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    treetable_get_first_key(table, &out);
    treetable_get_first_key(table, &out);
    treetable_get_first_key(table, &out);
    { int key = 808468801; treetable_get(table, &key, &out); }
    { int key = 18914428; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -1667457892;
    values[add_index] = -1365468004;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1667457983;
    values[add_index] = -1669556324;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 1484750848;
    values[add_index] = -16737636;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    treetable_get_first_key(table, &out);
    { int key = 1486658711; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -1684300902;
    values[add_index] = -1684300901;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 40091; treetable_get_greater_than(table, &key, &out); }
    treetable_get_first_key(table, &out);
    { int key = -1746233705; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -1753005759;
    values[add_index] = -1755539561;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1666351465; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -1667786876;
    values[add_index] = -2003068004;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 16751515; treetable_get_greater_than(table, &key, &out); }
    { int key = 1110783285; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = 1482184792;
    values[add_index] = -1671931856;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1677695844; treetable_get_greater_than(table, &key, &out); }
    { int key = -946012289; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -1751680512;
    values[add_index] = -1751672864;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 1201471359; treetable_get_greater_than(table, &key, &out); }
    { int key = -1666122753; treetable_get_greater_than(table, &key, &out); }
    { int key = 1482202263; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = 1655741596;
    values[add_index] = -1667475880;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1741338724;
    values[add_index] = 1448665239;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1751343972;
    values[add_index] = -1746887524;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1665885096; treetable_get_greater_than(table, &key, &out); }

    (void)add_index;
    treetable_destroy(table);
    return 0;
}
