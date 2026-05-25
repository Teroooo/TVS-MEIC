# Bugs Found

This file summarizes bug classes found while reviewing the AFL++ crash corpus
and the TreeTable implementation. The crash inputs live in
`Ex2Harness/outputs/default/crashes` and were converted into reproducible C
tests in `Ex2ConcTestSuite/crashes`.

## 1. Empty-tree minimum lookup can crash

**Severity:** High

**Symptom:** Calling `treetable_get_first_key` before inserting any key causes a
segmentation fault. The same underlying issue also applies to any function that
calls `tree_min(table, table->root)` without first checking whether the table is
empty, such as `treetable_contains_value`.

**Reproducers:**

- `Ex2ConcTestSuite/crashes/test_crash_1.c`
- `Ex2ConcTestSuite/crashes/test_crash_2.c`
- `Ex2ConcTestSuite/crashes/test_crash_3.c`

**Relevant code:**

- `treetable_get_first_key` calls `tree_min(table, table->root)` unconditionally.
- In an empty table, `table->root == table->sentinel`.
- `tree_min` dereferences `n->left`, but the sentinel node's children are not
  initialized to point back to the sentinel.

```c
enum cc_stat treetable_get_first_key(TreeTable const * const table, void **out)
{
    RBNode *node = tree_min(table, table->root);
    ...
}

static INLINE RBNode *tree_min(TreeTable const * const table, RBNode *n)
{
    RBNode *s = table->sentinel;

    while (n->left != s)
        n = n->left;
    return n;
}
```

**Expected behavior:** `treetable_get_first_key` should return
`CC_ERR_KEY_NOT_FOUND` for an empty table. `treetable_contains_value` should
return `0` for an empty table.

**Likely fix:** Check for an empty table before calling `tree_min`.

```c
if (table->size == 0)
    return CC_ERR_KEY_NOT_FOUND;
```

Also add the equivalent empty-table guard to `treetable_contains_value`.
Initializing `sentinel->left`, `sentinel->right`, and `sentinel->parent` to
`sentinel` in `treetable_new_conf` would make the sentinel safer, but the public
API should still explicitly handle empty lookups.

## 2. Insertions can violate the harness tree invariants

**Severity:** High

**Symptom:** Several insert sequences abort on:

```text
Assertion failed: (balanced(table) && sorted(table))
```

The assertion fires immediately after `treetable_add`.

**Reproducers:** 15 crash reproducers fail this way, including:

- `Ex2ConcTestSuite/crashes/test_crash_4.c`
- `Ex2ConcTestSuite/crashes/test_crash_13.c`
- `Ex2ConcTestSuite/crashes/test_crash_18.c`

**Relevant code:**

- `treetable_add` inserts a new red node and calls `rebalance_after_insert`.
- The harness then checks both `balanced(table)` and `sorted(table)`.

```c
treetable_add(table, &keys[add_index], &values[add_index]);
assert(balanced(table) && sorted(table));
```

**Observed result:** The tree becomes invalid according to the exercise
invariants after certain insertion orders. For example, the `id:000012` repro
fails at the assertion after inserting key `-1516790628`.

**Likely area to inspect:** The failure is in or around insertion and
rebalancing:

- `treetable_add`
- `rebalance_after_insert`
- `rotate_left`
- `rotate_right`

The converted tests preserve the original key/value lifetimes, so these failures
are not caused by dangling stack pointers in the reproducers.

## 3. `treetable_add` does not check allocation failure

**Severity:** Medium

**Symptom:** `treetable_add` dereferences the result of `table->mem_alloc`
without checking for `NULL`.

**Relevant code:**

```c
RBNode *n = table->mem_alloc(sizeof(RBNode));

n->value  = val;
n->key    = key;
```

**Expected behavior:** If allocation fails, `treetable_add` should return
`CC_ERR_ALLOC`.

**Likely fix:**

```c
RBNode *n = table->mem_alloc(sizeof(RBNode));
if (!n)
    return CC_ERR_ALLOC;
```

## 4. Header declares APIs that are not implemented

**Severity:** Medium

**Symptom:** `treetable.h` declares these public functions:

```c
enum cc_stat treetable_get_last_key(TreeTable const * const table, void **out);
enum cc_stat treetable_get_lesser_than(TreeTable const * const table,
                                       const void *key,
                                       void **out);
```

But `treetable.c` does not define them. Any test or program that calls either
function will compile but fail at link time with an undefined symbol.

**Related clue:** `tree_max` is implemented but unused, which suggests
`treetable_get_last_key` was intended but never added.

**Expected behavior:** Every public function declared in `treetable.h` should
have a matching implementation in `treetable.c`.

**Likely fix:**

- Implement `treetable_get_last_key` using `tree_max`.
- Implement `treetable_get_lesser_than` using a predecessor helper.
- Add empty-table guards before calling `tree_max` or walking the tree.

## Verification Notes

All generated crash reproducers compile and link with:

```sh
clang -std=c11 -Wall -Wextra -Iex2 ex2/treetable.c <test_file>.c -o <binary>
```

Compiling with `-Werror` currently fails because `tree_max` is defined but not
used in `treetable.c`; that is separate from the crash reproducers.
