/*
 * Property: replay of minimized AFL++ input preserving the API-call
 * sequence and checking invariants after state-modifying operations.
 * Source minimized input: id:000014,src:000012,time:2289,execs:35006,op:havoc,rep:4,+cov
 */

#include <assert.h>

#include "../treetable.h"

int balanced(TreeTable *t);
int sorted(TreeTable *t);

int main(void)
{
    TreeTable *table = NULL;
    void *out = NULL;
    int keys[9];
    int values[9];
    size_t add_index = 0;

    assert(treetable_new(&table) == CC_OK);

    keys[add_index] = -1751343972;
    values[add_index] = 14720156;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1751672937;
    values[add_index] = -1751261033;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1667464548;
    values[add_index] = -1919116132;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 1073799324;
    values[add_index] = 2123863959;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1751664009; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -1751672937;
    values[add_index] = -1669162089;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1919116132;
    values[add_index] = 14720156;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 2123863959;
    values[add_index] = -1749387369;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1676672889; treetable_get_greater_than(table, &key, &out); }
    { int key = 1631666497; treetable_get(table, &key, &out); }
    keys[add_index] = -1667786908;
    values[add_index] = -1671931748;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1734574948;
    values[add_index] = 1107230631;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 1633763649; treetable_get(table, &key, &out); }

    treetable_destroy(table);
    return 0;
}
