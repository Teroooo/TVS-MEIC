/*
 * Property group: empty or short input behavior: incomplete minimized input performs no API command.
 * Source minimized input: id:000001,time:0,execs:0,orig:get.seed
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
