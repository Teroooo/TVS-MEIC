/*
 * Crash property: replay of AFL++ crash id:000000.
 *
 * AddressSanitizer report:
 *   ERROR: AddressSanitizer: SEGV on unknown address 0x000000000020
 *   The signal is caused by a READ memory access.
 *   #0 tree_min treetable.c:497
 *   #1 treetable_get_first_key treetable.c:200
 *
 * The crashing input starts with a treetable_get_first_key command before any
 * successful insertion, so treetable_get_first_key calls tree_min on the
 * sentinel and dereferences a null child pointer.
 */

#include "../../treetable.h"

int main(void)
{
    TreeTable *table = NULL;
    void *out = NULL;

    if (treetable_new(&table) != CC_OK)
        return 1;

    treetable_get_first_key(table, &out);
    treetable_destroy(table);
    return 0;
}
