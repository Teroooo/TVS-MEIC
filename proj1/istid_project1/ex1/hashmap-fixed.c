/* Copyright (C) 2014  Richard Wiedenhöft <richard.wiedenhoeft@gmail.com>
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#include "hashmap.h"
#include <assert.h>
#include <string.h>

unsigned long int hashmap_fnv1a(void *data, unsigned long int len) {
  unsigned char *p = (unsigned char *)data;
  unsigned long int h = 2166136261UL;
  unsigned long int i;

  for (i = 0; i < len; i++) {
    h = (h ^ p[i]) * 16777619;
  }

  return h;
}

int hashmap_hash(char *str, int max_hash) {
  unsigned long int fnv1a_hash = hashmap_fnv1a((void *)str, strlen(str));
  int hash = (int)(fnv1a_hash % (max_hash + 1));
  return hash;
}

struct hashmap_s {
  int size;
  struct hashmap_field *fields;
};

struct hashmap_field {
  int size;
  struct hashmap_entry *entries;
};

struct hashmap_entry {
  char *key;
  void *val;
  size_t len;
};

hashmap_t hashmap_new(int size) {
  /* BUG-1: map malloc return value never checked for NULL */
  hashmap_t map = (hashmap_t)malloc(sizeof(struct hashmap_s));
  /* Fixes 1 */
  if (!map) {
    return NULL;
  }

  /* BUG-2: fields malloc return value never checked for NULL.
     BUG-3: if (!fields) frees map but does not return, causing
            use-after-free and null dereference of fields in the loop */
  struct hashmap_field *fields =
      (struct hashmap_field *)malloc(sizeof(struct hashmap_field) * size);
  /* Fixes 2 & 3 */
  if (!fields) {
    free(map);
    return NULL;
  }

  for (int i = 0; i < size; i++) {
    struct hashmap_field *field = &fields[i];
    field->size = 0;
    field->entries = NULL;
  }

  map->size = size;
  map->fields = fields;

  return map;
}

void hashmap_free(hashmap_t map) {
  for (int i = 0; i < map->size; i++) {
    struct hashmap_field *field = map->fields + i;
    if (field->entries != 0) {
      int j;
      for (j = 0; j < field->size; j++) {
        struct hashmap_entry *entry = field->entries + j;
        free(entry->key);
        free(entry->val);
      }
      free(field->entries);
    }
  }
  free(map->fields);
  free(map);
}

void hashmap_set(hashmap_t map, char *key, void *value, size_t length) {
  int hash = hashmap_hash(key, map->size - 1);
  struct hashmap_field *field = map->fields + hash;
  struct hashmap_entry *entry;

  int i;
  for (i = 0; i < field->size; i++) {
    entry = field->entries + i;
    if (strcmp(entry->key, key) == 0) {
      free(entry->val);
      entry->val = NULL;
      goto set_val;
    }
  }

  if (value == NULL) {
    return;
  }

  field->size++;

  /* BUG-4: entries malloc return value never checked for NULL,
            memcpy would crash if entries is NULL */
  struct hashmap_entry *entries = (struct hashmap_entry *)malloc(
      field->size * sizeof(struct hashmap_entry));
  /* Fixes 4 */
  if (!entries) {
    field->size--;
    return;
  }

  memcpy(entries, field->entries,
         (field->size - 1) * sizeof(struct hashmap_entry));

  entry = &entries[field->size - 1];

  /* BUG-5: malloc(sizeof(key)) allocates size of a pointer (8 bytes),
            not the length of the string — causes buffer overflow on strcpy.
     BUG-6: strcpy is unsafe, no bounds checking */
  /* Fixes 5 & 6: use strlen+1 for correct size, strncpy for safe copy */
  size_t key_len = strlen(key) + 1;
  entry->key = (char *)malloc(key_len);
  if (!entry->key) {
    free(entries);
    field->size--;
    return;
  }
  strncpy(entry->key, key, key_len);

  free(field->entries);
  field->entries = entries;

set_val:
  if (value != NULL) {
    /* BUG-7: val malloc return value never checked for NULL,
              memcpy would crash if val is NULL */
    void *val = malloc(length);
    /* Fixes 7 */
    if (!val) {
      return;
    }
    memcpy(val, value, length);
    entry->val = val;
    entry->len = length;
  } else {
    free(entry->key);
    entry->key = NULL;
    field->size--;
    if (entry != (field->entries + field->size)) {
      memcpy((void *)entry, (void *)(field->entries + field->size),
             sizeof(struct hashmap_entry));
    }
    /* BUG-8: realloc return value not checked — if realloc fails,
              field->entries becomes NULL and old memory is leaked */
    /* Fixes 8 */
    struct hashmap_entry *new_entries = realloc((void *)field->entries,
                             field->size * sizeof(struct hashmap_entry));
    if (!new_entries && field->size > 0) {
      return;
    }
    field->entries = new_entries;
  }
}

void *hashmap_get(hashmap_t map, char *key) {
  int hash = hashmap_hash(key, map->size - 1);
  struct hashmap_field *field = map->fields + hash;
  struct hashmap_entry *entry;

  int i;
  for (i = 0; i < field->size; i++) {
    entry = field->entries + i;
    if (strcmp(entry->key, key) == 0) {
      /* BUG-9: val malloc return value never checked for NULL,
                memcpy would crash if val is NULL */
      void *val = malloc(entry->len);
      /* Fixes 9 */
      if (!val) {
        return NULL;
      }
      memcpy(val, entry->val, entry->len);
      return val;
    }
  }
  return NULL;
}

int main() {
  /* BUG-10: hashmap_new return value never checked for NULL */
  hashmap_t map = hashmap_new(8);
  /* Fixes 10 */
  if (!map) {
    return 1;
  }

  char *key = "42";
  int value = 42;
  hashmap_set(map, key, &value, sizeof(int));

  /* BUG-11: ret from hashmap_get is never freed — memory leak */
  int *ret = (int *)hashmap_get(map, key);
  /* Fixes 11 */
  if (!ret) {
    hashmap_free(map);
    return 1;
  }
  assert(*ret == value);
  free(ret);

  hashmap_free(map);
  return 0;
}