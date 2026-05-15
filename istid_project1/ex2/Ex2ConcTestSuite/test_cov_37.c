/*
 * Property group: validity preservation: insertions preserve balanced() and sorted() invariants.
 * Source minimized input: id:000004,src:000001,time:361,execs:4001,op:havoc,rep:31,+cov
 */

#include <assert.h>

#include "../treetable.h"

int balanced(TreeTable *t);
int sorted(TreeTable *t);

int main(void)
{
    TreeTable *table = NULL;
    void *out = NULL;
    int keys[3];
    int values[3];
    size_t add_index = 0;

    assert(treetable_new(&table) == CC_OK);

    keys[add_index] = 1549556828;
    values[add_index] = -10724259;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 1558076160;
    values[add_index] = 1549556828;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;
    keys[add_index] = 1549557084;
    values[add_index] = 1526731007;
    treetable_add(table, &keys[add_index], &values[add_index]);
    assert(balanced(table) && sorted(table));
    add_index++;

    treetable_destroy(table);
    return 0;
}
