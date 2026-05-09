# Valgrind



Valgrind Memcheck is a **dynamic analysis** tool, meaning it analyses a program while it is actually running and monitors how memory is used during execution.

This differs from Infer and clang-analyzer used in Exercise 1, which are **static analysis** tools. Static analysers inspect the source code without executing the program and attempt to predict potential bugs. Valgrind instead observes real executions and reports errors that actually occur during runtime.

It also differs from AFL++ used in Exercise 2. AFL++ is a fuzzing tool that automatically generates many different inputs to trigger crashes or unexpected behaviour. Valgrind does not generate inputs; it only analyses the executions provided by the user.

Compared to KLEE from Exercise 3, which uses symbolic execution to reason about many possible program paths, Valgrind only checks the specific execution paths that are run.

Valgrind is especially useful for detecting memory-related bugs such as memory leaks, invalid memory accesses, use-after-free errors, and double frees.



---





**Command 1**

```bash
root@3e1e268edcb3:/project/ex4# valgrind --leak-check=full --track-origins=yes ./hashmap_test
```



```bash
==183== Memcheck, a memory error detector
==183== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
==183== Using Valgrind-3.16.1 and LibVEX; rerun with -h for copyright info
==183== Command: ./hashmap_test
==183== 
==183== 
==183== HEAP SUMMARY:
==183==     in use at exit: 4 bytes in 1 blocks
==183==   total heap usage: 6 allocs, 5 frees, 184 bytes allocated
==183== 
==183== 4 bytes in 1 blocks are definitely lost in loss record 1 of 1
==183==    at 0x483877F: malloc (vg_replace_malloc.c:307)
==183==    by 0x4016F3: hashmap_get (hashmap.c:155)
==183==    by 0x4017A7: main (hashmap.c:169)
==183== 
==183== LEAK SUMMARY:
==183==    definitely lost: 4 bytes in 1 blocks
==183==    indirectly lost: 0 bytes in 0 blocks
==183==      possibly lost: 0 bytes in 0 blocks
==183==    still reachable: 0 bytes in 0 blocks
==183==         suppressed: 0 bytes in 0 blocks
==183== 
==183== For lists of detected and suppressed errors, rerun with: -s
==183== ERROR SUMMARY: 1 errors from 1 contexts (suppressed: 0 from 0)
```

This command runs Valgrind's Memcheck tool with full leak checking and origin tracking enabled on the buggy `hashmap.c`. The output reveals:

**HEAP SUMMARY** shows the program made 6 allocations and only freed 5 — meaning 1 block of 4 bytes was never freed.

**The leak** is traced precisely:

- Memory was allocated by `malloc` inside `hashmap_get` at **line 155**
- Which was called from `main` at **line 169**

This is exactly **Bug-11** from Exercise 1.2 — `hashmap_get` returns a heap-allocated copy of the value, but `main` never calls `free(ret)` after using it.

**LEAK SUMMARY** categorises the leak as *definitely lost* — meaning no pointer to the block exists anywhere in memory, so the program has permanently lost access to it and can never free it.

**ERROR SUMMARY** reports 1 error — Valgrind counts a definite leak as an error when `--leak-check=full` is used.

---



**Command 2**

```bash
/project/ex4# valgrind --tool=memcheck --error-exitcode=1 ./hashmap_test
```



```bash
==184== Memcheck, a memory error detector
==184== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
==184== Using Valgrind-3.16.1 and LibVEX; rerun with -h for copyright info
==184== Command: ./hashmap_test
==184== 
==184== 
==184== HEAP SUMMARY:
==184==     in use at exit: 4 bytes in 1 blocks
==184==   total heap usage: 6 allocs, 5 frees, 184 bytes allocated
==184== 
==184== LEAK SUMMARY:
==184==    definitely lost: 4 bytes in 1 blocks
==184==    indirectly lost: 0 bytes in 0 blocks
==184==      possibly lost: 0 bytes in 0 blocks
==184==    still reachable: 0 bytes in 0 blocks
==184==         suppressed: 0 bytes in 0 blocks
==184== Rerun with --leak-check=full to see details of leaked memory
==184== 
==184== For lists of detected and suppressed errors, rerun with: -s
==184== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)
```



This run uses `--tool=memcheck` explicitly (which is actually Valgrind's default tool) and `--error-exitcode=1`. The key difference from Command 1 is what's **missing** — there is no `--leak-check=full` flag.

**The most important line is:** `ERROR SUMMARY: 0 errors from 0 contexts`

This seems to contradict Command 1 which reported 1 error — but it doesn't. Without `--leak-check=full`, Valgrind **does not count memory leaks as errors**. It only counts hard errors like invalid reads, invalid writes, and use-after-free. Since the concrete test in `main` doesn't trigger those paths, Valgrind reports zero errors.

**The LEAK SUMMARY still shows the leak** — 4 bytes definitely lost — but Valgrind even tells you itself: `Rerun with --leak-check=full to see details of leaked memory`.

**The key takeaway** is that this illustrates an important limitation of dynamic analysis: the result depends entirely on which flags you use and which code paths your concrete test exercises. A developer running Valgrind without `--leak-check=full` could incorrectly conclude the program is clean.

---



**Command 3**



```bash
root@3e1e268edcb3:/project/ex4# valgrind --leak-check=full --track-origins=yes --show-leak-kinds=all -v ./hashmap_test
```



```bash
==186== Memcheck, a memory error detector
==186== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
==186== Using Valgrind-3.16.1-36d6727e1d-20200622X and LibVEX; rerun with -h for copyright info
==186== Command: ./hashmap_test
==186== 
--186-- Valgrind options:
--186--    --leak-check=full
--186--    --track-origins=yes
--186--    --show-leak-kinds=all
--186--    -v
--186-- Contents of /proc/version:
--186--   Linux version 6.10.14-linuxkit (root@buildkitsandbox) (gcc (Alpine 13.2.1_git20240309) 13.2.1 20240309, GNU ld (GNU Binutils) 2.42) #1 SMP Wed Sep 10 06:47:45 UTC 2025
--186-- 
--186-- Arch and hwcaps: AMD64, LittleEndian, amd64-cx16-lzcnt-rdtscp-sse3-ssse3-avx-avx2-bmi-f16c-rdrand
--186-- Page sizes: currently 4096, max supported 4096
--186-- Valgrind library directory: /usr/lib/x86_64-linux-gnu/valgrind
--186-- Reading syms from /project/ex4/hashmap_test
--186-- Reading syms from /lib/x86_64-linux-gnu/ld-2.31.so
--186--   Considering /usr/lib/debug/.build-id/1b/3277a419c3fa42b199e5a170ea215b32689793.debug ..
--186--   .. build-id is valid
--186-- Reading syms from /usr/lib/x86_64-linux-gnu/valgrind/memcheck-amd64-linux
--186--   Considering /usr/lib/debug/.build-id/54/299c4aec0e5e5f3d7b8135341351d0e1dbfc64.debug ..
--186--   .. build-id is valid
--186--    object doesn't have a dynamic symbol table
--186-- WARNING: Serious error when reading debug info
--186-- When reading debug info from /run/rosetta/rosetta:
--186-- failed to stat64/stat this file
--186-- WARNING: Serious error when reading debug info
--186-- When reading debug info from /run/rosetta/rosetta:
--186-- failed to stat64/stat this file
--186-- WARNING: Serious error when reading debug info
--186-- When reading debug info from /run/rosetta/rosetta:
--186-- failed to stat64/stat this file
--186-- Scheduler: using generic scheduler lock implementation.
--186-- Reading suppressions file: /usr/lib/x86_64-linux-gnu/valgrind/default.supp
==186== embedded gdbserver: reading from /tmp/vgdb-pipe-from-vgdb-to-186-by-???-on-3e1e268edcb3
==186== embedded gdbserver: writing to   /tmp/vgdb-pipe-to-vgdb-from-186-by-???-on-3e1e268edcb3
==186== embedded gdbserver: shared mem   /tmp/vgdb-pipe-shared-mem-vgdb-186-by-???-on-3e1e268edcb3
==186== 
==186== TO CONTROL THIS PROCESS USING vgdb (which you probably
==186== don't want to do, unless you know exactly what you're doing,
==186== or are doing some strange experiment):
==186==   /usr/bin/vgdb --pid=186 ...command...
==186== 
==186== TO DEBUG THIS PROCESS USING GDB: start GDB like this
==186==   /path/to/gdb ./hashmap_test
==186== and then give GDB the following command
==186==   target remote | /usr/bin/vgdb --pid=186
==186== --pid is optional if only one valgrind process is running
==186== 
--186-- REDIR: 0x401faa0 (ld-linux-x86-64.so.2:strlen) redirected to 0x580ca5f2 (vgPlain_amd64_linux_REDIR_FOR_strlen)
--186-- REDIR: 0x401f880 (ld-linux-x86-64.so.2:index) redirected to 0x580ca60c (vgPlain_amd64_linux_REDIR_FOR_index)
--186-- Reading syms from /usr/lib/x86_64-linux-gnu/valgrind/vgpreload_core-amd64-linux.so
--186--   Considering /usr/lib/debug/.build-id/f2/7641e081d3c37b410d7f31da4e2bf21040f356.debug ..
--186--   .. build-id is valid
--186-- Reading syms from /usr/lib/x86_64-linux-gnu/valgrind/vgpreload_memcheck-amd64-linux.so
--186--   Considering /usr/lib/debug/.build-id/25/7cdcdf80e04f91ca9e3b185ee3b52995e89946.debug ..
--186--   .. build-id is valid
==186== WARNING: new redirection conflicts with existing -- ignoring it
--186--     old: 0x0401faa0 (strlen              ) R-> (0000.0) 0x580ca5f2 vgPlain_amd64_linux_REDIR_FOR_strlen
--186--     new: 0x0401faa0 (strlen              ) R-> (2007.0) 0x0483bda0 strlen
--186-- REDIR: 0x401c2c0 (ld-linux-x86-64.so.2:strcmp) redirected to 0x483cc90 (strcmp)
--186-- REDIR: 0x401ffe0 (ld-linux-x86-64.so.2:mempcpy) redirected to 0x4840740 (mempcpy)
--186-- Reading syms from /lib/x86_64-linux-gnu/libc-2.31.so
--186--   Considering /usr/lib/debug/.build-id/a7/27537547829074887adbdd56624e44bb0011bb.debug ..
--186--   .. build-id is valid
--186-- REDIR: 0x48d6e20 (libc.so.6:memmove) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--186-- REDIR: 0x48d6120 (libc.so.6:strncpy) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--186-- REDIR: 0x48d72e0 (libc.so.6:strcasecmp) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--186-- REDIR: 0x48d5870 (libc.so.6:strcat) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--186-- REDIR: 0x48d61b0 (libc.so.6:rindex) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--186-- REDIR: 0x48d86e0 (libc.so.6:rawmemchr) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--186-- REDIR: 0x48f0a30 (libc.so.6:wmemchr) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--186-- REDIR: 0x48f0500 (libc.so.6:wcscmp) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--186-- REDIR: 0x48d7060 (libc.so.6:mempcpy) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--186-- REDIR: 0x48d6d90 (libc.so.6:bcmp) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--186-- REDIR: 0x48d6070 (libc.so.6:strncmp) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--186-- REDIR: 0x48d5990 (libc.so.6:strcmp) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--186-- REDIR: 0x48d6f50 (libc.so.6:memset) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--186-- REDIR: 0x48f0490 (libc.so.6:wcschr) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--186-- REDIR: 0x48d5f70 (libc.so.6:strnlen) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--186-- REDIR: 0x48d5ae0 (libc.so.6:strcspn) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--186-- REDIR: 0x48d7330 (libc.so.6:strncasecmp) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--186-- REDIR: 0x48d5a50 (libc.so.6:strcpy) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--186-- REDIR: 0x48d7480 (libc.so.6:memcpy@@GLIBC_2.14) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--186-- REDIR: 0x48f1ca0 (libc.so.6:wcsnlen) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--186-- REDIR: 0x48f0570 (libc.so.6:wcscpy) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--186-- REDIR: 0x48d6220 (libc.so.6:strpbrk) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--186-- REDIR: 0x48d5900 (libc.so.6:index) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--186-- REDIR: 0x48d5f00 (libc.so.6:strlen) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--186-- REDIR: 0x48dcaa0 (libc.so.6:memrchr) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--186-- REDIR: 0x48d7380 (libc.so.6:strcasecmp_l) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--186-- REDIR: 0x48d6d20 (libc.so.6:memchr) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--186-- REDIR: 0x48f0610 (libc.so.6:wcslen) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--186-- REDIR: 0x48d64c0 (libc.so.6:strspn) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--186-- REDIR: 0x48d7250 (libc.so.6:stpncpy) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--186-- REDIR: 0x48d71c0 (libc.so.6:stpcpy) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--186-- REDIR: 0x48d8750 (libc.so.6:strchrnul) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--186-- REDIR: 0x48d73d0 (libc.so.6:strncasecmp_l) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--186-- REDIR: 0x49a91f0 (libc.so.6:__strrchr_avx2) redirected to 0x483b7b0 (rindex)
--186-- REDIR: 0x48d1df0 (libc.so.6:malloc) redirected to 0x4838710 (malloc)
--186-- REDIR: 0x49a93c0 (libc.so.6:__strlen_avx2) redirected to 0x483bc80 (strlen)
--186-- REDIR: 0x49ac350 (libc.so.6:__memcpy_avx_unaligned_erms) redirected to 0x483f760 (memmove)
--186-- REDIR: 0x49aa890 (libc.so.6:__strcpy_avx2) redirected to 0x483bdd0 (strcpy)
--186-- REDIR: 0x49a48e0 (libc.so.6:__strcmp_avx2) redirected to 0x483cb90 (strcmp)
--186-- REDIR: 0x48d2420 (libc.so.6:free) redirected to 0x4839940 (free)
==186== 
==186== HEAP SUMMARY:
==186==     in use at exit: 4 bytes in 1 blocks
==186==   total heap usage: 6 allocs, 5 frees, 184 bytes allocated
==186== 
==186== Searching for pointers to 1 not-freed blocks
==186== Checked 66,784 bytes
==186== 
==186== 4 bytes in 1 blocks are definitely lost in loss record 1 of 1
==186==    at 0x483877F: malloc (vg_replace_malloc.c:307)
==186==    by 0x4016F3: hashmap_get (hashmap.c:155)
==186==    by 0x4017A7: main (hashmap.c:169)
==186== 
==186== LEAK SUMMARY:
==186==    definitely lost: 4 bytes in 1 blocks
==186==    indirectly lost: 0 bytes in 0 blocks
==186==      possibly lost: 0 bytes in 0 blocks
==186==    still reachable: 0 bytes in 0 blocks
==186==         suppressed: 0 bytes in 0 blocks
==186== 
==186== ERROR SUMMARY: 1 errors from 1 contexts (suppressed: 0 from 0)

```

This is the most verbose run, adding `--show-leak-kinds=all` and `-v` to the previous command. The extra output reveals how Valgrind works internally:

**The `--186--` lines** (verbose internals) show Valgrind intercepting every memory-related function in the program — `malloc`, `free`, `memcpy`, `strcpy`, `strcmp` etc. are all **redirected** to Valgrind's own versions so every memory access can be monitored. This confirms Valgrind is a true dynamic analysis tool — it sits between the program and the OS, observing everything at runtime.

**The WARNING about `/run/rosetta/rosetta`** is harmless — it just means Valgrind can't read debug symbols from Apple's Rosetta translation layer (since we're running amd64 Linux on an M4 Mac via Docker).

**`Searching for pointers to 1 not-freed blocks` / `Checked 66,784 bytes`** — Valgrind actively scans all reachable memory looking for any pointer that might still reference the leaked block. Finding none, it confirms the leak is *definitely lost*.

**The final result is identical to Command 1** — same 4 bytes leaked, same location. The verbose mode adds transparency into Valgrind's process but doesn't change the findings.




