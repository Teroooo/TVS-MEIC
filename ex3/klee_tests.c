#include <klee/klee.h>
#include <stdlib.h>
#include "../ex2/treetable.h"

int balanced(TreeTable *t);
int sorted(TreeTable *t);

/* ---------------------------------------------------------------
 * Alocador seguro: garante ao KLEE que malloc nunca retorna NULL.
 * Sem isto, KLEE explora o caminho onde malloc falha e
 * treetable_add faz null dereference em n->value = val.
 * --------------------------------------------------------------- */
static void *safe_malloc(size_t size) {
    void *ptr = malloc(size);
    klee_assume(ptr != 0);
    return ptr;
}

static void *safe_calloc(size_t n, size_t size) {
    void *ptr = calloc(n, size);
    klee_assume(ptr != 0);
    return ptr;
}

/* Cria uma TreeTable que usa os alocadores seguros */
static TreeTable *make_table(void) {
    TreeTableConf conf;
    treetable_conf_init(&conf);
    conf.mem_alloc  = safe_malloc;
    conf.mem_calloc = safe_calloc;

    TreeTable *t;
    treetable_new_conf(&conf, &t);
    return t;
}

/* ---------------------------------------------------------------
 * Property 1: Inserção em árvore vazia produz árvore válida.
 * Cobre o ramo (y == sentinel) de treetable_add — criação da raiz.
 * --------------------------------------------------------------- */
void test_add_single_element_valid_tree(void)
{
    TreeTable *t = make_table();

    int k;
    klee_make_symbolic(&k, sizeof(k), "k");

    int v = 0;
    enum cc_stat s = treetable_add(t, &k, &v);

    klee_assert(s == CC_OK);
    klee_assert(treetable_size(t) == 1);
    klee_assert(balanced(t));
    klee_assert(sorted(t));

    treetable_destroy(t);
}

/* ---------------------------------------------------------------
 * Property 2: Inserir chave duplicada actualiza o valor sem
 * alterar o tamanho nem quebrar invariantes da árvore.
 * Cobre o ramo (cmp == 0) dentro do while de treetable_add.
 * --------------------------------------------------------------- */
void test_add_duplicate_key_updates_value(void)
{
    TreeTable *t = make_table();

    int k;
    klee_make_symbolic(&k, sizeof(k), "k");

    int v1 = 1, v2 = 2;
    treetable_add(t, &k, &v1);
    treetable_add(t, &k, &v2);

    void *out;
    enum cc_stat s = treetable_get(t, &k, &out);

    klee_assert(treetable_size(t) == 1);
    klee_assert(s == CC_OK);
    klee_assert(out == &v2);
    klee_assert(balanced(t));
    klee_assert(sorted(t));

    treetable_destroy(t);
}

/* ---------------------------------------------------------------
 * Property 3: Inserção de múltiplos elementos preserva os
 * invariantes BST e Red-Black independentemente da ordem.
 * Com 3 chaves simbólicas distintas, KLEE explora todas as
 * ordenações possíveis, cobrindo:
 *   - insert filho esquerdo  (cmp < 0)
 *   - insert filho direito   (cmp > 0)
 *   - rebalanceamento uncle RED  (recoloração)
 *   - rebalanceamento uncle BLACK (rotação)
 * --------------------------------------------------------------- */
void test_add_three_elements_invariants(void)
{
    TreeTable *t = make_table();

    int k1, k2, k3;
    klee_make_symbolic(&k1, sizeof(k1), "k1");
    klee_make_symbolic(&k2, sizeof(k2), "k2");
    klee_make_symbolic(&k3, sizeof(k3), "k3");

    klee_assume(k1 != k2);
    klee_assume(k1 != k3);
    klee_assume(k2 != k3);

    int v = 0;
    treetable_add(t, &k1, &v);
    treetable_add(t, &k2, &v);
    treetable_add(t, &k3, &v);

    klee_assert(treetable_size(t) == 3);
    klee_assert(balanced(t));
    klee_assert(sorted(t));

    treetable_destroy(t);
}

/* ---------------------------------------------------------------
 * Property 4: treetable_get devolve o valor correcto para uma
 * chave inserida, e CC_ERR_KEY_NOT_FOUND para uma chave ausente.
 * Cobre: early-exit size==0, caminho found, caminho not-found.
 * --------------------------------------------------------------- */
void test_get_correctness(void)
{
    TreeTable *t = make_table();

    /* Tabela vazia: size==0 early-exit */
    int kx;
    klee_make_symbolic(&kx, sizeof(kx), "kx");
    void *out;
    enum cc_stat s = treetable_get(t, &kx, &out);
    klee_assert(s == CC_ERR_KEY_NOT_FOUND);

    int k1, k2;
    klee_make_symbolic(&k1, sizeof(k1), "k1");
    klee_make_symbolic(&k2, sizeof(k2), "k2");
    klee_assume(k1 != k2);

    int v1 = 42;
    treetable_add(t, &k1, &v1);

    /* Chave inserida: deve ser encontrada com valor correcto */
    s = treetable_get(t, &k1, &out);
    klee_assert(s == CC_OK);
    klee_assert(out == &v1);

    /* Chave não inserida: deve falhar */
    s = treetable_get(t, &k2, &out);
    klee_assert(s == CC_ERR_KEY_NOT_FOUND);

    treetable_destroy(t);
}

/* ---------------------------------------------------------------
 * Property 5: treetable_get_first_key devolve CC_ERR_KEY_NOT_FOUND
 * em tabela vazia, e a chave mínima em tabela não vazia.
 * Cobre: ramo root==sentinel e caminho bem-sucedido via tree_min.
 * --------------------------------------------------------------- */
void test_get_first_key_is_minimum(void)
{
    TreeTable *t = make_table();

    /* Tabela vazia */
    void *out;
    enum cc_stat s = treetable_get_first_key(t, &out);
    klee_assert(s == CC_ERR_KEY_NOT_FOUND);

    int k1, k2;
    klee_make_symbolic(&k1, sizeof(k1), "k1");
    klee_make_symbolic(&k2, sizeof(k2), "k2");
    klee_assume(k1 != k2);

    int v = 0;
    treetable_add(t, &k1, &v);
    treetable_add(t, &k2, &v);

    s = treetable_get_first_key(t, &out);
    klee_assert(s == CC_OK);
    int first = *(int *)out;
    klee_assert(first <= k1);
    klee_assert(first <= k2);

    treetable_destroy(t);
}

/* ---------------------------------------------------------------
 * Property 6: treetable_get_greater_than é monótono — devolve
 * sempre uma chave estritamente maior que a chave consultada.
 * Cobre: successor com filho direito, walkup pelo pai,
 *        elemento máximo sem successor, chave ausente.
 * --------------------------------------------------------------- */
void test_get_greater_than_monotonicity(void)
{
    TreeTable *t = make_table();

    int k1, k2, k3;
    klee_make_symbolic(&k1, sizeof(k1), "k1");
    klee_make_symbolic(&k2, sizeof(k2), "k2");
    klee_make_symbolic(&k3, sizeof(k3), "k3");

    klee_assume(k1 < k2);
    klee_assume(k2 < k3);

    int v = 0;
    treetable_add(t, &k1, &v);
    treetable_add(t, &k2, &v);
    treetable_add(t, &k3, &v);

    void *out;
    enum cc_stat s;

    /* Successor de k1 deve ser k2 */
    s = treetable_get_greater_than(t, &k1, &out);
    klee_assert(s == CC_OK);
    klee_assert(*(int *)out == k2);

    /* Successor de k2 deve ser k3 */
    s = treetable_get_greater_than(t, &k2, &out);
    klee_assert(s == CC_OK);
    klee_assert(*(int *)out == k3);

    /* k3 é o máximo — sem successor */
    s = treetable_get_greater_than(t, &k3, &out);
    klee_assert(s == CC_ERR_KEY_NOT_FOUND);

    /* Chave ausente deve falhar */
    int absent;
    klee_make_symbolic(&absent, sizeof(absent), "absent");
    klee_assume(absent != k1);
    klee_assume(absent != k2);
    klee_assume(absent != k3);
    s = treetable_get_greater_than(t, &absent, &out);
    klee_assert(s == CC_ERR_KEY_NOT_FOUND);

    treetable_destroy(t);
}

int main(void)
{
    test_add_single_element_valid_tree();
    test_add_duplicate_key_updates_value();
    test_add_three_elements_invariants();
    test_get_correctness();
    test_get_first_key_is_minimum();
    test_get_greater_than_monotonicity();
    return 0;
}