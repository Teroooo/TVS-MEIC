/*
 * Property: replay of minimized AFL++ input preserving the API-call
 * sequence and checking invariants after state-modifying operations.
 * Source minimized input: id:000016,src:000005,time:4178,execs:60018,op:havoc,rep:4,+cov
 */

#include <assert.h>

#include "../treetable.h"

int balanced(TreeTable *t);
int sorted(TreeTable *t);

int main(void)
{
    TreeTable *table = NULL;
    void *out = NULL;
    int keys[1];
    int values[1];
    size_t add_index = 0;

    assert(treetable_new(&table) == CC_OK);

    { int key = -1751654337; treetable_get_greater_than(table, &key, &out); }
    { int key = -1667457892; treetable_get(table, &key, &out); }
    { int key = -1667457892; treetable_get_greater_than(table, &key, &out); }

    treetable_destroy(table);
    return 0;
}
