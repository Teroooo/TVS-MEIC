# Valgrind

Commands line

---

**Starting 200 Word statement**



Valgrind Memcheck is a dynamic analysis tool that detects memory-management errors by executing a program and monitoring its memory operations at runtime. Unlike the static-analysis tools used in Exercise 1 (Infer and clang-analyzer), Valgrind does not inspect source code to predict possible bugs; instead, it reports errors that actually occur during a concrete execution. It also differs from AFL++ in Exercise 2, which automatically generates inputs to explore program behaviour, and from KLEE in Exercise 3, which symbolically reasons about many possible execution paths. Valgrind only analyses the execution paths triggered by the provided inputs.
For this exercise, hashmap.c was extended with a custom driver to exercise additional buggy paths. The modified test uses long keys to trigger the unsafe malloc(sizeof(key)) + strcpy sequence, inserts multiple keys to force bucket growth, and performs repeated hashmap_get calls without freeing the returned memory. Designing these inputs required prior knowledge of the bugs found in Exercise 1 — a known limitation of dynamic analysis, since Valgrind cannot discover bugs that are never triggered. These targeted tests were intentionally constructed to provide more extensive coverage of the known defects. Valgrind is particularly effective at detecting memory leaks, invalid memory accesses, use-after-free errors, and double frees.

---

**Compile**

```bash
antoniopalma@Antonios-MacBook-Pro (2)Ex4 % gcc -g -o hashmap_test hashmap.c                                                                                                                  
antoniopalma@Antonios-MacBook-Pro (2)Ex4 % gcc -g -DDRIVER_MAIN hashmap.c hashmap_driver.c -o hashmap_driver
```



---

**Command 1**

```bash
root@6f717a90affe:/project/2-Ex4# valgrind --leak-check=full --track-origins=yes ./hashmap_driver
```

```bash

==539== Memcheck, a memory error detector
==539== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
==539== Using Valgrind-3.16.1 and LibVEX; rerun with -h for copyright info
==539== Command: ./hashmap_driver
==539== 
==539== Invalid write of size 1
==539==    at 0x483BDE4: strcpy (vg_replace_strmem.c:511)
==539==    by 0x109528: hashmap_set (hashmap.c:125)
==539==    by 0x10973C: main (hashmap_driver.c:29)
==539==  Address 0x4a231b8 is 0 bytes after a block of size 8 alloc'd
==539==    at 0x483877F: malloc (vg_replace_malloc.c:307)
==539==    by 0x109508: hashmap_set (hashmap.c:124)
==539==    by 0x10973C: main (hashmap_driver.c:29)
==539== 
==539== Invalid write of size 1
==539==    at 0x483BDF6: strcpy (vg_replace_strmem.c:511)
==539==    by 0x109528: hashmap_set (hashmap.c:125)
==539==    by 0x10973C: main (hashmap_driver.c:29)
==539==  Address 0x4a231c1 is 9 bytes after a block of size 8 alloc'd
==539==    at 0x483877F: malloc (vg_replace_malloc.c:307)
==539==    by 0x109508: hashmap_set (hashmap.c:124)
==539==    by 0x10973C: main (hashmap_driver.c:29)
==539== 
==539== Invalid read of size 1
==539==    at 0x483CBA8: strcmp (vg_replace_strmem.c:847)
==539==    by 0x1096B1: hashmap_get (hashmap.c:154)
==539==    by 0x109876: main (hashmap_driver.c:49)
==539==  Address 0x4a231b8 is 0 bytes after a block of size 8 alloc'd
==539==    at 0x483877F: malloc (vg_replace_malloc.c:307)
==539==    by 0x109508: hashmap_set (hashmap.c:124)
==539==    by 0x10973C: main (hashmap_driver.c:29)
==539== 
==539== 
==539== HEAP SUMMARY:
==539==     in use at exit: 300 bytes in 12 blocks
==539==   total heap usage: 56 allocs, 44 frees, 1,056 bytes allocated
==539== 
==539== 4 bytes in 1 blocks are definitely lost in loss record 1 of 5
==539==    at 0x483877F: malloc (vg_replace_malloc.c:307)
==539==    by 0x1096C5: hashmap_get (hashmap.c:155)
==539==    by 0x109876: main (hashmap_driver.c:49)
==539== 
==539== 4 bytes in 1 blocks are definitely lost in loss record 2 of 5
==539==    at 0x483877F: malloc (vg_replace_malloc.c:307)
==539==    by 0x1096C5: hashmap_get (hashmap.c:155)
==539==    by 0x10988D: main (hashmap_driver.c:50)
==539== 
==539== 4 bytes in 1 blocks are definitely lost in loss record 3 of 5
==539==    at 0x483877F: malloc (vg_replace_malloc.c:307)
==539==    by 0x1096C5: hashmap_get (hashmap.c:155)
==539==    by 0x1098A4: main (hashmap_driver.c:51)
==539== 
==539== 24 bytes in 1 blocks are definitely lost in loss record 4 of 5
==539==    at 0x483877F: malloc (vg_replace_malloc.c:307)
==539==    by 0x1094A2: hashmap_set (hashmap.c:118)
==539==    by 0x10973C: main (hashmap_driver.c:29)
==539== 
==539== 264 bytes in 8 blocks are definitely lost in loss record 5 of 5
==539==    at 0x483877F: malloc (vg_replace_malloc.c:307)
==539==    by 0x1094A2: hashmap_set (hashmap.c:118)
==539==    by 0x109859: main (hashmap_driver.c:43)
==539== 
==539== LEAK SUMMARY:
==539==    definitely lost: 300 bytes in 12 blocks
==539==    indirectly lost: 0 bytes in 0 blocks
==539==      possibly lost: 0 bytes in 0 blocks
==539==    still reachable: 0 bytes in 0 blocks
==539==         suppressed: 0 bytes in 0 blocks
==539== 
==539== For lists of detected and suppressed errors, rerun with: -s
==539== ERROR SUMMARY: 25 errors from 8 contexts (suppressed: 0 from 0)
```

**Screenshot 1 (hashmap_driver, clean flags)**

Three distinct bug classes found:

- `Invalid write of size 1` at `hashmap.c:125` — `strcpy` overflows the 8-byte buffer allocated by `malloc(sizeof(key))` at line 124. Valgrind catches both the first byte past the boundary and the null terminator 9 bytes past.
- `Invalid read of size 1` at `hashmap.c:154` — `strcmp` in `hashmap_get` later reads into the same overflowed region.
- 12 blocks definitely lost (300 bytes total):
  - 3 × 4 bytes from `hashmap_get` return values never freed (lines 49–51 of driver)
  - 1 × 24 bytes + 8 × 33 bytes from `hashmap_set` at line 118 — old `field->entries` pointers leaked on bucket growth



---

**Command 2**



```bash
root@6f717a90affe:/project/2-Ex4# valgrind --leak-check=full --track-origins=yes ./hashmap_test
```



```bash
==541== Memcheck, a memory error detector
==541== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
==541== Using Valgrind-3.16.1 and LibVEX; rerun with -h for copyright info
==541== Command: ./hashmap_test
==541== 
==541== 
==541== HEAP SUMMARY:
==541==     in use at exit: 4 bytes in 1 blocks
==541==   total heap usage: 6 allocs, 5 frees, 184 bytes allocated
==541== 
==541== 4 bytes in 1 blocks are definitely lost in loss record 1 of 1
==541==    at 0x483877F: malloc (vg_replace_malloc.c:307)
==541==    by 0x1096D5: hashmap_get (hashmap.c:155)
==541==    by 0x109764: main (hashmap.c:170)
==541== 
==541== LEAK SUMMARY:
==541==    definitely lost: 4 bytes in 1 blocks
==541==    indirectly lost: 0 bytes in 0 blocks
==541==      possibly lost: 0 bytes in 0 blocks
==541==    still reachable: 0 bytes in 0 blocks
==541==         suppressed: 0 bytes in 0 blocks
==541== 
==541== For lists of detected and suppressed errors, rerun with: -s
==541== ERROR SUMMARY: 1 errors from 1 contexts (suppressed: 0 from 0)
```

**Screenshot 2 (hashmap_test, comparison)**

Only 1 error, 1 block (4 bytes) lost — the minimal test never calls `hashmap_set` with a long key or causes bucket collisions, so Valgrind sees almost nothing.



---

**Command 3**



```bash
root@6f717a90affe:/project/2-Ex4# valgrind --leak-check=full --track-origins=yes --show-leak-kinds=all -v ./hashmap_driver
==543== Memcheck, a memory error detector
==543== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
==543== Using Valgrind-3.16.1-36d6727e1d-20200622X and LibVEX; rerun with -h for copyright info
==543== Command: ./hashmap_driver
==543== 
--543-- Valgrind options:
--543--    --leak-check=full
--543--    --track-origins=yes
--543--    --show-leak-kinds=all
--543--    -v
--543-- Contents of /proc/version:
--543--   Linux version 6.10.14-linuxkit (root@buildkitsandbox) (gcc (Alpine 13.2.1_git20240309) 13.2.1 20240309, GNU ld (GNU Binutils) 2.42) #1 SMP Wed Sep 10 06:47:45 UTC 2025
--543-- 
--543-- Arch and hwcaps: AMD64, LittleEndian, amd64-cx16-lzcnt-rdtscp-sse3-ssse3-avx-avx2-bmi-f16c-rdrand
--543-- Page sizes: currently 4096, max supported 4096
--543-- Valgrind library directory: /usr/lib/x86_64-linux-gnu/valgrind
--543-- Reading syms from /project/2-Ex4/hashmap_driver
--543-- Reading syms from /lib/x86_64-linux-gnu/ld-2.31.so
--543--   Considering /usr/lib/debug/.build-id/1b/3277a419c3fa42b199e5a170ea215b32689793.debug ..
--543--   .. build-id is valid
--543-- Reading syms from /usr/lib/x86_64-linux-gnu/valgrind/memcheck-amd64-linux
--543--   Considering /usr/lib/debug/.build-id/54/299c4aec0e5e5f3d7b8135341351d0e1dbfc64.debug ..
--543--   .. build-id is valid
--543--    object doesn't have a dynamic symbol table
--543-- WARNING: Serious error when reading debug info
--543-- When reading debug info from /run/rosetta/rosetta:
--543-- failed to stat64/stat this file
--543-- WARNING: Serious error when reading debug info
--543-- When reading debug info from /run/rosetta/rosetta:
--543-- failed to stat64/stat this file
--543-- WARNING: Serious error when reading debug info
--543-- When reading debug info from /run/rosetta/rosetta:
--543-- failed to stat64/stat this file
--543-- Scheduler: using generic scheduler lock implementation.
--543-- Reading suppressions file: /usr/lib/x86_64-linux-gnu/valgrind/default.supp
==543== embedded gdbserver: reading from /tmp/vgdb-pipe-from-vgdb-to-543-by-???-on-6f717a90affe
==543== embedded gdbserver: writing to   /tmp/vgdb-pipe-to-vgdb-from-543-by-???-on-6f717a90affe
==543== embedded gdbserver: shared mem   /tmp/vgdb-pipe-shared-mem-vgdb-543-by-???-on-6f717a90affe
==543== 
==543== TO CONTROL THIS PROCESS USING vgdb (which you probably
==543== don't want to do, unless you know exactly what you're doing,
==543== or are doing some strange experiment):
==543==   /usr/bin/vgdb --pid=543 ...command...
==543== 
==543== TO DEBUG THIS PROCESS USING GDB: start GDB like this
==543==   /path/to/gdb ./hashmap_driver
==543== and then give GDB the following command
==543==   target remote | /usr/bin/vgdb --pid=543
==543== --pid is optional if only one valgrind process is running
==543== 
--543-- REDIR: 0x401faa0 (ld-linux-x86-64.so.2:strlen) redirected to 0x580ca5f2 (vgPlain_amd64_linux_REDIR_FOR_strlen)
--543-- REDIR: 0x401f880 (ld-linux-x86-64.so.2:index) redirected to 0x580ca60c (vgPlain_amd64_linux_REDIR_FOR_index)
--543-- Reading syms from /usr/lib/x86_64-linux-gnu/valgrind/vgpreload_core-amd64-linux.so
--543--   Considering /usr/lib/debug/.build-id/f2/7641e081d3c37b410d7f31da4e2bf21040f356.debug ..
--543--   .. build-id is valid
--543-- Reading syms from /usr/lib/x86_64-linux-gnu/valgrind/vgpreload_memcheck-amd64-linux.so
--543--   Considering /usr/lib/debug/.build-id/25/7cdcdf80e04f91ca9e3b185ee3b52995e89946.debug ..
--543--   .. build-id is valid
==543== WARNING: new redirection conflicts with existing -- ignoring it
--543--     old: 0x0401faa0 (strlen              ) R-> (0000.0) 0x580ca5f2 vgPlain_amd64_linux_REDIR_FOR_strlen
--543--     new: 0x0401faa0 (strlen              ) R-> (2007.0) 0x0483bda0 strlen
--543-- REDIR: 0x401c2c0 (ld-linux-x86-64.so.2:strcmp) redirected to 0x483cc90 (strcmp)
--543-- REDIR: 0x401ffe0 (ld-linux-x86-64.so.2:mempcpy) redirected to 0x4840740 (mempcpy)
--543-- Reading syms from /lib/x86_64-linux-gnu/libc-2.31.so
--543--   Considering /usr/lib/debug/.build-id/a7/27537547829074887adbdd56624e44bb0011bb.debug ..
--543--   .. build-id is valid
--543-- REDIR: 0x48d6e20 (libc.so.6:memmove) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--543-- REDIR: 0x48d6120 (libc.so.6:strncpy) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--543-- REDIR: 0x48d72e0 (libc.so.6:strcasecmp) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--543-- REDIR: 0x48d5870 (libc.so.6:strcat) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--543-- REDIR: 0x48d61b0 (libc.so.6:rindex) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--543-- REDIR: 0x48d86e0 (libc.so.6:rawmemchr) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--543-- REDIR: 0x48f0a30 (libc.so.6:wmemchr) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--543-- REDIR: 0x48f0500 (libc.so.6:wcscmp) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--543-- REDIR: 0x48d7060 (libc.so.6:mempcpy) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--543-- REDIR: 0x48d6d90 (libc.so.6:bcmp) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--543-- REDIR: 0x48d6070 (libc.so.6:strncmp) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--543-- REDIR: 0x48d5990 (libc.so.6:strcmp) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--543-- REDIR: 0x48d6f50 (libc.so.6:memset) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--543-- REDIR: 0x48f0490 (libc.so.6:wcschr) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--543-- REDIR: 0x48d5f70 (libc.so.6:strnlen) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--543-- REDIR: 0x48d5ae0 (libc.so.6:strcspn) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--543-- REDIR: 0x48d7330 (libc.so.6:strncasecmp) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--543-- REDIR: 0x48d5a50 (libc.so.6:strcpy) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--543-- REDIR: 0x48d7480 (libc.so.6:memcpy@@GLIBC_2.14) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--543-- REDIR: 0x48f1ca0 (libc.so.6:wcsnlen) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--543-- REDIR: 0x48f0570 (libc.so.6:wcscpy) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--543-- REDIR: 0x48d6220 (libc.so.6:strpbrk) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--543-- REDIR: 0x48d5900 (libc.so.6:index) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--543-- REDIR: 0x48d5f00 (libc.so.6:strlen) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--543-- REDIR: 0x48dcaa0 (libc.so.6:memrchr) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--543-- REDIR: 0x48d7380 (libc.so.6:strcasecmp_l) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--543-- REDIR: 0x48d6d20 (libc.so.6:memchr) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--543-- REDIR: 0x48f0610 (libc.so.6:wcslen) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--543-- REDIR: 0x48d64c0 (libc.so.6:strspn) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--543-- REDIR: 0x48d7250 (libc.so.6:stpncpy) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--543-- REDIR: 0x48d71c0 (libc.so.6:stpcpy) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--543-- REDIR: 0x48d8750 (libc.so.6:strchrnul) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--543-- REDIR: 0x48d73d0 (libc.so.6:strncasecmp_l) redirected to 0x482e1b0 (_vgnU_ifunc_wrapper)
--543-- REDIR: 0x49a91f0 (libc.so.6:__strrchr_avx2) redirected to 0x483b7b0 (rindex)
--543-- REDIR: 0x48d1df0 (libc.so.6:malloc) redirected to 0x4838710 (malloc)
--543-- REDIR: 0x49a93c0 (libc.so.6:__strlen_avx2) redirected to 0x483bc80 (strlen)
--543-- REDIR: 0x49ac350 (libc.so.6:__memcpy_avx_unaligned_erms) redirected to 0x483f760 (memmove)
--543-- REDIR: 0x49aa890 (libc.so.6:__strcpy_avx2) redirected to 0x483bdd0 (strcpy)
==543== Invalid write of size 1
==543==    at 0x483BDE4: strcpy (vg_replace_strmem.c:511)
==543==    by 0x109528: hashmap_set (hashmap.c:125)
==543==    by 0x10973C: main (hashmap_driver.c:29)
==543==  Address 0x4a231b8 is 0 bytes after a block of size 8 alloc'd
==543==    at 0x483877F: malloc (vg_replace_malloc.c:307)
==543==    by 0x109508: hashmap_set (hashmap.c:124)
==543==    by 0x10973C: main (hashmap_driver.c:29)
==543== 
==543== Invalid write of size 1
==543==    at 0x483BDF6: strcpy (vg_replace_strmem.c:511)
==543==    by 0x109528: hashmap_set (hashmap.c:125)
==543==    by 0x10973C: main (hashmap_driver.c:29)
==543==  Address 0x4a231c1 is 9 bytes after a block of size 8 alloc'd
==543==    at 0x483877F: malloc (vg_replace_malloc.c:307)
==543==    by 0x109508: hashmap_set (hashmap.c:124)
==543==    by 0x10973C: main (hashmap_driver.c:29)
==543== 
--543-- REDIR: 0x49a48e0 (libc.so.6:__strcmp_avx2) redirected to 0x483cb90 (strcmp)
==543== Invalid read of size 1
==543==    at 0x483CBA8: strcmp (vg_replace_strmem.c:847)
==543==    by 0x1096B1: hashmap_get (hashmap.c:154)
==543==    by 0x109876: main (hashmap_driver.c:49)
==543==  Address 0x4a231b8 is 0 bytes after a block of size 8 alloc'd
==543==    at 0x483877F: malloc (vg_replace_malloc.c:307)
==543==    by 0x109508: hashmap_set (hashmap.c:124)
==543==    by 0x10973C: main (hashmap_driver.c:29)
==543== 
--543-- REDIR: 0x48d2420 (libc.so.6:free) redirected to 0x4839940 (free)
==543== 
==543== HEAP SUMMARY:
==543==     in use at exit: 300 bytes in 12 blocks
==543==   total heap usage: 56 allocs, 44 frees, 1,056 bytes allocated
==543== 
==543== Searching for pointers to 12 not-freed blocks
==543== Checked 66,800 bytes
==543== 
==543== 4 bytes in 1 blocks are definitely lost in loss record 1 of 5
==543==    at 0x483877F: malloc (vg_replace_malloc.c:307)
==543==    by 0x1096C5: hashmap_get (hashmap.c:155)
==543==    by 0x109876: main (hashmap_driver.c:49)
==543== 
==543== 4 bytes in 1 blocks are definitely lost in loss record 2 of 5
==543==    at 0x483877F: malloc (vg_replace_malloc.c:307)
==543==    by 0x1096C5: hashmap_get (hashmap.c:155)
==543==    by 0x10988D: main (hashmap_driver.c:50)
==543== 
==543== 4 bytes in 1 blocks are definitely lost in loss record 3 of 5
==543==    at 0x483877F: malloc (vg_replace_malloc.c:307)
==543==    by 0x1096C5: hashmap_get (hashmap.c:155)
==543==    by 0x1098A4: main (hashmap_driver.c:51)
==543== 
==543== 24 bytes in 1 blocks are definitely lost in loss record 4 of 5
==543==    at 0x483877F: malloc (vg_replace_malloc.c:307)
==543==    by 0x1094A2: hashmap_set (hashmap.c:118)
==543==    by 0x10973C: main (hashmap_driver.c:29)
==543== 
==543== 264 bytes in 8 blocks are definitely lost in loss record 5 of 5
==543==    at 0x483877F: malloc (vg_replace_malloc.c:307)
==543==    by 0x1094A2: hashmap_set (hashmap.c:118)
==543==    by 0x109859: main (hashmap_driver.c:43)
==543== 
==543== LEAK SUMMARY:
==543==    definitely lost: 300 bytes in 12 blocks
==543==    indirectly lost: 0 bytes in 0 blocks
==543==      possibly lost: 0 bytes in 0 blocks
==543==    still reachable: 0 bytes in 0 blocks
==543==         suppressed: 0 bytes in 0 blocks
==543== 
==543== ERROR SUMMARY: 25 errors from 8 contexts (suppressed: 0 from 0)
==543== 
==543== 1 errors in context 1 of 8:
==543== Invalid write of size 1
==543==    at 0x483BDF6: strcpy (vg_replace_strmem.c:511)
==543==    by 0x109528: hashmap_set (hashmap.c:125)
==543==    by 0x10973C: main (hashmap_driver.c:29)
==543==  Address 0x4a231c1 is 9 bytes after a block of size 8 alloc'd
==543==    at 0x483877F: malloc (vg_replace_malloc.c:307)
==543==    by 0x109508: hashmap_set (hashmap.c:124)
==543==    by 0x10973C: main (hashmap_driver.c:29)
==543== 
==543== 
==543== 9 errors in context 2 of 8:
==543== Invalid write of size 1
==543==    at 0x483BDE4: strcpy (vg_replace_strmem.c:511)
==543==    by 0x109528: hashmap_set (hashmap.c:125)
==543==    by 0x10973C: main (hashmap_driver.c:29)
==543==  Address 0x4a231b8 is 0 bytes after a block of size 8 alloc'd
==543==    at 0x483877F: malloc (vg_replace_malloc.c:307)
==543==    by 0x109508: hashmap_set (hashmap.c:124)
==543==    by 0x10973C: main (hashmap_driver.c:29)
==543== 
==543== 
==543== 10 errors in context 3 of 8:
==543== Invalid read of size 1
==543==    at 0x483CBA8: strcmp (vg_replace_strmem.c:847)
==543==    by 0x1096B1: hashmap_get (hashmap.c:154)
==543==    by 0x109876: main (hashmap_driver.c:49)
==543==  Address 0x4a231b8 is 0 bytes after a block of size 8 alloc'd
==543==    at 0x483877F: malloc (vg_replace_malloc.c:307)
==543==    by 0x109508: hashmap_set (hashmap.c:124)
==543==    by 0x10973C: main (hashmap_driver.c:29)
==543== 
==543== ERROR SUMMARY: 25 errors from 8 contexts (suppressed: 0 from 0)

```

**Screenshot 3 (hashmap_driver, verbose)**

Same findings as Screenshot 1 but the `--543--` REDIR lines show Valgrind intercepting every memory function (`malloc`, `free`, `strcpy`, `strcmp`, `memcpy`) at runtime — confirming it is a true dynamic analysis tool that observes actual execution rather than reasoning about code statically.

---

**Ending statement**

Valgrind detected the buffer overflow and multiple memory leaks exercised by the custom driver, while the static-analysis tools from Exercises 1–3 additionally reported null-dereference paths that were not triggered during concrete execution























---

---

**Changes**

The original `hashmap_test` (the `main` inside `hashmap.c`) does this:

```c
hashmap_t map = hashmap_new(8);
char *key = "42";
int value = 42;
hashmap_set(map, key, &value, sizeof(int));
int *ret = (int *)hashmap_get(map, key);
assert(*ret == value);
hashmap_free(map);
```

It inserts one short key (`"42"`) into one bucket and retrieves it once. That's it — most of the code in `hashmap_set` is never reached.

---

**Change 1 — Long key to trigger the overflow at lines 124–125**

```c
hashmap_set(map, "long_key_overflow", &v, sizeof(int));
```

`hashmap_set` allocates the key buffer with `malloc(sizeof(key))`. Since `key` is a `char*`, `sizeof(key)` is always 8 bytes on a 64-bit machine — regardless of the actual string length. Then `strcpy` copies the full string into that 8-byte buffer.

The original key `"42"` is only 2 chars + null = 3 bytes, which fits silently inside 8 bytes — no overflow, Valgrind sees nothing wrong. Our key `"long_key_overflow"` is 17 chars + null = 18 bytes, which overflows the 8-byte buffer by 10 bytes. Valgrind catches every byte written past the boundary as an `Invalid write of size 1`.

---

**Change 2 — 16 keys to force bucket collisions and trigger the leak at line 127**

```c
for (int i = 0; i < 16; i++)
    hashmap_set(map, keys[i], &vals[i], sizeof(int));
```

The hashmap has 8 buckets. When a second key lands in the same bucket, `hashmap_set` does this:

```c
field->size++;
struct hashmap_entry *entries = malloc(field->size * sizeof(struct hashmap_entry));
memcpy(entries, field->entries, ...);   // copy old entries into new array
...
field->entries = entries;               // OLD pointer overwritten — never freed
```

With 16 keys across 8 buckets, by pigeonhole at least 8 collisions are guaranteed. Each collision leaks the previous `field->entries` allocation. The original test with one key never triggers this path at all — `field->entries` starts as NULL and is only ever set once.

---

**Change 3 — Three unreleased `hashmap_get` return values**

```c
void *r1 = hashmap_get(map, "long_key_overflow");
void *r2 = hashmap_get(map, "key00");
void *r3 = hashmap_get(map, "key01");
```

`hashmap_get` malloc's a fresh copy of the value and returns it — the caller is responsible for freeing it. The original test also never frees `ret`, but it only calls `hashmap_get` once so Valgrind reports 1 lost block. By calling it three times and never freeing, Valgrind reports 3 separate `definitely lost` records, making the pattern unmistakably clear.

---

**The core insight** is that Valgrind is a dynamic tool — it can only report bugs in code paths that actually execute. The original test was so minimal that most of `hashmap_set`'s body was dead code during the run. The driver was written with the bug locations already known, and each call was designed specifically to reach one of those locations.
