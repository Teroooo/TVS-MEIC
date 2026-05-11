/*
 * Crash property: replay of AFL++ crash input.
 * Source input: id:000016,sig:06,src:000014,time:18884,execs:262116,op:havoc,rep:49
 * Input bytes: 288, replayed commands: 32
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
    int keys[18];
    int values[18];
    size_t add_index = 0;

    assert(treetable_new(&table) == CC_OK);

    keys[add_index] = -1751343987;
    values[add_index] = 14726300;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1751672937;
    values[add_index] = -1751254633;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1246382667;
    values[add_index] = -1246382667;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1246382667; treetable_get(table, &key, &out); }
    { int key = -2101758539; treetable_get(table, &key, &out); }
    { int key = -526607219; treetable_get(table, &key, &out); }
    { int key = -1751671657; treetable_get_greater_than(table, &key, &out); }
    { int key = -1667779945; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = 1201446044;
    values[add_index] = -1751654313;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 1482202215; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -1667455076;
    values[add_index] = 1310497948;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 811696737; treetable_get(table, &key, &out); }
    treetable_get_first_key(table, &out);
    keys[add_index] = -1751672937;
    values[add_index] = -1751254633;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    treetable_get_first_key(table, &out);
    keys[add_index] = 168439856;
    values[add_index] = -1751685920;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 1482184860;
    values[add_index] = 228024408;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1667457873;
    values[add_index] = -1663019193;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -2147418363;
    values[add_index] = -1665491880;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1666736996;
    values[add_index] = -1667475300;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1667457960;
    values[add_index] = -1752066180;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1852343140; treetable_get_greater_than(table, &key, &out); }
    { int key = -1751672937; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -1667457892;
    values[add_index] = -1746905273;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 1486645143; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = 1486635329;
    values[add_index] = -1197695912;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1669555044;
    values[add_index] = -1667455076;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 1632509084;
    values[add_index] = 811688289;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    treetable_get_first_key(table, &out);
    keys[add_index] = -1751674473;
    values[add_index] = -1550346345;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 4233111; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = 1462082716;
    values[add_index] = 1107400672;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;

    (void)add_index;
    treetable_destroy(table);
    return 0;
}
