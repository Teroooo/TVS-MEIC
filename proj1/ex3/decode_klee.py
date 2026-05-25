#!/usr/bin/env python3
"""
decode_klee.py  — gera testes concretos em C a partir dos .ktest do KLEE.

Problema original:
  - Um único ficheiro simbólico com todos os testes → KLEE gera .ktest com
    TODAS as variáveis simbólicas de TODOS os testes em simultâneo.
  - Resultado: cada .ktest era associado a todos os testes → duplicados.

Solução:
  - Para cada teste, extraímos apenas as variáveis relevantes desse teste.
  - Deduplicamos por tuplo de valores (só guardamos combinações únicas).
  - Geramos funções C completas (não só declarações).

Uso:
  python3 decode_klee.py klee-out-0 Ex3ConcTestSuite
"""

import os, sys, subprocess, re, codecs

# ---------------------------------------------------------------------------
# Variáveis relevantes por teste simbólico
# ---------------------------------------------------------------------------
TEST_VARS = {
    "test_add_root_preserves_validity":
        ["root_key", "root_value"],
    "test_add_duplicate_updates_value_only":
        ["dup_key", "old_value", "new_value"],
    "test_add_left_and_right_children":
        ["two_k1", "two_k2", "two_v1", "two_v2"],
    "test_add_three_symbolic_keys_preserves_validity":
        ["three_k1", "three_k2", "three_k3", "three_v1", "three_v2", "three_v3"],
    "test_get_missing_keys_fail":
        ["get_absent_empty", "get_present", "get_absent_nonempty", "get_value"],
    "test_get_inserted_key_returns_value":
        ["get_found_key", "get_found_value"],
    "test_get_first_key_is_minimum":
        ["first_k1", "first_k2", "first_k3", "first_value"],
    "test_get_greater_than_uses_right_subtree_minimum":
        ["greater_right_value"],
    "test_get_greater_than_walks_to_parent_successor":
        ["greater_parent_value"],
    "test_get_greater_than_absent_key_fails":
        ["greater_present", "greater_absent", "greater_absent_value"],
    "test_get_greater_than_maximum_key_is_total":
        ["greater_max_value"],
    "test_get_greater_than_internal_null_successor_branch":
        ["greater_null_successor_key", "greater_null_successor_value"],
}

# ---------------------------------------------------------------------------
# Gerador de corpo de teste em C para cada teste simbólico
# Cada função recebe um dicionário {var_name: int_value}
# ---------------------------------------------------------------------------
def body_add_root(v):
    return f"""\
    int key   = {v['root_key']};
    int value = {v['root_value']};
    TreeTable *table = make_table_default();
    assert(treetable_add(table, &key, &value) == CC_OK);
    assert(treetable_size(table) == 1);
    assert(balanced(table));
    assert(sorted(table));
    treetable_destroy(table);"""

def body_add_duplicate(v):
    return f"""\
    int key       = {v['dup_key']};
    int old_value = {v['old_value']};
    int new_value = {v['new_value']};
    void *out     = NULL;
    TreeTable *table = make_table_default();
    assert(treetable_add(table, &key, &old_value) == CC_OK);
    assert(treetable_add(table, &key, &new_value) == CC_OK);
    assert(treetable_size(table) == 1);
    assert(treetable_get(table, &key, &out) == CC_OK);
    assert(out == &new_value);
    assert(balanced(table));
    assert(sorted(table));
    treetable_destroy(table);"""

def body_add_left_right(v):
    k1, k2 = v['two_k1'], v['two_k2']
    if k1 == k2:
        return None   # skip: violaria klee_assume(k1 != k2)
    return f"""\
    int k1 = {k1}, k2 = {k2}, v1 = {v['two_v1']}, v2 = {v['two_v2']};
    TreeTable *table = make_table_default();
    assert(treetable_add(table, &k1, &v1) == CC_OK);
    assert(treetable_add(table, &k2, &v2) == CC_OK);
    assert(treetable_size(table) == 2);
    assert(balanced(table));
    assert(sorted(table));
    treetable_destroy(table);"""

def body_add_three(v):
    k1, k2, k3 = v['three_k1'], v['three_k2'], v['three_k3']
    if len({k1, k2, k3}) < 3:
        return None   # skip: violaria klee_assume distintos
    return f"""\
    int k1={k1}, k2={k2}, k3={k3};
    int v1={v['three_v1']}, v2={v['three_v2']}, v3={v['three_v3']};
    TreeTable *table = make_table_default();
    assert(treetable_add(table, &k1, &v1) == CC_OK);
    assert(treetable_add(table, &k2, &v2) == CC_OK);
    assert(treetable_add(table, &k3, &v3) == CC_OK);
    assert(treetable_size(table) == 3);
    assert(balanced(table));
    assert(sorted(table));
    treetable_destroy(table);"""

def body_get_missing(v):
    absent_e, present, absent_ne, value = (
        v['get_absent_empty'], v['get_present'],
        v['get_absent_nonempty'], v['get_value'])
    if present == absent_ne:
        return None
    return f"""\
    int absent_empty = {absent_e}, present = {present};
    int absent_ne    = {absent_ne}, value  = {value};
    void *out = NULL;
    TreeTable *table = make_table_default();
    assert(treetable_get(table, &absent_empty, &out) == CC_ERR_KEY_NOT_FOUND);
    assert(treetable_add(table, &present, &value) == CC_OK);
    assert(treetable_get(table, &absent_ne, &out) == CC_ERR_KEY_NOT_FOUND);
    treetable_destroy(table);"""

def body_get_inserted(v):
    return f"""\
    int key = {v['get_found_key']}, value = {v['get_found_value']};
    void *out = NULL;
    TreeTable *table = make_table_default();
    assert(treetable_add(table, &key, &value) == CC_OK);
    assert(treetable_get(table, &key, &out) == CC_OK);
    assert(out == &value);
    treetable_destroy(table);"""

def body_first_key_min(v):
    k1, k2, k3 = v['first_k1'], v['first_k2'], v['first_k3']
    if len({k1, k2, k3}) < 3:
        return None
    return f"""\
    int k1={k1}, k2={k2}, k3={k3}, val={v['first_value']};
    void *out = NULL;
    TreeTable *table = make_table_default();
    assert(treetable_add(table, &k1, &val) == CC_OK);
    assert(treetable_add(table, &k2, &val) == CC_OK);
    assert(treetable_add(table, &k3, &val) == CC_OK);
    assert(treetable_get_first_key(table, &out) == CC_OK);
    assert(*(int*)out <= k1 && *(int*)out <= k2 && *(int*)out <= k3);
    treetable_destroy(table);"""

def body_greater_right(v):
    return f"""\
    int k1=10, k2=20, k3=30, value={v['greater_right_value']};
    void *out = NULL;
    TreeTable *table = make_table_default();
    assert(treetable_add(table, &k2, &value) == CC_OK);
    assert(treetable_add(table, &k1, &value) == CC_OK);
    assert(treetable_add(table, &k3, &value) == CC_OK);
    assert(treetable_get_greater_than(table, &k2, &out) == CC_OK);
    assert(*(int*)out == k3);
    treetable_destroy(table);"""

def body_greater_parent(v):
    return f"""\
    int k1=10, k2=20, value={v['greater_parent_value']};
    void *out = NULL;
    TreeTable *table = make_table_default();
    assert(treetable_add(table, &k2, &value) == CC_OK);
    assert(treetable_add(table, &k1, &value) == CC_OK);
    assert(treetable_get_greater_than(table, &k1, &out) == CC_OK);
    assert(*(int*)out == k2);
    treetable_destroy(table);"""

def body_greater_absent(v):
    present, absent = v['greater_present'], v['greater_absent']
    if present == absent:
        return None
    return f"""\
    int present={present}, absent={absent}, value={v['greater_absent_value']};
    void *out = NULL;
    TreeTable *table = make_table_default();
    assert(treetable_add(table, &present, &value) == CC_OK);
    assert(treetable_get_greater_than(table, &absent, &out) == CC_ERR_KEY_NOT_FOUND);
    treetable_destroy(table);"""

def body_greater_max(v):
    return f"""\
    int k1=10, k2=20, value={v['greater_max_value']};
    void *out = NULL;
    enum cc_stat status;
    TreeTable *table = make_table_default();
    assert(treetable_add(table, &k1, &value) == CC_OK);
    assert(treetable_add(table, &k2, &value) == CC_OK);
    status = treetable_get_greater_than(table, &k2, &out);
    assert(status == CC_OK || status == CC_ERR_KEY_NOT_FOUND);
    assert(balanced(table));
    assert(sorted(table));
    treetable_destroy(table);"""

def body_greater_null(v):
    return f"""\
    TreeTable table; RBNode node;
    int key={v['greater_null_successor_key']}, value={v['greater_null_successor_value']};
    void *out = NULL;
    table.root=&node; table.sentinel=NULL; table.size=1;
    table.cmp=cmp; table.mem_alloc=malloc;
    table.mem_calloc=calloc; table.mem_free=free;
    node.key=&key; node.value=&value; node.color=RB_BLACK;
    node.parent=NULL; node.left=NULL; node.right=NULL;
    assert(treetable_get_greater_than(&table, &key, &out) == CC_ERR_KEY_NOT_FOUND);"""

BODY_GENERATORS = {
    "test_add_root_preserves_validity":               body_add_root,
    "test_add_duplicate_updates_value_only":          body_add_duplicate,
    "test_add_left_and_right_children":               body_add_left_right,
    "test_add_three_symbolic_keys_preserves_validity":body_add_three,
    "test_get_missing_keys_fail":                     body_get_missing,
    "test_get_inserted_key_returns_value":            body_get_inserted,
    "test_get_first_key_is_minimum":                  body_first_key_min,
    "test_get_greater_than_uses_right_subtree_minimum": body_greater_right,
    "test_get_greater_than_walks_to_parent_successor":  body_greater_parent,
    "test_get_greater_than_absent_key_fails":           body_greater_absent,
    "test_get_greater_than_maximum_key_is_total":       body_greater_max,
    "test_get_greater_than_internal_null_successor_branch": body_greater_null,
}

FILE_HEADER = """\
/*
 * {test_name}.c — concrete test suite derived from KLEE output.
 * Auto-generated by decode_klee.py — do not edit manually.
 *
 * Build (example):
 *   clang -fprofile-instr-generate -fcoverage-mapping \\
 *         {test_name}.c ../../ex2/treetable.c \\
 *         -o {test_name} && ./{test_name}
 */
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include "../../ex2/treetable.c"

static TreeTable *make_table_default(void) {{
    TreeTable *table = NULL;
    TreeTableConf conf;
    treetable_conf_init(&conf);
    assert(treetable_new_conf(&conf, &table) == CC_OK);
    return table;
}}

"""

# ---------------------------------------------------------------------------
# Extrai os valores de um .ktest
# ---------------------------------------------------------------------------
def extract_values(ktest_path):
    result = subprocess.run(["ktest-tool", ktest_path],
                            capture_output=True, text=True)
    values = {}
    lines = result.stdout.splitlines()
    for i, line in enumerate(lines):
        m = re.match(r"object \d+: name: '(.*?)'", line)
        if m:
            var = m.group(1)
            if i + 2 >= len(lines):
                continue
            data_line = lines[i + 2]
            m2 = re.search(r"data: b'(.*?)'", data_line)
            if not m2:
                continue
            data_str = m2.group(1)
            try:
                data_bytes = codecs.decode(
                    data_str.encode('latin1'), 'unicode_escape'
                )
                if isinstance(data_bytes, str):
                    data_bytes = data_bytes.encode('latin1')
                value = int.from_bytes(data_bytes[:4], byteorder='little', signed=True)
                values[var] = value
            except Exception:
                pass
    return values

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
def main():
    klee_dir = sys.argv[1] if len(sys.argv) > 1 else "klee_output"
    out_dir  = sys.argv[2] if len(sys.argv) > 2 else "Ex3ConcTestSuite"
    os.makedirs(out_dir, exist_ok=True)

    seen   = {name: set() for name in TEST_VARS}
    bodies = {name: [] for name in TEST_VARS}

    # Suporta dois modos:
    # 1. klee_dir tem subpastas por teste (klee_output/test_add_root_.../)
    # 2. klee_dir tem .ktest directamente (modo antigo / all_ktests/)
    subdirs = [
        d for d in os.listdir(klee_dir)
        if os.path.isdir(os.path.join(klee_dir, d))
    ]

    if subdirs:
        # Modo 1: uma subpasta por teste simbólico
        all_pairs = []  # (test_name_hint, ktest_path)
        for subdir in sorted(subdirs):
            subpath = os.path.join(klee_dir, subdir)
            for fname in sorted(os.listdir(subpath)):
                if fname.endswith(".ktest"):
                    # O nome da subpasta é o nome do teste simbólico
                    all_pairs.append((subdir, os.path.join(subpath, fname)))
        print(f"Modo subpastas: {len(subdirs)} directorias, "
              f"{len(all_pairs)} ficheiros .ktest no total ...")
    else:
        # Modo 2: .ktest directamente em klee_dir
        all_pairs = [
            (None, os.path.join(klee_dir, f))
            for f in sorted(os.listdir(klee_dir))
            if f.endswith(".ktest")
        ]
        print(f"Modo flat: {len(all_pairs)} ficheiros .ktest de '{klee_dir}' ...")

    for hint_name, ktest_path in all_pairs:
        values = extract_values(ktest_path)
        fname  = os.path.basename(ktest_path)

        for test_name, needed_vars in TEST_VARS.items():
            # Em modo subpastas, só processamos o teste correspondente à pasta
            if hint_name and hint_name != test_name:
                continue

            if not all(v in values for v in needed_vars):
                continue

            key_tuple = tuple(values[v] for v in needed_vars)
            if key_tuple in seen[test_name]:
                continue
            seen[test_name].add(key_tuple)

            body = BODY_GENERATORS[test_name](values)
            if body is None:
                continue

            bodies[test_name].append((fname, body))

    # Escreve os ficheiros C
    total = 0
    for test_name, cases in bodies.items():
        if not cases:
            print(f"  AVISO: nenhum caso gerado para {test_name}")
            continue

        out_path = os.path.join(out_dir, f"{test_name}.c")
        with open(out_path, "w") as f:
            f.write(FILE_HEADER.format(test_name=test_name))

            # Escreve cada caso como função estática
            for idx, (source_ktest, body) in enumerate(cases, 1):
                f.write(f"/* case {idx} — from {source_ktest} */\n")
                f.write(f"static void {test_name}_case{idx}(void) {{\n")
                for line in body.splitlines():
                    f.write(f"    {line}\n")
                f.write("}\n\n")

            # main() chama todos os casos
            f.write("int main(void) {\n")
            for idx in range(1, len(cases) + 1):
                f.write(f"    {test_name}_case{idx}();\n")
            f.write(f'    printf("{test_name}: %d case(s) passed.\\n", {len(cases)});\n')
            f.write("    return 0;\n}\n")

        print(f"  {test_name}.c  →  {len(cases)} caso(s) únicos")
        total += len(cases)

    print(f"\nTotal: {total} casos concretos únicos em {out_dir}/")

if __name__ == "__main__":
    main()