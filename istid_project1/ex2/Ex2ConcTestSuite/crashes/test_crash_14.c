/*
 * Crash property: replay of AFL++ crash input.
 * Source input: id:000013,sig:06,src:000019,time:14807,execs:213077,op:havoc,rep:16
 * Input bytes: 352, replayed commands: 39
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
    int keys[20];
    int values[20];
    size_t add_index = 0;

    assert(treetable_new(&table) == CC_OK);

    { int key = -1667393641; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -1665164200;
    values[add_index] = -1970627428;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    treetable_get_first_key(table, &out);
    treetable_get_first_key(table, &out);
    treetable_get_first_key(table, &out);
    keys[add_index] = 2084740252;
    values[add_index] = 2090329478;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1667497696;
    values[add_index] = -1673449298;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 2090310813;
    values[add_index] = 1493172380;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 1073780645; treetable_get_greater_than(table, &key, &out); }
    { int key = -8414313; treetable_get_greater_than(table, &key, &out); }
    treetable_get_first_key(table, &out);
    keys[add_index] = 1093707671;
    values[add_index] = -1750689883;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1030238825; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -2038680249;
    values[add_index] = -1669556251;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1365468159;
    values[add_index] = -1667481296;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1669556324;
    values[add_index] = 2139099136;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -16737636;
    values[add_index] = -359164034;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1483276256; treetable_get_greater_than(table, &key, &out); }
    { int key = -1761542249; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = 942492;
    values[add_index] = -1684300902;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1684300901; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -1700483428;
    values[add_index] = 1650606658;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    treetable_get_first_key(table, &out);
    { int key = 816289687; treetable_get_greater_than(table, &key, &out); }
    { int key = -1751688041; treetable_get_greater_than(table, &key, &out); }
    { int key = -2097152032; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -1667786857;
    values[add_index] = -1264822184;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 16799900;
    values[add_index] = -1752956928;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1684300644; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -16777215;
    values[add_index] = 892705691;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 1650614850; treetable_get(table, &key, &out); }
    keys[add_index] = 1482174552;
    values[add_index] = 2090638492;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1751341156;
    values[add_index] = -8414313;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -2036845113;
    values[add_index] = 2046820452;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1751654249; treetable_get_greater_than(table, &key, &out); }
    { int key = 2139062143; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -8057;
    values[add_index] = -1667452798;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1751672932;
    values[add_index] = -1671931748;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 1094818972;
    values[add_index] = 1633771873;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;

    (void)add_index;
    treetable_destroy(table);
    return 0;
}
