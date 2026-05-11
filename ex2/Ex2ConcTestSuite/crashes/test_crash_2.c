/*
 * Crash property: replay of AFL++ crash input.
 * Source input: id:000001,sig:05,src:000001,time:703,execs:10003,op:havoc,rep:17
 * Input bytes: 27, replayed commands: 3
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
    size_t add_index = 0;

    assert(treetable_new(&table) == CC_OK);

    treetable_get_first_key(table, &out);
    treetable_get_first_key(table, &out);
    { int key = 811102562; treetable_get_greater_than(table, &key, &out); }

    (void)add_index;
    treetable_destroy(table);
    return 0;
}
