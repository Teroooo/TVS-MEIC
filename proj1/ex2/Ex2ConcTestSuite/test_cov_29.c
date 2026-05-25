/*
 * Property: replay of minimized AFL++ input preserving the API-call
 * sequence and checking invariants after state-modifying operations.
 * Source minimized input: id:000021,src:000020,time:25047,execs:350147,op:havoc,rep:36,+cov
 */

#include <assert.h>

#include "../treetable.h"

int balanced(TreeTable *t);
int sorted(TreeTable *t);

int main(void)
{
    TreeTable *table = NULL;
    void *out = NULL;
    int keys[13];
    int values[13];
    size_t add_index = 0;

    assert(treetable_new(&table) == CC_OK);

    keys[add_index] = -1667459177;
    values[add_index] = -1667457897;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1670053376;
    values[add_index] = -526607209;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1432905833; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -531151204;
    values[add_index] = -1667786908;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1667475368;
    values[add_index] = -1667466084;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1667459177; treetable_get_greater_than(table, &key, &out); }
    { int key = 278357196; treetable_get(table, &key, &out); }
    { int key = 38802; treetable_get_greater_than(table, &key, &out); }
    { int key = 845308567; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -1215785065;
    values[add_index] = 1845100695;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1936221028;
    values[add_index] = -1755041129;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 1734829927; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -16409444;
    values[add_index] = -1667496449;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1751673193;
    values[add_index] = -1751672984;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1751672864; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -1667523405;
    values[add_index] = -1751343972;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = -1755041129;
    values[add_index] = 1734829975;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = 1734829927; treetable_get_greater_than(table, &key, &out); }
    { int key = -1667457960; treetable_get_greater_than(table, &key, &out); }
    { int key = 1734843548; treetable_get_greater_than(table, &key, &out); }
    { int key = -1215785065; treetable_get(table, &key, &out); }
    { int key = 1936156519; treetable_get_greater_than(table, &key, &out); }
    keys[add_index] = -1751344025;
    values[add_index] = 1734843548;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 16812695;
    values[add_index] = -1165453417;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    treetable_get_first_key(table, &out);
    treetable_get_first_key(table, &out);
    { int key = -526941289; treetable_get_greater_than(table, &key, &out); }
    treetable_get_first_key(table, &out);
    keys[add_index] = -1658806884;
    values[add_index] = 0;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    { int key = -1650614883; treetable_get(table, &key, &out); }
    { int key = -1650614883; treetable_get(table, &key, &out); }
    { int key = -1650614883; treetable_get(table, &key, &out); }
    { int key = -1650614883; treetable_get(table, &key, &out); }

    treetable_destroy(table);
    return 0;
}
