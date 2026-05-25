/*
 * Property: replay of minimized AFL++ input preserving the API-call
 * sequence and checking invariants after state-modifying operations.
 * Source minimized input: id:000019,src:000018,time:14349,execs:207074,op:havoc,rep:55,+cov
 */

#include <assert.h>

#include "../treetable.h"

int balanced(TreeTable *t);
int sorted(TreeTable *t);

int main(void)
{
    TreeTable *table = NULL;
    void *out = NULL;
    int keys[11];
    int values[11];
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
    values[add_index] = -1751695360;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1684564073;
    values[add_index] = 1184694143;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1746565480; treetable_get(table, &key, &out); }
    { int key = -1483237481; treetable_get_greater_than(table, &key, &out); }
    treetable_get_first_key(table, &out);
    { int key = 893885695; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -1677647716;
    values[add_index] = 1093709468;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1751343972;
    values[add_index] = 40060;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1701029761;
    values[add_index] = -1753284864;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1751672923; treetable_get_greater_than(table, &key, &out); }
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
    { int key = -1751672957; treetable_get(table, &key, &out); }
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
