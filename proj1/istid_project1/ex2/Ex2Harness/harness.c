/*
 * AFL++ input format:
 *   The input is a sequence of 9-byte commands.
 *   byte 0      : operation selector, interpreted as op % 4
 *                 0 = treetable_add(key, value)
 *                 1 = treetable_get(key)
 *                 2 = treetable_get_first_key()
 *                 3 = treetable_get_greater_than(key)
 *   bytes 1..4  : signed 32-bit little-endian key
 *   bytes 5..8  : signed 32-bit little-endian value, used only by add
 */

#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#include "../treetable.h"

#define MAX_INPUT_SIZE 65536
#define COMMAND_SIZE 9

int balanced(TreeTable *t);
int sorted(TreeTable *t);

static int32_t read_i32_le(const unsigned char *data)
{
    uint32_t value = (uint32_t)data[0]
                   | ((uint32_t)data[1] << 8)
                   | ((uint32_t)data[2] << 16)
                   | ((uint32_t)data[3] << 24);

    return (int32_t)value;
}

int main(void)
{
    unsigned char input[MAX_INPUT_SIZE]; 
    // outside loop so we dont allocate every iteration, 
    // its fine since we override this value inside the loop

#if defined(__AFL_LOOP) && !defined(DISABLE_AFL_PERSISTENT)
    while (__AFL_LOOP(1000)) {
#else
    for (int once = 0; once < 1; once++) { // fallback normal execution for simple debug
#endif
        size_t input_len = fread(input, 1, sizeof(input), stdin);
        size_t command_count = input_len / COMMAND_SIZE;

        TreeTable *table = NULL;
        enum cc_stat status = treetable_new(&table);
        assert(status == CC_OK);
        assert(table);

        int *keys = NULL;
        int *values = NULL;

        if (command_count > 0) {
            // needed cuz the tree stores adresses to the values, not the value itself, so we need to keep them alive
            keys = calloc(command_count, sizeof(int));
            values = calloc(command_count, sizeof(int));
            assert(keys);
            assert(values);
        }

        for (size_t i = 0; i < command_count; i++) {
            const unsigned char *command = input + (i * COMMAND_SIZE);
            unsigned char op = command[0] % 4; // byte 0 
            int key = read_i32_le(command + 1); // 1-4 bytes
            int value = read_i32_le(command + 5); // 5-8 bytes
            void *out = NULL;

            switch (op) {
                case 0:
                    keys[i] = key;
                    values[i] = value;
                    treetable_add(table, &keys[i], &values[i]);
                    assert(balanced(table) && sorted(table));
                    break;
                case 1:
                    treetable_get(table, &key, &out);
                    break;
                case 2:
                    treetable_get_first_key(table, &out);
                    break;
                case 3:
                    treetable_get_greater_than(table, &key, &out);
                    break;
            }
        }

        treetable_destroy(table);
        free(keys);
        free(values);
    }

    return 0;
}
