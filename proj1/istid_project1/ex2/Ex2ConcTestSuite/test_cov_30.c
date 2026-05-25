/*
 * Property group: lookup correctness: get queries execute against the replayed table state.
 * Source minimized input: id:000022,src:000001,time:6126,execs:74017,op:havoc,rep:3,+cov
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

    { int key = 1566399837; treetable_get(table, &key, &out); }
    { int key = 1566399837; treetable_get(table, &key, &out); }

    treetable_destroy(table);
    return 0;
}
