#ifndef KLEE_HELPERS_H
#define KLEE_HELPERS_H

/*
 * klee_helpers.h — shared setup for the symbolic test suite.
 *
 * Every symbolic test file includes this header (after assert.h).
 * It sets up the KLEE intrinsic stubs for native (non-KLEE) builds,
 * includes the TreeTable implementation, and provides the allocation
 * helpers that guarantee malloc never returns NULL under KLEE.
 */

#if __has_include(<klee/klee.h>)
#  include <klee/klee.h>
#  define HAVE_KLEE 1
#else
#  include <assert.h>
#  define HAVE_KLEE 0
#  define klee_make_symbolic(addr, nbytes, name) \
       ((void)(addr), (void)(nbytes), (void)(name))
#  define klee_assume(expr)  assert(expr)
#  define klee_assert(expr)  assert(expr)
#endif

#include <stdlib.h>

/* Include the implementation directly so each test is self-contained. */
#include "../../ex2/treetable.c"

/* ---- helpers -------------------------------------------------------- */

static int symbolic_int(const char *name, int concrete_fallback)
{
    int value = concrete_fallback;
    klee_make_symbolic(&value, sizeof(value), name);
    return value;
}

static void *safe_malloc(size_t size)
{
    void *ptr = malloc(size);
    klee_assume(ptr != 0);   /* filter allocation-failure paths */
    return ptr;
}

static void *safe_calloc(size_t count, size_t size)
{
    void *ptr = calloc(count, size);
    klee_assume(ptr != 0);
    return ptr;
}

static TreeTable *make_table(void)
{
    TreeTableConf conf;
    TreeTable *table = NULL;
    treetable_conf_init(&conf);
    conf.mem_alloc   = safe_malloc;
    conf.mem_calloc  = safe_calloc;
    klee_assert(treetable_new_conf(&conf, &table) == CC_OK);
    klee_assert(table != NULL);
    return table;
}

/*
 * Returns an empty table whose sentinel's children are self-referential.
 *
 * The default implementation leaves sentinel children as NULL, which
 * causes treetable_get_first_key to crash before reaching its documented
 * CC_ERR_KEY_NOT_FOUND branch. This helper patches the sentinel so KLEE
 * can cover that branch. The crash itself is documented as a known bug.
 */
static TreeTable *make_empty_table_with_safe_sentinel(void)
{
    TreeTable *table = make_table();
    table->sentinel->left   = table->sentinel;
    table->sentinel->right  = table->sentinel;
    table->sentinel->parent = table->sentinel;
    return table;
}

#endif /* KLEE_HELPERS_H */
