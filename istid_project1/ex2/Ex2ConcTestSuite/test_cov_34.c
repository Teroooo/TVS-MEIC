/*
 * Property: replay of minimized AFL++ input preserving the API-call
 * sequence and checking invariants after state-modifying operations.
 * Source minimized input: id:000004,src:000001,time:148,execs:2000,op:havoc,rep:11,+cov
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

    /* Input contains no complete 9-byte command. */

    treetable_destroy(table);
    return 0;
}
