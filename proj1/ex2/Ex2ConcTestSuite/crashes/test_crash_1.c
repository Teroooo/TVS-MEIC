/*
 * Crash property: replay of AFL++ crash input.
 * Source input: id:000000,sig:05,src:000004,time:326,execs:4002,op:havoc,rep:6
 * Input bytes: 23, replayed commands: 2
 * Ignored trailing bytes: 5
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

    { int key = 4308490; treetable_get(table, &key, &out); }
    treetable_get_first_key(table, &out);

    (void)add_index;
    treetable_destroy(table);
    return 0;
}
