/*
 * hashmap_driver.c — targeted Valgrind test driver for hashmap.c
 *
 * Exercises three distinct bug paths that the original hashmap_test misses:
 *   Bug 1 (lines 124-125): buffer overflow — entry->key is malloc'd with
 *          malloc(sizeof(char*)) = 8 bytes, then strcpy writes the full key.
 *          Any key longer than 7 chars overflows the heap buffer.
 *   Bug 2 (line 127): memory leak on bucket growth — when a second key lands
 *          in the same bucket, a new entries array is malloc'd but the old
 *          pointer is overwritten without being freed.
 *   Bug 3 (line 155 / caller): memory leak — hashmap_get returns a
 *          heap-allocated copy of the value; the caller never frees it.
 *
 * Compile: gcc -g -DDRIVER_MAIN hashmap.c hashmap_driver.c -o hashmap_driver
 * Run:     valgrind --leak-check=full --track-origins=yes ./hashmap_driver
 */

#include "hashmap.h"
#include <stdlib.h>

int main(void)
{
    hashmap_t map = hashmap_new(8);

    /* Bug 1: buffer overflow via long key
     * "long_key_overflow" = 17 chars + null = 18 bytes, copied into 8 bytes.
     * Valgrind reports an invalid write of size 1 for every byte past index 7. */
    int v = 1;
    hashmap_set(map, "long_key_overflow", &v, sizeof(int));

    /* Bug 2: memory leak on bucket growth
     * 16 keys across 8 buckets guarantees at least one collision by pigeonhole.
     * Each collision allocates a new entries array but leaks the old pointer. */
    int vals[16];
    char *keys[] = {
        "key00", "key01", "key02", "key03",
        "key04", "key05", "key06", "key07",
        "key08", "key09", "key10", "key11",
        "key12", "key13", "key14", "key15"
    };
    for (int i = 0; i < 16; i++) {
        vals[i] = i;
        hashmap_set(map, keys[i], &vals[i], sizeof(int));
    }

    /* Bug 3: memory leak from unreleased return values
     * hashmap_get returns a heap-allocated copy; the caller must free it.
     * These three return values are intentionally never freed. */
    void *r1 = hashmap_get(map, "long_key_overflow");
    void *r2 = hashmap_get(map, "key00");
    void *r3 = hashmap_get(map, "key01");
    (void)r1; (void)r2; (void)r3;

    hashmap_free(map);
    return 0;
}
