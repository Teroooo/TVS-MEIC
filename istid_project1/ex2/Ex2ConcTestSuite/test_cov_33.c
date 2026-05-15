/*
 * Property: replay of minimized AFL++ input preserving the API-call
 * sequence and checking invariants after state-modifying operations.
 * Source minimized input: id:000023,src:000019,time:33332,execs:468188,op:havoc,rep:12,+cov
 */

#include <assert.h>

#include "../treetable.h"

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

    keys[add_index] = -522133280;
    values[add_index] = -1751654176;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    treetable_get_first_key(table, &out);
    { int key = 1201431166; treetable_get_greater_than(table, &key, &out); }
    { int key = 18914428; treetable_get_greater_than(table, &key, &out); }
    { int key = -1667457892; treetable_get(table, &key, &out); }
    keys[add_index] = -1750755495;
    values[add_index] = -1752809472;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1952999529;
    values[add_index] = 1184694143;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1746565480; treetable_get(table, &key, &out); }
    { int key = -1483237481; treetable_get_greater_than(table, &key, &out); }
    treetable_get_first_key(table, &out);
    { int key = 893885695; treetable_get_greater_than(table, &key, &out); }
    treetable_get_first_key(table, &out);
    { int key = -1751654313; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = 2090633372;
    values[add_index] = -1666736996;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1751671652;
    values[add_index] = -1751711489;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1667475300;
    values[add_index] = -1711272321;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1684300901; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -1667497984;
    values[add_index] = 10134702;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1667457960; treetable_get_greater_than(table, &key, &out); }
    treetable_get_first_key(table, &out);
    { int key = -1751673213; treetable_get_greater_than(table, &key, &out); }
    treetable_get_first_key(table, &out);
    { int key = -1684235113; treetable_get_greater_than(table, &key, &out); }
    { int key = 255; treetable_get_greater_than(table, &key, &out); }
    { int key = 1650606645; treetable_get(table, &key, &out); }
    keys[add_index] = 1479563352;
    values[add_index] = -1667457960;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1666736996;
    values[add_index] = 2140903319;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1741305956; treetable_get_greater_than(table, &key, &out); }
    treetable_get_first_key(table, &out);
    { int key = 3491740; treetable_get_greater_than(table, &key, &out); }
    treetable_get_first_key(table, &out);
    keys[add_index] = -1264822184;
    values[add_index] = 1094818972;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;

    treetable_destroy(table);
    return 0;
}
