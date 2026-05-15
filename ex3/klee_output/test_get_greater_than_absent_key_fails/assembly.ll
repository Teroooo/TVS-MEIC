; ModuleID = 'test_get_greater_than_absent_key_fails.bc'
source_filename = "test_get_greater_than_absent_key_fails.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.treetable_conf_s = type { i32 (i8*, i8*)*, i8* (i64)*, i8* (i64, i64)*, void (i8*)* }
%struct.treetable_s = type { %struct.rbnode_s*, %struct.rbnode_s*, i64, i32 (i8*, i8*)*, i8* (i64)*, i8* (i64, i64)*, void (i8*)* }
%struct.rbnode_s = type { i8*, i8*, i8, %struct.rbnode_s*, %struct.rbnode_s*, %struct.rbnode_s* }
%struct.frame = type { %struct.rbnode_s*, i32, i32, i32 }

@.str = private unnamed_addr constant [16 x i8] c"greater_present\00", align 1
@.str.1 = private unnamed_addr constant [15 x i8] c"greater_absent\00", align 1
@.str.2 = private unnamed_addr constant [21 x i8] c"greater_absent_value\00", align 1
@.str.3 = private unnamed_addr constant [48 x i8] c"treetable_add(table, &present, &value) == CC_OK\00", align 1
@.str.4 = private unnamed_addr constant [41 x i8] c"test_get_greater_than_absent_key_fails.c\00", align 1
@__PRETTY_FUNCTION__.test_get_greater_than_absent_key_fails = private unnamed_addr constant [50 x i8] c"void test_get_greater_than_absent_key_fails(void)\00", align 1
@.str.5 = private unnamed_addr constant [73 x i8] c"treetable_get_greater_than(table, &absent, &out) == CC_ERR_KEY_NOT_FOUND\00", align 1
@.str.6 = private unnamed_addr constant [43 x i8] c"treetable_new_conf(&conf, &table) == CC_OK\00", align 1
@.str.7 = private unnamed_addr constant [17 x i8] c"./klee_helpers.h\00", align 1
@__PRETTY_FUNCTION__.make_table = private unnamed_addr constant [28 x i8] c"TreeTable *make_table(void)\00", align 1
@.str.8 = private unnamed_addr constant [14 x i8] c"table != NULL\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @cmp(i8* %e1, i8* %e2) #0 !dbg !29 {
entry:
  %retval = alloca i32, align 4
  %e1.addr = alloca i8*, align 8
  %e2.addr = alloca i8*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store i8* %e1, i8** %e1.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %e1.addr, metadata !35, metadata !DIExpression()), !dbg !36
  store i8* %e2, i8** %e2.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %e2.addr, metadata !37, metadata !DIExpression()), !dbg !38
  call void @llvm.dbg.declare(metadata i32* %i, metadata !39, metadata !DIExpression()), !dbg !40
  %0 = load i8*, i8** %e1.addr, align 8, !dbg !41
  %1 = bitcast i8* %0 to i32*, !dbg !42
  %2 = load i32, i32* %1, align 4, !dbg !43
  store i32 %2, i32* %i, align 4, !dbg !40
  call void @llvm.dbg.declare(metadata i32* %j, metadata !44, metadata !DIExpression()), !dbg !45
  %3 = load i8*, i8** %e2.addr, align 8, !dbg !46
  %4 = bitcast i8* %3 to i32*, !dbg !47
  %5 = load i32, i32* %4, align 4, !dbg !48
  store i32 %5, i32* %j, align 4, !dbg !45
  %6 = load i32, i32* %i, align 4, !dbg !49
  %7 = load i32, i32* %j, align 4, !dbg !51
  %cmp = icmp slt i32 %6, %7, !dbg !52
  br i1 %cmp, label %if.then, label %if.end, !dbg !53

if.then:                                          ; preds = %entry
  store i32 -1, i32* %retval, align 4, !dbg !54
  br label %return, !dbg !54

if.end:                                           ; preds = %entry
  %8 = load i32, i32* %i, align 4, !dbg !55
  %9 = load i32, i32* %j, align 4, !dbg !57
  %cmp1 = icmp eq i32 %8, %9, !dbg !58
  br i1 %cmp1, label %if.then2, label %if.end3, !dbg !59

if.then2:                                         ; preds = %if.end
  store i32 0, i32* %retval, align 4, !dbg !60
  br label %return, !dbg !60

if.end3:                                          ; preds = %if.end
  store i32 1, i32* %retval, align 4, !dbg !61
  br label %return, !dbg !61

return:                                           ; preds = %if.end3, %if.then2, %if.then
  %10 = load i32, i32* %retval, align 4, !dbg !62
  ret i32 %10, !dbg !62
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind uwtable
define dso_local void @treetable_conf_init(%struct.treetable_conf_s* %conf) #0 !dbg !63 {
entry:
  %conf.addr = alloca %struct.treetable_conf_s*, align 8
  store %struct.treetable_conf_s* %conf, %struct.treetable_conf_s** %conf.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.treetable_conf_s** %conf.addr, metadata !88, metadata !DIExpression()), !dbg !89
  %0 = load %struct.treetable_conf_s*, %struct.treetable_conf_s** %conf.addr, align 8, !dbg !90
  %mem_alloc = getelementptr inbounds %struct.treetable_conf_s, %struct.treetable_conf_s* %0, i32 0, i32 1, !dbg !91
  store i8* (i64)* @malloc, i8* (i64)** %mem_alloc, align 8, !dbg !92
  %1 = load %struct.treetable_conf_s*, %struct.treetable_conf_s** %conf.addr, align 8, !dbg !93
  %mem_calloc = getelementptr inbounds %struct.treetable_conf_s, %struct.treetable_conf_s* %1, i32 0, i32 2, !dbg !94
  store i8* (i64, i64)* @calloc, i8* (i64, i64)** %mem_calloc, align 8, !dbg !95
  %2 = load %struct.treetable_conf_s*, %struct.treetable_conf_s** %conf.addr, align 8, !dbg !96
  %mem_free = getelementptr inbounds %struct.treetable_conf_s, %struct.treetable_conf_s* %2, i32 0, i32 3, !dbg !97
  store void (i8*)* @free, void (i8*)** %mem_free, align 8, !dbg !98
  %3 = load %struct.treetable_conf_s*, %struct.treetable_conf_s** %conf.addr, align 8, !dbg !99
  %cmp = getelementptr inbounds %struct.treetable_conf_s, %struct.treetable_conf_s* %3, i32 0, i32 0, !dbg !100
  store i32 (i8*, i8*)* @cmp, i32 (i8*, i8*)** %cmp, align 8, !dbg !101
  ret void, !dbg !102
}

; Function Attrs: nounwind
declare dso_local noalias align 16 i8* @malloc(i64) #2

; Function Attrs: nounwind
declare dso_local noalias align 16 i8* @calloc(i64, i64) #2

; Function Attrs: nounwind
declare dso_local void @free(i8*) #2

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @treetable_new(%struct.treetable_s** %tt) #0 !dbg !103 {
entry:
  %tt.addr = alloca %struct.treetable_s**, align 8
  %conf = alloca %struct.treetable_conf_s, align 8
  store %struct.treetable_s** %tt, %struct.treetable_s*** %tt.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.treetable_s*** %tt.addr, metadata !130, metadata !DIExpression()), !dbg !131
  call void @llvm.dbg.declare(metadata %struct.treetable_conf_s* %conf, metadata !132, metadata !DIExpression()), !dbg !133
  call void @treetable_conf_init(%struct.treetable_conf_s* %conf), !dbg !134
  %0 = load %struct.treetable_s**, %struct.treetable_s*** %tt.addr, align 8, !dbg !135
  %call = call i32 @treetable_new_conf(%struct.treetable_conf_s* %conf, %struct.treetable_s** %0), !dbg !136
  ret i32 %call, !dbg !137
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @treetable_new_conf(%struct.treetable_conf_s* %conf, %struct.treetable_s** %tt) #0 !dbg !138 {
entry:
  %retval = alloca i32, align 4
  %conf.addr = alloca %struct.treetable_conf_s*, align 8
  %tt.addr = alloca %struct.treetable_s**, align 8
  %table = alloca %struct.treetable_s*, align 8
  %sentinel = alloca %struct.rbnode_s*, align 8
  store %struct.treetable_conf_s* %conf, %struct.treetable_conf_s** %conf.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.treetable_conf_s** %conf.addr, metadata !144, metadata !DIExpression()), !dbg !145
  store %struct.treetable_s** %tt, %struct.treetable_s*** %tt.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.treetable_s*** %tt.addr, metadata !146, metadata !DIExpression()), !dbg !147
  call void @llvm.dbg.declare(metadata %struct.treetable_s** %table, metadata !148, metadata !DIExpression()), !dbg !149
  %0 = load %struct.treetable_conf_s*, %struct.treetable_conf_s** %conf.addr, align 8, !dbg !150
  %mem_calloc = getelementptr inbounds %struct.treetable_conf_s, %struct.treetable_conf_s* %0, i32 0, i32 2, !dbg !151
  %1 = load i8* (i64, i64)*, i8* (i64, i64)** %mem_calloc, align 8, !dbg !151
  %call = call i8* %1(i64 1, i64 56), !dbg !150
  %2 = bitcast i8* %call to %struct.treetable_s*, !dbg !150
  store %struct.treetable_s* %2, %struct.treetable_s** %table, align 8, !dbg !149
  %3 = load %struct.treetable_s*, %struct.treetable_s** %table, align 8, !dbg !152
  %tobool = icmp ne %struct.treetable_s* %3, null, !dbg !152
  br i1 %tobool, label %if.end, label %if.then, !dbg !154

if.then:                                          ; preds = %entry
  store i32 1, i32* %retval, align 4, !dbg !155
  br label %return, !dbg !155

if.end:                                           ; preds = %entry
  call void @llvm.dbg.declare(metadata %struct.rbnode_s** %sentinel, metadata !156, metadata !DIExpression()), !dbg !157
  %4 = load %struct.treetable_conf_s*, %struct.treetable_conf_s** %conf.addr, align 8, !dbg !158
  %mem_calloc1 = getelementptr inbounds %struct.treetable_conf_s, %struct.treetable_conf_s* %4, i32 0, i32 2, !dbg !159
  %5 = load i8* (i64, i64)*, i8* (i64, i64)** %mem_calloc1, align 8, !dbg !159
  %call2 = call i8* %5(i64 1, i64 48), !dbg !158
  %6 = bitcast i8* %call2 to %struct.rbnode_s*, !dbg !158
  store %struct.rbnode_s* %6, %struct.rbnode_s** %sentinel, align 8, !dbg !157
  %7 = load %struct.rbnode_s*, %struct.rbnode_s** %sentinel, align 8, !dbg !160
  %tobool3 = icmp ne %struct.rbnode_s* %7, null, !dbg !160
  br i1 %tobool3, label %if.end5, label %if.then4, !dbg !162

if.then4:                                         ; preds = %if.end
  %8 = load %struct.treetable_conf_s*, %struct.treetable_conf_s** %conf.addr, align 8, !dbg !163
  %mem_free = getelementptr inbounds %struct.treetable_conf_s, %struct.treetable_conf_s* %8, i32 0, i32 3, !dbg !165
  %9 = load void (i8*)*, void (i8*)** %mem_free, align 8, !dbg !165
  %10 = load %struct.treetable_s*, %struct.treetable_s** %table, align 8, !dbg !166
  %11 = bitcast %struct.treetable_s* %10 to i8*, !dbg !166
  call void %9(i8* %11), !dbg !163
  store i32 1, i32* %retval, align 4, !dbg !167
  br label %return, !dbg !167

if.end5:                                          ; preds = %if.end
  %12 = load %struct.rbnode_s*, %struct.rbnode_s** %sentinel, align 8, !dbg !168
  %color = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %12, i32 0, i32 2, !dbg !169
  store i8 1, i8* %color, align 8, !dbg !170
  %13 = load %struct.treetable_s*, %struct.treetable_s** %table, align 8, !dbg !171
  %size = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %13, i32 0, i32 2, !dbg !172
  store i64 0, i64* %size, align 8, !dbg !173
  %14 = load %struct.treetable_conf_s*, %struct.treetable_conf_s** %conf.addr, align 8, !dbg !174
  %cmp = getelementptr inbounds %struct.treetable_conf_s, %struct.treetable_conf_s* %14, i32 0, i32 0, !dbg !175
  %15 = load i32 (i8*, i8*)*, i32 (i8*, i8*)** %cmp, align 8, !dbg !175
  %16 = load %struct.treetable_s*, %struct.treetable_s** %table, align 8, !dbg !176
  %cmp6 = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %16, i32 0, i32 3, !dbg !177
  store i32 (i8*, i8*)* %15, i32 (i8*, i8*)** %cmp6, align 8, !dbg !178
  %17 = load %struct.treetable_conf_s*, %struct.treetable_conf_s** %conf.addr, align 8, !dbg !179
  %mem_alloc = getelementptr inbounds %struct.treetable_conf_s, %struct.treetable_conf_s* %17, i32 0, i32 1, !dbg !180
  %18 = load i8* (i64)*, i8* (i64)** %mem_alloc, align 8, !dbg !180
  %19 = load %struct.treetable_s*, %struct.treetable_s** %table, align 8, !dbg !181
  %mem_alloc7 = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %19, i32 0, i32 4, !dbg !182
  store i8* (i64)* %18, i8* (i64)** %mem_alloc7, align 8, !dbg !183
  %20 = load %struct.treetable_conf_s*, %struct.treetable_conf_s** %conf.addr, align 8, !dbg !184
  %mem_calloc8 = getelementptr inbounds %struct.treetable_conf_s, %struct.treetable_conf_s* %20, i32 0, i32 2, !dbg !185
  %21 = load i8* (i64, i64)*, i8* (i64, i64)** %mem_calloc8, align 8, !dbg !185
  %22 = load %struct.treetable_s*, %struct.treetable_s** %table, align 8, !dbg !186
  %mem_calloc9 = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %22, i32 0, i32 5, !dbg !187
  store i8* (i64, i64)* %21, i8* (i64, i64)** %mem_calloc9, align 8, !dbg !188
  %23 = load %struct.treetable_conf_s*, %struct.treetable_conf_s** %conf.addr, align 8, !dbg !189
  %mem_free10 = getelementptr inbounds %struct.treetable_conf_s, %struct.treetable_conf_s* %23, i32 0, i32 3, !dbg !190
  %24 = load void (i8*)*, void (i8*)** %mem_free10, align 8, !dbg !190
  %25 = load %struct.treetable_s*, %struct.treetable_s** %table, align 8, !dbg !191
  %mem_free11 = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %25, i32 0, i32 6, !dbg !192
  store void (i8*)* %24, void (i8*)** %mem_free11, align 8, !dbg !193
  %26 = load %struct.rbnode_s*, %struct.rbnode_s** %sentinel, align 8, !dbg !194
  %27 = load %struct.treetable_s*, %struct.treetable_s** %table, align 8, !dbg !195
  %root = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %27, i32 0, i32 0, !dbg !196
  store %struct.rbnode_s* %26, %struct.rbnode_s** %root, align 8, !dbg !197
  %28 = load %struct.rbnode_s*, %struct.rbnode_s** %sentinel, align 8, !dbg !198
  %29 = load %struct.treetable_s*, %struct.treetable_s** %table, align 8, !dbg !199
  %sentinel12 = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %29, i32 0, i32 1, !dbg !200
  store %struct.rbnode_s* %28, %struct.rbnode_s** %sentinel12, align 8, !dbg !201
  %30 = load %struct.treetable_s*, %struct.treetable_s** %table, align 8, !dbg !202
  %31 = load %struct.treetable_s**, %struct.treetable_s*** %tt.addr, align 8, !dbg !203
  store %struct.treetable_s* %30, %struct.treetable_s** %31, align 8, !dbg !204
  store i32 0, i32* %retval, align 4, !dbg !205
  br label %return, !dbg !205

return:                                           ; preds = %if.end5, %if.then4, %if.then
  %32 = load i32, i32* %retval, align 4, !dbg !206
  ret i32 %32, !dbg !206
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @treetable_destroy(%struct.treetable_s* %table) #0 !dbg !207 {
entry:
  %table.addr = alloca %struct.treetable_s*, align 8
  store %struct.treetable_s* %table, %struct.treetable_s** %table.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.treetable_s** %table.addr, metadata !210, metadata !DIExpression()), !dbg !211
  %0 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !212
  %1 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !213
  %root = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %1, i32 0, i32 0, !dbg !214
  %2 = load %struct.rbnode_s*, %struct.rbnode_s** %root, align 8, !dbg !214
  call void @tree_destroy(%struct.treetable_s* %0, %struct.rbnode_s* %2), !dbg !215
  %3 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !216
  %mem_free = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %3, i32 0, i32 6, !dbg !217
  %4 = load void (i8*)*, void (i8*)** %mem_free, align 8, !dbg !217
  %5 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !218
  %sentinel = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %5, i32 0, i32 1, !dbg !219
  %6 = load %struct.rbnode_s*, %struct.rbnode_s** %sentinel, align 8, !dbg !219
  %7 = bitcast %struct.rbnode_s* %6 to i8*, !dbg !218
  call void %4(i8* %7), !dbg !216
  %8 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !220
  %mem_free1 = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %8, i32 0, i32 6, !dbg !221
  %9 = load void (i8*)*, void (i8*)** %mem_free1, align 8, !dbg !221
  %10 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !222
  %11 = bitcast %struct.treetable_s* %10 to i8*, !dbg !222
  call void %9(i8* %11), !dbg !220
  ret void, !dbg !223
}

; Function Attrs: noinline nounwind uwtable
define internal void @tree_destroy(%struct.treetable_s* %table, %struct.rbnode_s* %n) #0 !dbg !224 {
entry:
  %table.addr = alloca %struct.treetable_s*, align 8
  %n.addr = alloca %struct.rbnode_s*, align 8
  store %struct.treetable_s* %table, %struct.treetable_s** %table.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.treetable_s** %table.addr, metadata !227, metadata !DIExpression()), !dbg !228
  store %struct.rbnode_s* %n, %struct.rbnode_s** %n.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.rbnode_s** %n.addr, metadata !229, metadata !DIExpression()), !dbg !230
  %0 = load %struct.rbnode_s*, %struct.rbnode_s** %n.addr, align 8, !dbg !231
  %1 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !233
  %sentinel = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %1, i32 0, i32 1, !dbg !234
  %2 = load %struct.rbnode_s*, %struct.rbnode_s** %sentinel, align 8, !dbg !234
  %cmp = icmp eq %struct.rbnode_s* %0, %2, !dbg !235
  br i1 %cmp, label %return, label %if.end, !dbg !236

if.end:                                           ; preds = %entry
  %3 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !237
  %4 = load %struct.rbnode_s*, %struct.rbnode_s** %n.addr, align 8, !dbg !238
  %left = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %4, i32 0, i32 4, !dbg !239
  %5 = load %struct.rbnode_s*, %struct.rbnode_s** %left, align 8, !dbg !239
  call void @tree_destroy(%struct.treetable_s* %3, %struct.rbnode_s* %5), !dbg !240
  %6 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !241
  %7 = load %struct.rbnode_s*, %struct.rbnode_s** %n.addr, align 8, !dbg !242
  %right = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %7, i32 0, i32 5, !dbg !243
  %8 = load %struct.rbnode_s*, %struct.rbnode_s** %right, align 8, !dbg !243
  call void @tree_destroy(%struct.treetable_s* %6, %struct.rbnode_s* %8), !dbg !244
  %9 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !245
  %mem_free = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %9, i32 0, i32 6, !dbg !246
  %10 = load void (i8*)*, void (i8*)** %mem_free, align 8, !dbg !246
  %11 = load %struct.rbnode_s*, %struct.rbnode_s** %n.addr, align 8, !dbg !247
  %12 = bitcast %struct.rbnode_s* %11 to i8*, !dbg !247
  call void %10(i8* %12), !dbg !245
  br label %return, !dbg !248

return:                                           ; preds = %entry, %if.end
  ret void, !dbg !248
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @treetable_get(%struct.treetable_s* %table, i8* %key, i8** %out) #0 !dbg !249 {
entry:
  %retval = alloca i32, align 4
  %table.addr = alloca %struct.treetable_s*, align 8
  %key.addr = alloca i8*, align 8
  %out.addr = alloca i8**, align 8
  %node = alloca %struct.rbnode_s*, align 8
  store %struct.treetable_s* %table, %struct.treetable_s** %table.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.treetable_s** %table.addr, metadata !256, metadata !DIExpression()), !dbg !257
  store i8* %key, i8** %key.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %key.addr, metadata !258, metadata !DIExpression()), !dbg !259
  store i8** %out, i8*** %out.addr, align 8
  call void @llvm.dbg.declare(metadata i8*** %out.addr, metadata !260, metadata !DIExpression()), !dbg !261
  call void @llvm.dbg.declare(metadata %struct.rbnode_s** %node, metadata !262, metadata !DIExpression()), !dbg !263
  %0 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !264
  %1 = load i8*, i8** %key.addr, align 8, !dbg !265
  %call = call %struct.rbnode_s* @get_tree_node_by_key(%struct.treetable_s* %0, i8* %1), !dbg !266
  store %struct.rbnode_s* %call, %struct.rbnode_s** %node, align 8, !dbg !263
  %2 = load %struct.rbnode_s*, %struct.rbnode_s** %node, align 8, !dbg !267
  %tobool = icmp ne %struct.rbnode_s* %2, null, !dbg !267
  br i1 %tobool, label %if.end, label %if.then, !dbg !269

if.then:                                          ; preds = %entry
  store i32 6, i32* %retval, align 4, !dbg !270
  br label %return, !dbg !270

if.end:                                           ; preds = %entry
  %3 = load %struct.rbnode_s*, %struct.rbnode_s** %node, align 8, !dbg !271
  %value = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %3, i32 0, i32 1, !dbg !272
  %4 = load i8*, i8** %value, align 8, !dbg !272
  %5 = load i8**, i8*** %out.addr, align 8, !dbg !273
  store i8* %4, i8** %5, align 8, !dbg !274
  store i32 0, i32* %retval, align 4, !dbg !275
  br label %return, !dbg !275

return:                                           ; preds = %if.end, %if.then
  %6 = load i32, i32* %retval, align 4, !dbg !276
  ret i32 %6, !dbg !276
}

; Function Attrs: noinline nounwind uwtable
define internal %struct.rbnode_s* @get_tree_node_by_key(%struct.treetable_s* %table, i8* %key) #0 !dbg !277 {
entry:
  %retval = alloca %struct.rbnode_s*, align 8
  %table.addr = alloca %struct.treetable_s*, align 8
  %key.addr = alloca i8*, align 8
  %n = alloca %struct.rbnode_s*, align 8
  %s = alloca %struct.rbnode_s*, align 8
  %cmp1 = alloca i32, align 4
  store %struct.treetable_s* %table, %struct.treetable_s** %table.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.treetable_s** %table.addr, metadata !280, metadata !DIExpression()), !dbg !281
  store i8* %key, i8** %key.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %key.addr, metadata !282, metadata !DIExpression()), !dbg !283
  %0 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !284
  %size = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %0, i32 0, i32 2, !dbg !286
  %1 = load i64, i64* %size, align 8, !dbg !286
  %cmp = icmp eq i64 %1, 0, !dbg !287
  br i1 %cmp, label %if.then, label %if.end, !dbg !288

if.then:                                          ; preds = %entry
  store %struct.rbnode_s* null, %struct.rbnode_s** %retval, align 8, !dbg !289
  br label %return, !dbg !289

if.end:                                           ; preds = %entry
  call void @llvm.dbg.declare(metadata %struct.rbnode_s** %n, metadata !290, metadata !DIExpression()), !dbg !291
  %2 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !292
  %root = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %2, i32 0, i32 0, !dbg !293
  %3 = load %struct.rbnode_s*, %struct.rbnode_s** %root, align 8, !dbg !293
  store %struct.rbnode_s* %3, %struct.rbnode_s** %n, align 8, !dbg !291
  call void @llvm.dbg.declare(metadata %struct.rbnode_s** %s, metadata !294, metadata !DIExpression()), !dbg !295
  %4 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !296
  %sentinel = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %4, i32 0, i32 1, !dbg !297
  %5 = load %struct.rbnode_s*, %struct.rbnode_s** %sentinel, align 8, !dbg !297
  store %struct.rbnode_s* %5, %struct.rbnode_s** %s, align 8, !dbg !295
  call void @llvm.dbg.declare(metadata i32* %cmp1, metadata !298, metadata !DIExpression()), !dbg !299
  br label %do.body, !dbg !300

do.body:                                          ; preds = %do.cond, %if.end
  %6 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !301
  %cmp2 = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %6, i32 0, i32 3, !dbg !303
  %7 = load i32 (i8*, i8*)*, i32 (i8*, i8*)** %cmp2, align 8, !dbg !303
  %8 = load i8*, i8** %key.addr, align 8, !dbg !304
  %9 = load %struct.rbnode_s*, %struct.rbnode_s** %n, align 8, !dbg !305
  %key3 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %9, i32 0, i32 0, !dbg !306
  %10 = load i8*, i8** %key3, align 8, !dbg !306
  %call = call i32 %7(i8* %8, i8* %10), !dbg !301
  store i32 %call, i32* %cmp1, align 4, !dbg !307
  %11 = load i32, i32* %cmp1, align 4, !dbg !308
  %cmp4 = icmp slt i32 %11, 0, !dbg !310
  br i1 %cmp4, label %if.then5, label %if.else, !dbg !311

if.then5:                                         ; preds = %do.body
  %12 = load %struct.rbnode_s*, %struct.rbnode_s** %n, align 8, !dbg !312
  %left = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %12, i32 0, i32 4, !dbg !313
  %13 = load %struct.rbnode_s*, %struct.rbnode_s** %left, align 8, !dbg !313
  store %struct.rbnode_s* %13, %struct.rbnode_s** %n, align 8, !dbg !314
  br label %do.cond, !dbg !315

if.else:                                          ; preds = %do.body
  %14 = load i32, i32* %cmp1, align 4, !dbg !316
  %cmp6 = icmp sgt i32 %14, 0, !dbg !318
  br i1 %cmp6, label %if.then7, label %if.else8, !dbg !319

if.then7:                                         ; preds = %if.else
  %15 = load %struct.rbnode_s*, %struct.rbnode_s** %n, align 8, !dbg !320
  %right = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %15, i32 0, i32 5, !dbg !321
  %16 = load %struct.rbnode_s*, %struct.rbnode_s** %right, align 8, !dbg !321
  store %struct.rbnode_s* %16, %struct.rbnode_s** %n, align 8, !dbg !322
  br label %do.cond

if.else8:                                         ; preds = %if.else
  %17 = load %struct.rbnode_s*, %struct.rbnode_s** %n, align 8, !dbg !323
  store %struct.rbnode_s* %17, %struct.rbnode_s** %retval, align 8, !dbg !324
  br label %return, !dbg !324

do.cond:                                          ; preds = %if.then5, %if.then7
  %18 = load %struct.rbnode_s*, %struct.rbnode_s** %n, align 8, !dbg !325
  %19 = load %struct.rbnode_s*, %struct.rbnode_s** %s, align 8, !dbg !326
  %cmp11 = icmp ne %struct.rbnode_s* %18, %19, !dbg !327
  %20 = load i32, i32* %cmp1, align 4, !dbg !328
  %cmp12 = icmp ne i32 %20, 0, !dbg !328
  %21 = select i1 %cmp11, i1 %cmp12, i1 false, !dbg !328
  br i1 %21, label %do.body, label %do.end, !dbg !329, !llvm.loop !330

do.end:                                           ; preds = %do.cond
  store %struct.rbnode_s* null, %struct.rbnode_s** %retval, align 8, !dbg !333
  br label %return, !dbg !333

return:                                           ; preds = %do.end, %if.else8, %if.then
  %22 = load %struct.rbnode_s*, %struct.rbnode_s** %retval, align 8, !dbg !334
  ret %struct.rbnode_s* %22, !dbg !334
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @treetable_get_first_key(%struct.treetable_s* %table, i8** %out) #0 !dbg !335 {
entry:
  %retval = alloca i32, align 4
  %table.addr = alloca %struct.treetable_s*, align 8
  %out.addr = alloca i8**, align 8
  %node = alloca %struct.rbnode_s*, align 8
  store %struct.treetable_s* %table, %struct.treetable_s** %table.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.treetable_s** %table.addr, metadata !338, metadata !DIExpression()), !dbg !339
  store i8** %out, i8*** %out.addr, align 8
  call void @llvm.dbg.declare(metadata i8*** %out.addr, metadata !340, metadata !DIExpression()), !dbg !341
  call void @llvm.dbg.declare(metadata %struct.rbnode_s** %node, metadata !342, metadata !DIExpression()), !dbg !343
  %0 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !344
  %1 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !345
  %root = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %1, i32 0, i32 0, !dbg !346
  %2 = load %struct.rbnode_s*, %struct.rbnode_s** %root, align 8, !dbg !346
  %call = call %struct.rbnode_s* @tree_min(%struct.treetable_s* %0, %struct.rbnode_s* %2), !dbg !347
  store %struct.rbnode_s* %call, %struct.rbnode_s** %node, align 8, !dbg !343
  %3 = load %struct.rbnode_s*, %struct.rbnode_s** %node, align 8, !dbg !348
  %4 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !350
  %sentinel = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %4, i32 0, i32 1, !dbg !351
  %5 = load %struct.rbnode_s*, %struct.rbnode_s** %sentinel, align 8, !dbg !351
  %cmp = icmp ne %struct.rbnode_s* %3, %5, !dbg !352
  br i1 %cmp, label %if.then, label %if.end, !dbg !353

if.then:                                          ; preds = %entry
  %6 = load %struct.rbnode_s*, %struct.rbnode_s** %node, align 8, !dbg !354
  %key = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %6, i32 0, i32 0, !dbg !356
  %7 = load i8*, i8** %key, align 8, !dbg !356
  %8 = load i8**, i8*** %out.addr, align 8, !dbg !357
  store i8* %7, i8** %8, align 8, !dbg !358
  store i32 0, i32* %retval, align 4, !dbg !359
  br label %return, !dbg !359

if.end:                                           ; preds = %entry
  store i32 6, i32* %retval, align 4, !dbg !360
  br label %return, !dbg !360

return:                                           ; preds = %if.end, %if.then
  %9 = load i32, i32* %retval, align 4, !dbg !361
  ret i32 %9, !dbg !361
}

; Function Attrs: noinline nounwind uwtable
define internal %struct.rbnode_s* @tree_min(%struct.treetable_s* %table, %struct.rbnode_s* %n) #0 !dbg !362 {
entry:
  %table.addr = alloca %struct.treetable_s*, align 8
  %n.addr = alloca %struct.rbnode_s*, align 8
  %s = alloca %struct.rbnode_s*, align 8
  store %struct.treetable_s* %table, %struct.treetable_s** %table.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.treetable_s** %table.addr, metadata !365, metadata !DIExpression()), !dbg !366
  store %struct.rbnode_s* %n, %struct.rbnode_s** %n.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.rbnode_s** %n.addr, metadata !367, metadata !DIExpression()), !dbg !368
  call void @llvm.dbg.declare(metadata %struct.rbnode_s** %s, metadata !369, metadata !DIExpression()), !dbg !370
  %0 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !371
  %sentinel = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %0, i32 0, i32 1, !dbg !372
  %1 = load %struct.rbnode_s*, %struct.rbnode_s** %sentinel, align 8, !dbg !372
  store %struct.rbnode_s* %1, %struct.rbnode_s** %s, align 8, !dbg !370
  br label %while.cond, !dbg !373

while.cond:                                       ; preds = %while.body, %entry
  %2 = load %struct.rbnode_s*, %struct.rbnode_s** %n.addr, align 8, !dbg !374
  %left = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %2, i32 0, i32 4, !dbg !375
  %3 = load %struct.rbnode_s*, %struct.rbnode_s** %left, align 8, !dbg !375
  %4 = load %struct.rbnode_s*, %struct.rbnode_s** %s, align 8, !dbg !376
  %cmp = icmp ne %struct.rbnode_s* %3, %4, !dbg !377
  br i1 %cmp, label %while.body, label %while.end, !dbg !373

while.body:                                       ; preds = %while.cond
  %5 = load %struct.rbnode_s*, %struct.rbnode_s** %n.addr, align 8, !dbg !378
  %left1 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %5, i32 0, i32 4, !dbg !379
  %6 = load %struct.rbnode_s*, %struct.rbnode_s** %left1, align 8, !dbg !379
  store %struct.rbnode_s* %6, %struct.rbnode_s** %n.addr, align 8, !dbg !380
  br label %while.cond, !dbg !373, !llvm.loop !381

while.end:                                        ; preds = %while.cond
  %7 = load %struct.rbnode_s*, %struct.rbnode_s** %n.addr, align 8, !dbg !382
  ret %struct.rbnode_s* %7, !dbg !383
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @treetable_get_greater_than(%struct.treetable_s* %table, i8* %key, i8** %out) #0 !dbg !384 {
entry:
  %retval = alloca i32, align 4
  %table.addr = alloca %struct.treetable_s*, align 8
  %key.addr = alloca i8*, align 8
  %out.addr = alloca i8**, align 8
  %n = alloca %struct.rbnode_s*, align 8
  %s = alloca %struct.rbnode_s*, align 8
  store %struct.treetable_s* %table, %struct.treetable_s** %table.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.treetable_s** %table.addr, metadata !385, metadata !DIExpression()), !dbg !386
  store i8* %key, i8** %key.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %key.addr, metadata !387, metadata !DIExpression()), !dbg !388
  store i8** %out, i8*** %out.addr, align 8
  call void @llvm.dbg.declare(metadata i8*** %out.addr, metadata !389, metadata !DIExpression()), !dbg !390
  call void @llvm.dbg.declare(metadata %struct.rbnode_s** %n, metadata !391, metadata !DIExpression()), !dbg !392
  %0 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !393
  %1 = load i8*, i8** %key.addr, align 8, !dbg !394
  %call = call %struct.rbnode_s* @get_tree_node_by_key(%struct.treetable_s* %0, i8* %1), !dbg !395
  store %struct.rbnode_s* %call, %struct.rbnode_s** %n, align 8, !dbg !392
  call void @llvm.dbg.declare(metadata %struct.rbnode_s** %s, metadata !396, metadata !DIExpression()), !dbg !397
  %2 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !398
  %3 = load %struct.rbnode_s*, %struct.rbnode_s** %n, align 8, !dbg !399
  %call1 = call %struct.rbnode_s* @get_successor_node(%struct.treetable_s* %2, %struct.rbnode_s* %3), !dbg !400
  store %struct.rbnode_s* %call1, %struct.rbnode_s** %s, align 8, !dbg !397
  %4 = load %struct.rbnode_s*, %struct.rbnode_s** %n, align 8, !dbg !401
  %tobool = icmp ne %struct.rbnode_s* %4, null, !dbg !401
  %5 = load %struct.rbnode_s*, %struct.rbnode_s** %s, align 8
  %tobool2 = icmp ne %struct.rbnode_s* %5, null
  %or.cond = select i1 %tobool, i1 %tobool2, i1 false, !dbg !403
  br i1 %or.cond, label %if.then, label %if.end, !dbg !403

if.then:                                          ; preds = %entry
  %6 = load %struct.rbnode_s*, %struct.rbnode_s** %s, align 8, !dbg !404
  %key3 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %6, i32 0, i32 0, !dbg !406
  %7 = load i8*, i8** %key3, align 8, !dbg !406
  %8 = load i8**, i8*** %out.addr, align 8, !dbg !407
  store i8* %7, i8** %8, align 8, !dbg !408
  store i32 0, i32* %retval, align 4, !dbg !409
  br label %return, !dbg !409

if.end:                                           ; preds = %entry
  store i32 6, i32* %retval, align 4, !dbg !410
  br label %return, !dbg !410

return:                                           ; preds = %if.end, %if.then
  %9 = load i32, i32* %retval, align 4, !dbg !411
  ret i32 %9, !dbg !411
}

; Function Attrs: noinline nounwind uwtable
define internal %struct.rbnode_s* @get_successor_node(%struct.treetable_s* %table, %struct.rbnode_s* %x) #0 !dbg !412 {
entry:
  %retval = alloca %struct.rbnode_s*, align 8
  %table.addr = alloca %struct.treetable_s*, align 8
  %x.addr = alloca %struct.rbnode_s*, align 8
  %y = alloca %struct.rbnode_s*, align 8
  store %struct.treetable_s* %table, %struct.treetable_s** %table.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.treetable_s** %table.addr, metadata !413, metadata !DIExpression()), !dbg !414
  store %struct.rbnode_s* %x, %struct.rbnode_s** %x.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.rbnode_s** %x.addr, metadata !415, metadata !DIExpression()), !dbg !416
  %0 = load %struct.rbnode_s*, %struct.rbnode_s** %x.addr, align 8, !dbg !417
  %cmp = icmp eq %struct.rbnode_s* %0, null, !dbg !419
  br i1 %cmp, label %if.then, label %if.end, !dbg !420

if.then:                                          ; preds = %entry
  store %struct.rbnode_s* null, %struct.rbnode_s** %retval, align 8, !dbg !421
  br label %return, !dbg !421

if.end:                                           ; preds = %entry
  %1 = load %struct.rbnode_s*, %struct.rbnode_s** %x.addr, align 8, !dbg !422
  %right = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %1, i32 0, i32 5, !dbg !424
  %2 = load %struct.rbnode_s*, %struct.rbnode_s** %right, align 8, !dbg !424
  %3 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !425
  %sentinel = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %3, i32 0, i32 1, !dbg !426
  %4 = load %struct.rbnode_s*, %struct.rbnode_s** %sentinel, align 8, !dbg !426
  %cmp1 = icmp ne %struct.rbnode_s* %2, %4, !dbg !427
  br i1 %cmp1, label %if.then2, label %if.end4, !dbg !428

if.then2:                                         ; preds = %if.end
  %5 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !429
  %6 = load %struct.rbnode_s*, %struct.rbnode_s** %x.addr, align 8, !dbg !430
  %right3 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %6, i32 0, i32 5, !dbg !431
  %7 = load %struct.rbnode_s*, %struct.rbnode_s** %right3, align 8, !dbg !431
  %call = call %struct.rbnode_s* @tree_min(%struct.treetable_s* %5, %struct.rbnode_s* %7), !dbg !432
  store %struct.rbnode_s* %call, %struct.rbnode_s** %retval, align 8, !dbg !433
  br label %return, !dbg !433

if.end4:                                          ; preds = %if.end
  call void @llvm.dbg.declare(metadata %struct.rbnode_s** %y, metadata !434, metadata !DIExpression()), !dbg !435
  %8 = load %struct.rbnode_s*, %struct.rbnode_s** %x.addr, align 8, !dbg !436
  %parent = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %8, i32 0, i32 3, !dbg !437
  %9 = load %struct.rbnode_s*, %struct.rbnode_s** %parent, align 8, !dbg !437
  store %struct.rbnode_s* %9, %struct.rbnode_s** %y, align 8, !dbg !435
  br label %while.cond, !dbg !438

while.cond:                                       ; preds = %while.body, %if.end4
  %10 = load %struct.rbnode_s*, %struct.rbnode_s** %y, align 8, !dbg !439
  %11 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !440
  %sentinel5 = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %11, i32 0, i32 1, !dbg !441
  %12 = load %struct.rbnode_s*, %struct.rbnode_s** %sentinel5, align 8, !dbg !441
  %cmp6 = icmp ne %struct.rbnode_s* %10, %12, !dbg !442
  br i1 %cmp6, label %land.rhs, label %while.end, !dbg !443

land.rhs:                                         ; preds = %while.cond
  %13 = load %struct.rbnode_s*, %struct.rbnode_s** %x.addr, align 8, !dbg !444
  %14 = load %struct.rbnode_s*, %struct.rbnode_s** %y, align 8, !dbg !445
  %right7 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %14, i32 0, i32 5, !dbg !446
  %15 = load %struct.rbnode_s*, %struct.rbnode_s** %right7, align 8, !dbg !446
  %cmp8 = icmp eq %struct.rbnode_s* %13, %15, !dbg !447
  br i1 %cmp8, label %while.body, label %while.end, !dbg !438

while.body:                                       ; preds = %land.rhs
  %16 = load %struct.rbnode_s*, %struct.rbnode_s** %y, align 8, !dbg !448
  store %struct.rbnode_s* %16, %struct.rbnode_s** %x.addr, align 8, !dbg !450
  %17 = load %struct.rbnode_s*, %struct.rbnode_s** %y, align 8, !dbg !451
  %parent9 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %17, i32 0, i32 3, !dbg !452
  %18 = load %struct.rbnode_s*, %struct.rbnode_s** %parent9, align 8, !dbg !452
  store %struct.rbnode_s* %18, %struct.rbnode_s** %y, align 8, !dbg !453
  br label %while.cond, !dbg !438, !llvm.loop !454

while.end:                                        ; preds = %while.cond, %land.rhs
  %19 = load %struct.rbnode_s*, %struct.rbnode_s** %y, align 8, !dbg !456
  store %struct.rbnode_s* %19, %struct.rbnode_s** %retval, align 8, !dbg !457
  br label %return, !dbg !457

return:                                           ; preds = %while.end, %if.then2, %if.then
  %20 = load %struct.rbnode_s*, %struct.rbnode_s** %retval, align 8, !dbg !458
  ret %struct.rbnode_s* %20, !dbg !458
}

; Function Attrs: noinline nounwind uwtable
define dso_local i64 @treetable_size(%struct.treetable_s* %table) #0 !dbg !459 {
entry:
  %table.addr = alloca %struct.treetable_s*, align 8
  store %struct.treetable_s* %table, %struct.treetable_s** %table.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.treetable_s** %table.addr, metadata !462, metadata !DIExpression()), !dbg !463
  %0 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !464
  %size = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %0, i32 0, i32 2, !dbg !465
  %1 = load i64, i64* %size, align 8, !dbg !465
  ret i64 %1, !dbg !466
}

; Function Attrs: noinline nounwind uwtable
define dso_local zeroext i1 @treetable_contains_key(%struct.treetable_s* %table, i8* %key) #0 !dbg !467 {
entry:
  %retval = alloca i1, align 1
  %table.addr = alloca %struct.treetable_s*, align 8
  %key.addr = alloca i8*, align 8
  %node = alloca %struct.rbnode_s*, align 8
  store %struct.treetable_s* %table, %struct.treetable_s** %table.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.treetable_s** %table.addr, metadata !471, metadata !DIExpression()), !dbg !472
  store i8* %key, i8** %key.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %key.addr, metadata !473, metadata !DIExpression()), !dbg !474
  call void @llvm.dbg.declare(metadata %struct.rbnode_s** %node, metadata !475, metadata !DIExpression()), !dbg !476
  %0 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !477
  %1 = load i8*, i8** %key.addr, align 8, !dbg !478
  %call = call %struct.rbnode_s* @get_tree_node_by_key(%struct.treetable_s* %0, i8* %1), !dbg !479
  store %struct.rbnode_s* %call, %struct.rbnode_s** %node, align 8, !dbg !476
  %2 = load %struct.rbnode_s*, %struct.rbnode_s** %node, align 8, !dbg !480
  %tobool = icmp ne %struct.rbnode_s* %2, null, !dbg !480
  br i1 %tobool, label %if.then, label %if.end, !dbg !482

if.then:                                          ; preds = %entry
  store i1 true, i1* %retval, align 1, !dbg !483
  br label %return, !dbg !483

if.end:                                           ; preds = %entry
  store i1 false, i1* %retval, align 1, !dbg !484
  br label %return, !dbg !484

return:                                           ; preds = %if.end, %if.then
  %3 = load i1, i1* %retval, align 1, !dbg !485
  ret i1 %3, !dbg !485
}

; Function Attrs: noinline nounwind uwtable
define dso_local i64 @treetable_contains_value(%struct.treetable_s* %table, i8* %value) #0 !dbg !486 {
entry:
  %table.addr = alloca %struct.treetable_s*, align 8
  %value.addr = alloca i8*, align 8
  %node = alloca %struct.rbnode_s*, align 8
  %o = alloca i64, align 8
  store %struct.treetable_s* %table, %struct.treetable_s** %table.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.treetable_s** %table.addr, metadata !489, metadata !DIExpression()), !dbg !490
  store i8* %value, i8** %value.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %value.addr, metadata !491, metadata !DIExpression()), !dbg !492
  call void @llvm.dbg.declare(metadata %struct.rbnode_s** %node, metadata !493, metadata !DIExpression()), !dbg !494
  %0 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !495
  %1 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !496
  %root = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %1, i32 0, i32 0, !dbg !497
  %2 = load %struct.rbnode_s*, %struct.rbnode_s** %root, align 8, !dbg !497
  %call = call %struct.rbnode_s* @tree_min(%struct.treetable_s* %0, %struct.rbnode_s* %2), !dbg !498
  store %struct.rbnode_s* %call, %struct.rbnode_s** %node, align 8, !dbg !494
  call void @llvm.dbg.declare(metadata i64* %o, metadata !499, metadata !DIExpression()), !dbg !500
  store i64 0, i64* %o, align 8, !dbg !500
  br label %while.cond, !dbg !501

while.cond:                                       ; preds = %if.end, %entry
  %3 = load %struct.rbnode_s*, %struct.rbnode_s** %node, align 8, !dbg !502
  %4 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !503
  %sentinel = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %4, i32 0, i32 1, !dbg !504
  %5 = load %struct.rbnode_s*, %struct.rbnode_s** %sentinel, align 8, !dbg !504
  %cmp = icmp ne %struct.rbnode_s* %3, %5, !dbg !505
  br i1 %cmp, label %while.body, label %while.end, !dbg !501

while.body:                                       ; preds = %while.cond
  %6 = load %struct.rbnode_s*, %struct.rbnode_s** %node, align 8, !dbg !506
  %value1 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %6, i32 0, i32 1, !dbg !509
  %7 = load i8*, i8** %value1, align 8, !dbg !509
  %8 = load i8*, i8** %value.addr, align 8, !dbg !510
  %cmp2 = icmp eq i8* %7, %8, !dbg !511
  br i1 %cmp2, label %if.then, label %if.end, !dbg !512

if.then:                                          ; preds = %while.body
  %9 = load i64, i64* %o, align 8, !dbg !513
  %inc = add i64 %9, 1, !dbg !513
  store i64 %inc, i64* %o, align 8, !dbg !513
  br label %if.end, !dbg !514

if.end:                                           ; preds = %if.then, %while.body
  %10 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !515
  %11 = load %struct.rbnode_s*, %struct.rbnode_s** %node, align 8, !dbg !516
  %call3 = call %struct.rbnode_s* @get_successor_node(%struct.treetable_s* %10, %struct.rbnode_s* %11), !dbg !517
  store %struct.rbnode_s* %call3, %struct.rbnode_s** %node, align 8, !dbg !518
  br label %while.cond, !dbg !501, !llvm.loop !519

while.end:                                        ; preds = %while.cond
  %12 = load i64, i64* %o, align 8, !dbg !521
  ret i64 %12, !dbg !522
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @balanced(%struct.treetable_s* %t) #0 !dbg !523 {
entry:
  %retval = alloca i32, align 4
  %t.addr = alloca %struct.treetable_s*, align 8
  %stack = alloca %struct.frame*, align 8
  %top = alloca i64, align 8
  %ok = alloca i32, align 4
  %.compoundliteral = alloca %struct.frame, align 8
  %current = alloca %struct.frame*, align 8
  %.compoundliteral20 = alloca %struct.frame, align 8
  %.compoundliteral38 = alloca %struct.frame, align 8
  %diff = alloca i32, align 4
  %height = alloca i32, align 4
  store %struct.treetable_s* %t, %struct.treetable_s** %t.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.treetable_s** %t.addr, metadata !526, metadata !DIExpression()), !dbg !527
  %0 = load %struct.treetable_s*, %struct.treetable_s** %t.addr, align 8, !dbg !528
  %tobool = icmp ne %struct.treetable_s* %0, null, !dbg !528
  br i1 %tobool, label %if.end, label %if.then, !dbg !530

if.then:                                          ; preds = %entry
  store i32 1, i32* %retval, align 4, !dbg !531
  br label %return, !dbg !531

if.end:                                           ; preds = %entry
  %1 = load %struct.treetable_s*, %struct.treetable_s** %t.addr, align 8, !dbg !532
  %root = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %1, i32 0, i32 0, !dbg !534
  %2 = load %struct.rbnode_s*, %struct.rbnode_s** %root, align 8, !dbg !534
  %3 = load %struct.treetable_s*, %struct.treetable_s** %t.addr, align 8, !dbg !535
  %sentinel = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %3, i32 0, i32 1, !dbg !536
  %4 = load %struct.rbnode_s*, %struct.rbnode_s** %sentinel, align 8, !dbg !536
  %cmp = icmp eq %struct.rbnode_s* %2, %4, !dbg !537
  br i1 %cmp, label %if.then1, label %if.end2, !dbg !538

if.then1:                                         ; preds = %if.end
  store i32 1, i32* %retval, align 4, !dbg !539
  br label %return, !dbg !539

if.end2:                                          ; preds = %if.end
  call void @llvm.dbg.declare(metadata %struct.frame** %stack, metadata !540, metadata !DIExpression()), !dbg !548
  %5 = load %struct.treetable_s*, %struct.treetable_s** %t.addr, align 8, !dbg !549
  %mem_alloc = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %5, i32 0, i32 4, !dbg !550
  %6 = load i8* (i64)*, i8* (i64)** %mem_alloc, align 8, !dbg !550
  %7 = load %struct.treetable_s*, %struct.treetable_s** %t.addr, align 8, !dbg !551
  %size = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %7, i32 0, i32 2, !dbg !552
  %8 = load i64, i64* %size, align 8, !dbg !552
  %mul = mul i64 %8, 24, !dbg !553
  %call = call i8* %6(i64 %mul), !dbg !549
  %9 = bitcast i8* %call to %struct.frame*, !dbg !549
  store %struct.frame* %9, %struct.frame** %stack, align 8, !dbg !548
  %10 = load %struct.frame*, %struct.frame** %stack, align 8, !dbg !554
  %tobool3 = icmp ne %struct.frame* %10, null, !dbg !554
  br i1 %tobool3, label %if.end5, label %if.then4, !dbg !556

if.then4:                                         ; preds = %if.end2
  store i32 0, i32* %retval, align 4, !dbg !557
  br label %return, !dbg !557

if.end5:                                          ; preds = %if.end2
  call void @llvm.dbg.declare(metadata i64* %top, metadata !558, metadata !DIExpression()), !dbg !559
  store i64 0, i64* %top, align 8, !dbg !559
  call void @llvm.dbg.declare(metadata i32* %ok, metadata !560, metadata !DIExpression()), !dbg !561
  store i32 1, i32* %ok, align 4, !dbg !561
  %11 = load %struct.frame*, %struct.frame** %stack, align 8, !dbg !562
  %12 = load i64, i64* %top, align 8, !dbg !563
  %inc = add i64 %12, 1, !dbg !563
  store i64 %inc, i64* %top, align 8, !dbg !563
  %arrayidx = getelementptr inbounds %struct.frame, %struct.frame* %11, i64 %12, !dbg !562
  %node = getelementptr inbounds %struct.frame, %struct.frame* %.compoundliteral, i32 0, i32 0, !dbg !564
  %13 = load %struct.treetable_s*, %struct.treetable_s** %t.addr, align 8, !dbg !565
  %root6 = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %13, i32 0, i32 0, !dbg !566
  %14 = load %struct.rbnode_s*, %struct.rbnode_s** %root6, align 8, !dbg !566
  store %struct.rbnode_s* %14, %struct.rbnode_s** %node, align 8, !dbg !564
  %state = getelementptr inbounds %struct.frame, %struct.frame* %.compoundliteral, i32 0, i32 1, !dbg !564
  store i32 0, i32* %state, align 8, !dbg !564
  %left_height = getelementptr inbounds %struct.frame, %struct.frame* %.compoundliteral, i32 0, i32 2, !dbg !564
  store i32 0, i32* %left_height, align 4, !dbg !564
  %right_height = getelementptr inbounds %struct.frame, %struct.frame* %.compoundliteral, i32 0, i32 3, !dbg !564
  store i32 0, i32* %right_height, align 8, !dbg !564
  %15 = bitcast %struct.frame* %arrayidx to i8*, !dbg !567
  %16 = bitcast %struct.frame* %.compoundliteral to i8*, !dbg !567
  %17 = call i8* @memcpy(i8* %15, i8* %16, i64 24), !dbg !567
  br label %while.cond, !dbg !568

while.cond:                                       ; preds = %if.end76, %if.end5
  %18 = load i64, i64* %top, align 8, !dbg !569
  %cmp7 = icmp ugt i64 %18, 0, !dbg !570
  %19 = load i32, i32* %ok, align 4, !dbg !571
  %tobool8 = icmp ne i32 %19, 0, !dbg !571
  %20 = select i1 %cmp7, i1 %tobool8, i1 false, !dbg !571
  br i1 %20, label %while.body, label %while.end, !dbg !568

while.body:                                       ; preds = %while.cond
  call void @llvm.dbg.declare(metadata %struct.frame** %current, metadata !572, metadata !DIExpression()), !dbg !574
  %21 = load %struct.frame*, %struct.frame** %stack, align 8, !dbg !575
  %22 = load i64, i64* %top, align 8, !dbg !576
  %sub = sub i64 %22, 1, !dbg !577
  %arrayidx9 = getelementptr inbounds %struct.frame, %struct.frame* %21, i64 %sub, !dbg !575
  store %struct.frame* %arrayidx9, %struct.frame** %current, align 8, !dbg !574
  %23 = load %struct.frame*, %struct.frame** %current, align 8, !dbg !578
  %state10 = getelementptr inbounds %struct.frame, %struct.frame* %23, i32 0, i32 1, !dbg !580
  %24 = load i32, i32* %state10, align 8, !dbg !580
  %cmp11 = icmp eq i32 %24, 0, !dbg !581
  br i1 %cmp11, label %if.then12, label %if.else, !dbg !582

if.then12:                                        ; preds = %while.body
  %25 = load %struct.frame*, %struct.frame** %current, align 8, !dbg !583
  %state13 = getelementptr inbounds %struct.frame, %struct.frame* %25, i32 0, i32 1, !dbg !585
  store i32 1, i32* %state13, align 8, !dbg !586
  %26 = load %struct.frame*, %struct.frame** %current, align 8, !dbg !587
  %node14 = getelementptr inbounds %struct.frame, %struct.frame* %26, i32 0, i32 0, !dbg !589
  %27 = load %struct.rbnode_s*, %struct.rbnode_s** %node14, align 8, !dbg !589
  %left = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %27, i32 0, i32 4, !dbg !590
  %28 = load %struct.rbnode_s*, %struct.rbnode_s** %left, align 8, !dbg !590
  %29 = load %struct.treetable_s*, %struct.treetable_s** %t.addr, align 8, !dbg !591
  %sentinel15 = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %29, i32 0, i32 1, !dbg !592
  %30 = load %struct.rbnode_s*, %struct.rbnode_s** %sentinel15, align 8, !dbg !592
  %cmp16 = icmp ne %struct.rbnode_s* %28, %30, !dbg !593
  br i1 %cmp16, label %if.then17, label %if.end76, !dbg !594

if.then17:                                        ; preds = %if.then12
  %31 = load %struct.frame*, %struct.frame** %stack, align 8, !dbg !595
  %32 = load i64, i64* %top, align 8, !dbg !596
  %inc18 = add i64 %32, 1, !dbg !596
  store i64 %inc18, i64* %top, align 8, !dbg !596
  %arrayidx19 = getelementptr inbounds %struct.frame, %struct.frame* %31, i64 %32, !dbg !595
  %node21 = getelementptr inbounds %struct.frame, %struct.frame* %.compoundliteral20, i32 0, i32 0, !dbg !597
  %33 = load %struct.frame*, %struct.frame** %current, align 8, !dbg !598
  %node22 = getelementptr inbounds %struct.frame, %struct.frame* %33, i32 0, i32 0, !dbg !599
  %34 = load %struct.rbnode_s*, %struct.rbnode_s** %node22, align 8, !dbg !599
  %left23 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %34, i32 0, i32 4, !dbg !600
  %35 = load %struct.rbnode_s*, %struct.rbnode_s** %left23, align 8, !dbg !600
  store %struct.rbnode_s* %35, %struct.rbnode_s** %node21, align 8, !dbg !597
  %state24 = getelementptr inbounds %struct.frame, %struct.frame* %.compoundliteral20, i32 0, i32 1, !dbg !597
  store i32 0, i32* %state24, align 8, !dbg !597
  %left_height25 = getelementptr inbounds %struct.frame, %struct.frame* %.compoundliteral20, i32 0, i32 2, !dbg !597
  store i32 0, i32* %left_height25, align 4, !dbg !597
  %right_height26 = getelementptr inbounds %struct.frame, %struct.frame* %.compoundliteral20, i32 0, i32 3, !dbg !597
  store i32 0, i32* %right_height26, align 8, !dbg !597
  %36 = bitcast %struct.frame* %arrayidx19 to i8*, !dbg !601
  %37 = bitcast %struct.frame* %.compoundliteral20 to i8*, !dbg !601
  %38 = call i8* @memcpy(i8* %36, i8* %37, i64 24), !dbg !601
  br label %if.end76, !dbg !595

if.else:                                          ; preds = %while.body
  %39 = load %struct.frame*, %struct.frame** %current, align 8, !dbg !602
  %state28 = getelementptr inbounds %struct.frame, %struct.frame* %39, i32 0, i32 1, !dbg !604
  %40 = load i32, i32* %state28, align 8, !dbg !604
  %cmp29 = icmp eq i32 %40, 1, !dbg !605
  br i1 %cmp29, label %if.then30, label %if.else46, !dbg !606

if.then30:                                        ; preds = %if.else
  %41 = load %struct.frame*, %struct.frame** %current, align 8, !dbg !607
  %state31 = getelementptr inbounds %struct.frame, %struct.frame* %41, i32 0, i32 1, !dbg !609
  store i32 2, i32* %state31, align 8, !dbg !610
  %42 = load %struct.frame*, %struct.frame** %current, align 8, !dbg !611
  %node32 = getelementptr inbounds %struct.frame, %struct.frame* %42, i32 0, i32 0, !dbg !613
  %43 = load %struct.rbnode_s*, %struct.rbnode_s** %node32, align 8, !dbg !613
  %right = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %43, i32 0, i32 5, !dbg !614
  %44 = load %struct.rbnode_s*, %struct.rbnode_s** %right, align 8, !dbg !614
  %45 = load %struct.treetable_s*, %struct.treetable_s** %t.addr, align 8, !dbg !615
  %sentinel33 = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %45, i32 0, i32 1, !dbg !616
  %46 = load %struct.rbnode_s*, %struct.rbnode_s** %sentinel33, align 8, !dbg !616
  %cmp34 = icmp ne %struct.rbnode_s* %44, %46, !dbg !617
  br i1 %cmp34, label %if.then35, label %if.end76, !dbg !618

if.then35:                                        ; preds = %if.then30
  %47 = load %struct.frame*, %struct.frame** %stack, align 8, !dbg !619
  %48 = load i64, i64* %top, align 8, !dbg !620
  %inc36 = add i64 %48, 1, !dbg !620
  store i64 %inc36, i64* %top, align 8, !dbg !620
  %arrayidx37 = getelementptr inbounds %struct.frame, %struct.frame* %47, i64 %48, !dbg !619
  %node39 = getelementptr inbounds %struct.frame, %struct.frame* %.compoundliteral38, i32 0, i32 0, !dbg !621
  %49 = load %struct.frame*, %struct.frame** %current, align 8, !dbg !622
  %node40 = getelementptr inbounds %struct.frame, %struct.frame* %49, i32 0, i32 0, !dbg !623
  %50 = load %struct.rbnode_s*, %struct.rbnode_s** %node40, align 8, !dbg !623
  %right41 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %50, i32 0, i32 5, !dbg !624
  %51 = load %struct.rbnode_s*, %struct.rbnode_s** %right41, align 8, !dbg !624
  store %struct.rbnode_s* %51, %struct.rbnode_s** %node39, align 8, !dbg !621
  %state42 = getelementptr inbounds %struct.frame, %struct.frame* %.compoundliteral38, i32 0, i32 1, !dbg !621
  store i32 0, i32* %state42, align 8, !dbg !621
  %left_height43 = getelementptr inbounds %struct.frame, %struct.frame* %.compoundliteral38, i32 0, i32 2, !dbg !621
  store i32 0, i32* %left_height43, align 4, !dbg !621
  %right_height44 = getelementptr inbounds %struct.frame, %struct.frame* %.compoundliteral38, i32 0, i32 3, !dbg !621
  store i32 0, i32* %right_height44, align 8, !dbg !621
  %52 = bitcast %struct.frame* %arrayidx37 to i8*, !dbg !625
  %53 = bitcast %struct.frame* %.compoundliteral38 to i8*, !dbg !625
  %54 = call i8* @memcpy(i8* %52, i8* %53, i64 24), !dbg !625
  br label %if.end76, !dbg !619

if.else46:                                        ; preds = %if.else
  call void @llvm.dbg.declare(metadata i32* %diff, metadata !626, metadata !DIExpression()), !dbg !628
  %55 = load %struct.frame*, %struct.frame** %current, align 8, !dbg !629
  %left_height47 = getelementptr inbounds %struct.frame, %struct.frame* %55, i32 0, i32 2, !dbg !630
  %56 = load i32, i32* %left_height47, align 4, !dbg !630
  %57 = load %struct.frame*, %struct.frame** %current, align 8, !dbg !631
  %right_height48 = getelementptr inbounds %struct.frame, %struct.frame* %57, i32 0, i32 3, !dbg !632
  %58 = load i32, i32* %right_height48, align 8, !dbg !632
  %sub49 = sub nsw i32 %56, %58, !dbg !633
  store i32 %sub49, i32* %diff, align 4, !dbg !628
  %59 = load i32, i32* %diff, align 4, !dbg !634
  %cmp50 = icmp slt i32 %59, -1, !dbg !636
  %60 = load i32, i32* %diff, align 4
  %cmp51 = icmp sgt i32 %60, 1
  %or.cond = select i1 %cmp50, i1 true, i1 %cmp51, !dbg !637
  br i1 %or.cond, label %if.then52, label %if.end53, !dbg !637

if.then52:                                        ; preds = %if.else46
  store i32 0, i32* %ok, align 4, !dbg !638
  br label %while.end, !dbg !640

if.end53:                                         ; preds = %if.else46
  call void @llvm.dbg.declare(metadata i32* %height, metadata !641, metadata !DIExpression()), !dbg !642
  %61 = load %struct.frame*, %struct.frame** %current, align 8, !dbg !643
  %left_height54 = getelementptr inbounds %struct.frame, %struct.frame* %61, i32 0, i32 2, !dbg !644
  %62 = load i32, i32* %left_height54, align 4, !dbg !644
  %63 = load %struct.frame*, %struct.frame** %current, align 8, !dbg !645
  %right_height55 = getelementptr inbounds %struct.frame, %struct.frame* %63, i32 0, i32 3, !dbg !646
  %64 = load i32, i32* %right_height55, align 8, !dbg !646
  %cmp56 = icmp sgt i32 %62, %64, !dbg !647
  br i1 %cmp56, label %cond.true, label %cond.false, !dbg !643

cond.true:                                        ; preds = %if.end53
  %65 = load %struct.frame*, %struct.frame** %current, align 8, !dbg !648
  %left_height57 = getelementptr inbounds %struct.frame, %struct.frame* %65, i32 0, i32 2, !dbg !649
  %66 = load i32, i32* %left_height57, align 4, !dbg !649
  br label %cond.end, !dbg !643

cond.false:                                       ; preds = %if.end53
  %67 = load %struct.frame*, %struct.frame** %current, align 8, !dbg !650
  %right_height58 = getelementptr inbounds %struct.frame, %struct.frame* %67, i32 0, i32 3, !dbg !651
  %68 = load i32, i32* %right_height58, align 8, !dbg !651
  br label %cond.end, !dbg !643

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ %66, %cond.true ], [ %68, %cond.false ], !dbg !643
  %add = add nsw i32 %cond, 1, !dbg !652
  store i32 %add, i32* %height, align 4, !dbg !653
  %69 = load i64, i64* %top, align 8, !dbg !654
  %dec = add i64 %69, -1, !dbg !654
  store i64 %dec, i64* %top, align 8, !dbg !654
  %70 = load i64, i64* %top, align 8, !dbg !655
  %cmp59 = icmp ugt i64 %70, 0, !dbg !657
  br i1 %cmp59, label %if.then60, label %if.end76, !dbg !658

if.then60:                                        ; preds = %cond.end
  %71 = load %struct.frame*, %struct.frame** %stack, align 8, !dbg !659
  %72 = load i64, i64* %top, align 8, !dbg !662
  %sub61 = sub i64 %72, 1, !dbg !663
  %arrayidx62 = getelementptr inbounds %struct.frame, %struct.frame* %71, i64 %sub61, !dbg !659
  %state63 = getelementptr inbounds %struct.frame, %struct.frame* %arrayidx62, i32 0, i32 1, !dbg !664
  %73 = load i32, i32* %state63, align 8, !dbg !664
  %cmp64 = icmp eq i32 %73, 1, !dbg !665
  br i1 %cmp64, label %if.then65, label %if.else69, !dbg !666

if.then65:                                        ; preds = %if.then60
  %74 = load i32, i32* %height, align 4, !dbg !667
  %75 = load %struct.frame*, %struct.frame** %stack, align 8, !dbg !668
  %76 = load i64, i64* %top, align 8, !dbg !669
  %sub66 = sub i64 %76, 1, !dbg !670
  %arrayidx67 = getelementptr inbounds %struct.frame, %struct.frame* %75, i64 %sub66, !dbg !668
  %left_height68 = getelementptr inbounds %struct.frame, %struct.frame* %arrayidx67, i32 0, i32 2, !dbg !671
  store i32 %74, i32* %left_height68, align 4, !dbg !672
  br label %if.end76, !dbg !668

if.else69:                                        ; preds = %if.then60
  %77 = load i32, i32* %height, align 4, !dbg !673
  %78 = load %struct.frame*, %struct.frame** %stack, align 8, !dbg !674
  %79 = load i64, i64* %top, align 8, !dbg !675
  %sub70 = sub i64 %79, 1, !dbg !676
  %arrayidx71 = getelementptr inbounds %struct.frame, %struct.frame* %78, i64 %sub70, !dbg !674
  %right_height72 = getelementptr inbounds %struct.frame, %struct.frame* %arrayidx71, i32 0, i32 3, !dbg !677
  store i32 %77, i32* %right_height72, align 8, !dbg !678
  br label %if.end76

if.end76:                                         ; preds = %if.then35, %if.then30, %if.then65, %if.else69, %cond.end, %if.then12, %if.then17
  br label %while.cond, !dbg !568, !llvm.loop !679

while.end:                                        ; preds = %if.then52, %while.cond
  %80 = load %struct.treetable_s*, %struct.treetable_s** %t.addr, align 8, !dbg !681
  %mem_free = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %80, i32 0, i32 6, !dbg !682
  %81 = load void (i8*)*, void (i8*)** %mem_free, align 8, !dbg !682
  %82 = load %struct.frame*, %struct.frame** %stack, align 8, !dbg !683
  %83 = bitcast %struct.frame* %82 to i8*, !dbg !683
  call void %81(i8* %83), !dbg !681
  %84 = load i32, i32* %ok, align 4, !dbg !684
  store i32 %84, i32* %retval, align 4, !dbg !685
  br label %return, !dbg !685

return:                                           ; preds = %while.end, %if.then4, %if.then1, %if.then
  %85 = load i32, i32* %retval, align 4, !dbg !686
  ret i32 %85, !dbg !686
}

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #3

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @sorted(%struct.treetable_s* %t) #0 !dbg !687 {
entry:
  %retval = alloca i32, align 4
  %t.addr = alloca %struct.treetable_s*, align 8
  %stack = alloca %struct.rbnode_s**, align 8
  %top = alloca i64, align 8
  %ok = alloca i32, align 4
  %node = alloca %struct.rbnode_s*, align 8
  %previous = alloca %struct.rbnode_s*, align 8
  store %struct.treetable_s* %t, %struct.treetable_s** %t.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.treetable_s** %t.addr, metadata !688, metadata !DIExpression()), !dbg !689
  %0 = load %struct.treetable_s*, %struct.treetable_s** %t.addr, align 8, !dbg !690
  %tobool = icmp ne %struct.treetable_s* %0, null, !dbg !690
  br i1 %tobool, label %if.end, label %if.then, !dbg !692

if.then:                                          ; preds = %entry
  store i32 1, i32* %retval, align 4, !dbg !693
  br label %return, !dbg !693

if.end:                                           ; preds = %entry
  %1 = load %struct.treetable_s*, %struct.treetable_s** %t.addr, align 8, !dbg !694
  %root = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %1, i32 0, i32 0, !dbg !696
  %2 = load %struct.rbnode_s*, %struct.rbnode_s** %root, align 8, !dbg !696
  %3 = load %struct.treetable_s*, %struct.treetable_s** %t.addr, align 8, !dbg !697
  %sentinel = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %3, i32 0, i32 1, !dbg !698
  %4 = load %struct.rbnode_s*, %struct.rbnode_s** %sentinel, align 8, !dbg !698
  %cmp = icmp eq %struct.rbnode_s* %2, %4, !dbg !699
  br i1 %cmp, label %if.then1, label %if.end2, !dbg !700

if.then1:                                         ; preds = %if.end
  store i32 1, i32* %retval, align 4, !dbg !701
  br label %return, !dbg !701

if.end2:                                          ; preds = %if.end
  call void @llvm.dbg.declare(metadata %struct.rbnode_s*** %stack, metadata !702, metadata !DIExpression()), !dbg !704
  %5 = load %struct.treetable_s*, %struct.treetable_s** %t.addr, align 8, !dbg !705
  %mem_alloc = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %5, i32 0, i32 4, !dbg !706
  %6 = load i8* (i64)*, i8* (i64)** %mem_alloc, align 8, !dbg !706
  %7 = load %struct.treetable_s*, %struct.treetable_s** %t.addr, align 8, !dbg !707
  %size = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %7, i32 0, i32 2, !dbg !708
  %8 = load i64, i64* %size, align 8, !dbg !708
  %mul = mul i64 %8, 8, !dbg !709
  %call = call i8* %6(i64 %mul), !dbg !705
  %9 = bitcast i8* %call to %struct.rbnode_s**, !dbg !705
  store %struct.rbnode_s** %9, %struct.rbnode_s*** %stack, align 8, !dbg !704
  %10 = load %struct.rbnode_s**, %struct.rbnode_s*** %stack, align 8, !dbg !710
  %tobool3 = icmp ne %struct.rbnode_s** %10, null, !dbg !710
  br i1 %tobool3, label %if.end5, label %if.then4, !dbg !712

if.then4:                                         ; preds = %if.end2
  store i32 0, i32* %retval, align 4, !dbg !713
  br label %return, !dbg !713

if.end5:                                          ; preds = %if.end2
  call void @llvm.dbg.declare(metadata i64* %top, metadata !714, metadata !DIExpression()), !dbg !715
  store i64 0, i64* %top, align 8, !dbg !715
  call void @llvm.dbg.declare(metadata i32* %ok, metadata !716, metadata !DIExpression()), !dbg !717
  store i32 1, i32* %ok, align 4, !dbg !717
  call void @llvm.dbg.declare(metadata %struct.rbnode_s** %node, metadata !718, metadata !DIExpression()), !dbg !719
  %11 = load %struct.treetable_s*, %struct.treetable_s** %t.addr, align 8, !dbg !720
  %root6 = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %11, i32 0, i32 0, !dbg !721
  %12 = load %struct.rbnode_s*, %struct.rbnode_s** %root6, align 8, !dbg !721
  store %struct.rbnode_s* %12, %struct.rbnode_s** %node, align 8, !dbg !719
  call void @llvm.dbg.declare(metadata %struct.rbnode_s** %previous, metadata !722, metadata !DIExpression()), !dbg !723
  store %struct.rbnode_s* null, %struct.rbnode_s** %previous, align 8, !dbg !723
  br label %while.cond, !dbg !724

while.cond:                                       ; preds = %if.end22, %if.end5
  %13 = load %struct.rbnode_s*, %struct.rbnode_s** %node, align 8, !dbg !725
  %14 = load %struct.treetable_s*, %struct.treetable_s** %t.addr, align 8, !dbg !726
  %sentinel7 = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %14, i32 0, i32 1, !dbg !727
  %15 = load %struct.rbnode_s*, %struct.rbnode_s** %sentinel7, align 8, !dbg !727
  %cmp8 = icmp ne %struct.rbnode_s* %13, %15, !dbg !728
  %16 = load i64, i64* %top, align 8
  %cmp9 = icmp ugt i64 %16, 0
  %or.cond = select i1 %cmp8, i1 true, i1 %cmp9, !dbg !729
  %17 = load i32, i32* %ok, align 4
  %tobool10 = icmp ne i32 %17, 0
  %or.cond1 = select i1 %or.cond, i1 %tobool10, i1 false, !dbg !729
  br i1 %or.cond1, label %while.cond11, label %while.end23, !dbg !729

while.cond11:                                     ; preds = %while.cond, %while.body14
  %18 = load %struct.rbnode_s*, %struct.rbnode_s** %node, align 8, !dbg !730
  %19 = load %struct.treetable_s*, %struct.treetable_s** %t.addr, align 8, !dbg !732
  %sentinel12 = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %19, i32 0, i32 1, !dbg !733
  %20 = load %struct.rbnode_s*, %struct.rbnode_s** %sentinel12, align 8, !dbg !733
  %cmp13 = icmp ne %struct.rbnode_s* %18, %20, !dbg !734
  br i1 %cmp13, label %while.body14, label %while.end, !dbg !735

while.body14:                                     ; preds = %while.cond11
  %21 = load %struct.rbnode_s*, %struct.rbnode_s** %node, align 8, !dbg !736
  %22 = load %struct.rbnode_s**, %struct.rbnode_s*** %stack, align 8, !dbg !738
  %23 = load i64, i64* %top, align 8, !dbg !739
  %inc = add i64 %23, 1, !dbg !739
  store i64 %inc, i64* %top, align 8, !dbg !739
  %arrayidx = getelementptr inbounds %struct.rbnode_s*, %struct.rbnode_s** %22, i64 %23, !dbg !738
  store %struct.rbnode_s* %21, %struct.rbnode_s** %arrayidx, align 8, !dbg !740
  %24 = load %struct.rbnode_s*, %struct.rbnode_s** %node, align 8, !dbg !741
  %left = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %24, i32 0, i32 4, !dbg !742
  %25 = load %struct.rbnode_s*, %struct.rbnode_s** %left, align 8, !dbg !742
  store %struct.rbnode_s* %25, %struct.rbnode_s** %node, align 8, !dbg !743
  br label %while.cond11, !dbg !735, !llvm.loop !744

while.end:                                        ; preds = %while.cond11
  %26 = load %struct.rbnode_s**, %struct.rbnode_s*** %stack, align 8, !dbg !746
  %27 = load i64, i64* %top, align 8, !dbg !747
  %dec = add i64 %27, -1, !dbg !747
  store i64 %dec, i64* %top, align 8, !dbg !747
  %arrayidx15 = getelementptr inbounds %struct.rbnode_s*, %struct.rbnode_s** %26, i64 %dec, !dbg !746
  %28 = load %struct.rbnode_s*, %struct.rbnode_s** %arrayidx15, align 8, !dbg !746
  store %struct.rbnode_s* %28, %struct.rbnode_s** %node, align 8, !dbg !748
  %29 = load %struct.rbnode_s*, %struct.rbnode_s** %previous, align 8, !dbg !749
  %tobool16 = icmp ne %struct.rbnode_s* %29, null, !dbg !749
  br i1 %tobool16, label %land.lhs.true, label %if.end22, !dbg !751

land.lhs.true:                                    ; preds = %while.end
  %30 = load %struct.treetable_s*, %struct.treetable_s** %t.addr, align 8, !dbg !752
  %cmp17 = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %30, i32 0, i32 3, !dbg !753
  %31 = load i32 (i8*, i8*)*, i32 (i8*, i8*)** %cmp17, align 8, !dbg !753
  %32 = load %struct.rbnode_s*, %struct.rbnode_s** %previous, align 8, !dbg !754
  %key = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %32, i32 0, i32 0, !dbg !755
  %33 = load i8*, i8** %key, align 8, !dbg !755
  %34 = load %struct.rbnode_s*, %struct.rbnode_s** %node, align 8, !dbg !756
  %key18 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %34, i32 0, i32 0, !dbg !757
  %35 = load i8*, i8** %key18, align 8, !dbg !757
  %call19 = call i32 %31(i8* %33, i8* %35), !dbg !752
  %cmp20 = icmp sge i32 %call19, 0, !dbg !758
  br i1 %cmp20, label %if.then21, label %if.end22, !dbg !759

if.then21:                                        ; preds = %land.lhs.true
  store i32 0, i32* %ok, align 4, !dbg !760
  br label %while.end23, !dbg !762

if.end22:                                         ; preds = %land.lhs.true, %while.end
  %36 = load %struct.rbnode_s*, %struct.rbnode_s** %node, align 8, !dbg !763
  store %struct.rbnode_s* %36, %struct.rbnode_s** %previous, align 8, !dbg !764
  %37 = load %struct.rbnode_s*, %struct.rbnode_s** %node, align 8, !dbg !765
  %right = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %37, i32 0, i32 5, !dbg !766
  %38 = load %struct.rbnode_s*, %struct.rbnode_s** %right, align 8, !dbg !766
  store %struct.rbnode_s* %38, %struct.rbnode_s** %node, align 8, !dbg !767
  br label %while.cond, !dbg !724, !llvm.loop !768

while.end23:                                      ; preds = %while.cond, %if.then21
  %39 = load %struct.treetable_s*, %struct.treetable_s** %t.addr, align 8, !dbg !770
  %mem_free = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %39, i32 0, i32 6, !dbg !771
  %40 = load void (i8*)*, void (i8*)** %mem_free, align 8, !dbg !771
  %41 = load %struct.rbnode_s**, %struct.rbnode_s*** %stack, align 8, !dbg !772
  %42 = bitcast %struct.rbnode_s** %41 to i8*, !dbg !772
  call void %40(i8* %42), !dbg !770
  %43 = load i32, i32* %ok, align 4, !dbg !773
  store i32 %43, i32* %retval, align 4, !dbg !774
  br label %return, !dbg !774

return:                                           ; preds = %while.end23, %if.then4, %if.then1, %if.then
  %44 = load i32, i32* %retval, align 4, !dbg !775
  ret i32 %44, !dbg !775
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @treetable_add(%struct.treetable_s* %table, i8* %key, i8* %val) #0 !dbg !776 {
entry:
  %retval = alloca i32, align 4
  %table.addr = alloca %struct.treetable_s*, align 8
  %key.addr = alloca i8*, align 8
  %val.addr = alloca i8*, align 8
  %y = alloca %struct.rbnode_s*, align 8
  %x = alloca %struct.rbnode_s*, align 8
  %cmp = alloca i32, align 4
  %n = alloca %struct.rbnode_s*, align 8
  store %struct.treetable_s* %table, %struct.treetable_s** %table.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.treetable_s** %table.addr, metadata !779, metadata !DIExpression()), !dbg !780
  store i8* %key, i8** %key.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %key.addr, metadata !781, metadata !DIExpression()), !dbg !782
  store i8* %val, i8** %val.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %val.addr, metadata !783, metadata !DIExpression()), !dbg !784
  call void @llvm.dbg.declare(metadata %struct.rbnode_s** %y, metadata !785, metadata !DIExpression()), !dbg !786
  %0 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !787
  %sentinel = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %0, i32 0, i32 1, !dbg !788
  %1 = load %struct.rbnode_s*, %struct.rbnode_s** %sentinel, align 8, !dbg !788
  store %struct.rbnode_s* %1, %struct.rbnode_s** %y, align 8, !dbg !786
  call void @llvm.dbg.declare(metadata %struct.rbnode_s** %x, metadata !789, metadata !DIExpression()), !dbg !790
  %2 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !791
  %root = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %2, i32 0, i32 0, !dbg !792
  %3 = load %struct.rbnode_s*, %struct.rbnode_s** %root, align 8, !dbg !792
  store %struct.rbnode_s* %3, %struct.rbnode_s** %x, align 8, !dbg !790
  call void @llvm.dbg.declare(metadata i32* %cmp, metadata !793, metadata !DIExpression()), !dbg !794
  br label %while.cond, !dbg !795

while.cond:                                       ; preds = %if.end9, %entry
  %4 = load %struct.rbnode_s*, %struct.rbnode_s** %x, align 8, !dbg !796
  %5 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !797
  %sentinel1 = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %5, i32 0, i32 1, !dbg !798
  %6 = load %struct.rbnode_s*, %struct.rbnode_s** %sentinel1, align 8, !dbg !798
  %cmp2 = icmp ne %struct.rbnode_s* %4, %6, !dbg !799
  br i1 %cmp2, label %while.body, label %while.end, !dbg !795

while.body:                                       ; preds = %while.cond
  %7 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !800
  %cmp3 = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %7, i32 0, i32 3, !dbg !802
  %8 = load i32 (i8*, i8*)*, i32 (i8*, i8*)** %cmp3, align 8, !dbg !802
  %9 = load i8*, i8** %key.addr, align 8, !dbg !803
  %10 = load %struct.rbnode_s*, %struct.rbnode_s** %x, align 8, !dbg !804
  %key4 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %10, i32 0, i32 0, !dbg !805
  %11 = load i8*, i8** %key4, align 8, !dbg !805
  %call = call i32 %8(i8* %9, i8* %11), !dbg !800
  store i32 %call, i32* %cmp, align 4, !dbg !806
  %12 = load %struct.rbnode_s*, %struct.rbnode_s** %x, align 8, !dbg !807
  store %struct.rbnode_s* %12, %struct.rbnode_s** %y, align 8, !dbg !808
  %13 = load i32, i32* %cmp, align 4, !dbg !809
  %cmp5 = icmp slt i32 %13, 0, !dbg !811
  br i1 %cmp5, label %if.then, label %if.else, !dbg !812

if.then:                                          ; preds = %while.body
  %14 = load %struct.rbnode_s*, %struct.rbnode_s** %x, align 8, !dbg !813
  %left = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %14, i32 0, i32 4, !dbg !815
  %15 = load %struct.rbnode_s*, %struct.rbnode_s** %left, align 8, !dbg !815
  store %struct.rbnode_s* %15, %struct.rbnode_s** %x, align 8, !dbg !816
  br label %if.end9, !dbg !817

if.else:                                          ; preds = %while.body
  %16 = load i32, i32* %cmp, align 4, !dbg !818
  %cmp6 = icmp sgt i32 %16, 0, !dbg !820
  br i1 %cmp6, label %if.then7, label %if.else8, !dbg !821

if.then7:                                         ; preds = %if.else
  %17 = load %struct.rbnode_s*, %struct.rbnode_s** %x, align 8, !dbg !822
  %right = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %17, i32 0, i32 5, !dbg !824
  %18 = load %struct.rbnode_s*, %struct.rbnode_s** %right, align 8, !dbg !824
  store %struct.rbnode_s* %18, %struct.rbnode_s** %x, align 8, !dbg !825
  br label %if.end9

if.else8:                                         ; preds = %if.else
  %19 = load i8*, i8** %val.addr, align 8, !dbg !826
  %20 = load %struct.rbnode_s*, %struct.rbnode_s** %x, align 8, !dbg !828
  %value = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %20, i32 0, i32 1, !dbg !829
  store i8* %19, i8** %value, align 8, !dbg !830
  store i32 0, i32* %retval, align 4, !dbg !831
  br label %return, !dbg !831

if.end9:                                          ; preds = %if.then7, %if.then
  br label %while.cond, !dbg !795, !llvm.loop !832

while.end:                                        ; preds = %while.cond
  call void @llvm.dbg.declare(metadata %struct.rbnode_s** %n, metadata !834, metadata !DIExpression()), !dbg !835
  %21 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !836
  %mem_alloc = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %21, i32 0, i32 4, !dbg !837
  %22 = load i8* (i64)*, i8* (i64)** %mem_alloc, align 8, !dbg !837
  %call10 = call i8* %22(i64 48), !dbg !836
  %23 = bitcast i8* %call10 to %struct.rbnode_s*, !dbg !836
  store %struct.rbnode_s* %23, %struct.rbnode_s** %n, align 8, !dbg !835
  %24 = load i8*, i8** %val.addr, align 8, !dbg !838
  %25 = load %struct.rbnode_s*, %struct.rbnode_s** %n, align 8, !dbg !839
  %value11 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %25, i32 0, i32 1, !dbg !840
  store i8* %24, i8** %value11, align 8, !dbg !841
  %26 = load i8*, i8** %key.addr, align 8, !dbg !842
  %27 = load %struct.rbnode_s*, %struct.rbnode_s** %n, align 8, !dbg !843
  %key12 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %27, i32 0, i32 0, !dbg !844
  store i8* %26, i8** %key12, align 8, !dbg !845
  %28 = load %struct.rbnode_s*, %struct.rbnode_s** %y, align 8, !dbg !846
  %29 = load %struct.rbnode_s*, %struct.rbnode_s** %n, align 8, !dbg !847
  %parent = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %29, i32 0, i32 3, !dbg !848
  store %struct.rbnode_s* %28, %struct.rbnode_s** %parent, align 8, !dbg !849
  %30 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !850
  %sentinel13 = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %30, i32 0, i32 1, !dbg !851
  %31 = load %struct.rbnode_s*, %struct.rbnode_s** %sentinel13, align 8, !dbg !851
  %32 = load %struct.rbnode_s*, %struct.rbnode_s** %n, align 8, !dbg !852
  %left14 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %32, i32 0, i32 4, !dbg !853
  store %struct.rbnode_s* %31, %struct.rbnode_s** %left14, align 8, !dbg !854
  %33 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !855
  %sentinel15 = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %33, i32 0, i32 1, !dbg !856
  %34 = load %struct.rbnode_s*, %struct.rbnode_s** %sentinel15, align 8, !dbg !856
  %35 = load %struct.rbnode_s*, %struct.rbnode_s** %n, align 8, !dbg !857
  %right16 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %35, i32 0, i32 5, !dbg !858
  store %struct.rbnode_s* %34, %struct.rbnode_s** %right16, align 8, !dbg !859
  %36 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !860
  %size = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %36, i32 0, i32 2, !dbg !861
  %37 = load i64, i64* %size, align 8, !dbg !862
  %inc = add i64 %37, 1, !dbg !862
  store i64 %inc, i64* %size, align 8, !dbg !862
  %38 = load %struct.rbnode_s*, %struct.rbnode_s** %y, align 8, !dbg !863
  %39 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !865
  %sentinel17 = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %39, i32 0, i32 1, !dbg !866
  %40 = load %struct.rbnode_s*, %struct.rbnode_s** %sentinel17, align 8, !dbg !866
  %cmp18 = icmp eq %struct.rbnode_s* %38, %40, !dbg !867
  br i1 %cmp18, label %if.then19, label %if.else21, !dbg !868

if.then19:                                        ; preds = %while.end
  %41 = load %struct.rbnode_s*, %struct.rbnode_s** %n, align 8, !dbg !869
  %42 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !871
  %root20 = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %42, i32 0, i32 0, !dbg !872
  store %struct.rbnode_s* %41, %struct.rbnode_s** %root20, align 8, !dbg !873
  %43 = load %struct.rbnode_s*, %struct.rbnode_s** %n, align 8, !dbg !874
  %color = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %43, i32 0, i32 2, !dbg !875
  store i8 1, i8* %color, align 8, !dbg !876
  br label %if.end32, !dbg !877

if.else21:                                        ; preds = %while.end
  %44 = load %struct.rbnode_s*, %struct.rbnode_s** %n, align 8, !dbg !878
  %color22 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %44, i32 0, i32 2, !dbg !880
  store i8 0, i8* %color22, align 8, !dbg !881
  %45 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !882
  %cmp23 = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %45, i32 0, i32 3, !dbg !884
  %46 = load i32 (i8*, i8*)*, i32 (i8*, i8*)** %cmp23, align 8, !dbg !884
  %47 = load i8*, i8** %key.addr, align 8, !dbg !885
  %48 = load %struct.rbnode_s*, %struct.rbnode_s** %y, align 8, !dbg !886
  %key24 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %48, i32 0, i32 0, !dbg !887
  %49 = load i8*, i8** %key24, align 8, !dbg !887
  %call25 = call i32 %46(i8* %47, i8* %49), !dbg !882
  %cmp26 = icmp slt i32 %call25, 0, !dbg !888
  br i1 %cmp26, label %if.then27, label %if.else29, !dbg !889

if.then27:                                        ; preds = %if.else21
  %50 = load %struct.rbnode_s*, %struct.rbnode_s** %n, align 8, !dbg !890
  %51 = load %struct.rbnode_s*, %struct.rbnode_s** %y, align 8, !dbg !892
  %left28 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %51, i32 0, i32 4, !dbg !893
  store %struct.rbnode_s* %50, %struct.rbnode_s** %left28, align 8, !dbg !894
  br label %if.end31, !dbg !895

if.else29:                                        ; preds = %if.else21
  %52 = load %struct.rbnode_s*, %struct.rbnode_s** %n, align 8, !dbg !896
  %53 = load %struct.rbnode_s*, %struct.rbnode_s** %y, align 8, !dbg !898
  %right30 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %53, i32 0, i32 5, !dbg !899
  store %struct.rbnode_s* %52, %struct.rbnode_s** %right30, align 8, !dbg !900
  br label %if.end31

if.end31:                                         ; preds = %if.else29, %if.then27
  %54 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !901
  %55 = load %struct.rbnode_s*, %struct.rbnode_s** %n, align 8, !dbg !902
  call void @rebalance_after_insert(%struct.treetable_s* %54, %struct.rbnode_s* %55), !dbg !903
  br label %if.end32

if.end32:                                         ; preds = %if.end31, %if.then19
  store i32 0, i32* %retval, align 4, !dbg !904
  br label %return, !dbg !904

return:                                           ; preds = %if.end32, %if.else8
  %56 = load i32, i32* %retval, align 4, !dbg !905
  ret i32 %56, !dbg !905
}

; Function Attrs: noinline nounwind uwtable
define internal void @rebalance_after_insert(%struct.treetable_s* %table, %struct.rbnode_s* %z) #0 !dbg !906 {
entry:
  %table.addr = alloca %struct.treetable_s*, align 8
  %z.addr = alloca %struct.rbnode_s*, align 8
  %y = alloca %struct.rbnode_s*, align 8
  store %struct.treetable_s* %table, %struct.treetable_s** %table.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.treetable_s** %table.addr, metadata !907, metadata !DIExpression()), !dbg !908
  store %struct.rbnode_s* %z, %struct.rbnode_s** %z.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.rbnode_s** %z.addr, metadata !909, metadata !DIExpression()), !dbg !910
  call void @llvm.dbg.declare(metadata %struct.rbnode_s** %y, metadata !911, metadata !DIExpression()), !dbg !912
  br label %while.cond, !dbg !913

while.cond:                                       ; preds = %if.end69, %entry
  %0 = load %struct.rbnode_s*, %struct.rbnode_s** %z.addr, align 8, !dbg !914
  %parent = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %0, i32 0, i32 3, !dbg !915
  %1 = load %struct.rbnode_s*, %struct.rbnode_s** %parent, align 8, !dbg !915
  %color = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %1, i32 0, i32 2, !dbg !916
  %2 = load i8, i8* %color, align 8, !dbg !916
  %conv = sext i8 %2 to i32, !dbg !914
  %cmp = icmp eq i32 %conv, 0, !dbg !917
  br i1 %cmp, label %while.body, label %while.end, !dbg !913

while.body:                                       ; preds = %while.cond
  %3 = load %struct.rbnode_s*, %struct.rbnode_s** %z.addr, align 8, !dbg !918
  %parent2 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %3, i32 0, i32 3, !dbg !921
  %4 = load %struct.rbnode_s*, %struct.rbnode_s** %parent2, align 8, !dbg !921
  %5 = load %struct.rbnode_s*, %struct.rbnode_s** %z.addr, align 8, !dbg !922
  %parent3 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %5, i32 0, i32 3, !dbg !923
  %6 = load %struct.rbnode_s*, %struct.rbnode_s** %parent3, align 8, !dbg !923
  %parent4 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %6, i32 0, i32 3, !dbg !924
  %7 = load %struct.rbnode_s*, %struct.rbnode_s** %parent4, align 8, !dbg !924
  %left = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %7, i32 0, i32 4, !dbg !925
  %8 = load %struct.rbnode_s*, %struct.rbnode_s** %left, align 8, !dbg !925
  %cmp5 = icmp eq %struct.rbnode_s* %4, %8, !dbg !926
  br i1 %cmp5, label %if.then, label %if.else36, !dbg !927

if.then:                                          ; preds = %while.body
  %9 = load %struct.rbnode_s*, %struct.rbnode_s** %z.addr, align 8, !dbg !928
  %parent7 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %9, i32 0, i32 3, !dbg !930
  %10 = load %struct.rbnode_s*, %struct.rbnode_s** %parent7, align 8, !dbg !930
  %parent8 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %10, i32 0, i32 3, !dbg !931
  %11 = load %struct.rbnode_s*, %struct.rbnode_s** %parent8, align 8, !dbg !931
  %right = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %11, i32 0, i32 5, !dbg !932
  %12 = load %struct.rbnode_s*, %struct.rbnode_s** %right, align 8, !dbg !932
  store %struct.rbnode_s* %12, %struct.rbnode_s** %y, align 8, !dbg !933
  %13 = load %struct.rbnode_s*, %struct.rbnode_s** %y, align 8, !dbg !934
  %color9 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %13, i32 0, i32 2, !dbg !936
  %14 = load i8, i8* %color9, align 8, !dbg !936
  %conv10 = sext i8 %14 to i32, !dbg !934
  %cmp11 = icmp eq i32 %conv10, 0, !dbg !937
  br i1 %cmp11, label %if.then13, label %if.else, !dbg !938

if.then13:                                        ; preds = %if.then
  %15 = load %struct.rbnode_s*, %struct.rbnode_s** %z.addr, align 8, !dbg !939
  %parent14 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %15, i32 0, i32 3, !dbg !941
  %16 = load %struct.rbnode_s*, %struct.rbnode_s** %parent14, align 8, !dbg !941
  %color15 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %16, i32 0, i32 2, !dbg !942
  store i8 1, i8* %color15, align 8, !dbg !943
  %17 = load %struct.rbnode_s*, %struct.rbnode_s** %y, align 8, !dbg !944
  %color16 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %17, i32 0, i32 2, !dbg !945
  store i8 1, i8* %color16, align 8, !dbg !946
  %18 = load %struct.rbnode_s*, %struct.rbnode_s** %z.addr, align 8, !dbg !947
  %parent17 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %18, i32 0, i32 3, !dbg !948
  %19 = load %struct.rbnode_s*, %struct.rbnode_s** %parent17, align 8, !dbg !948
  %parent18 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %19, i32 0, i32 3, !dbg !949
  %20 = load %struct.rbnode_s*, %struct.rbnode_s** %parent18, align 8, !dbg !949
  %color19 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %20, i32 0, i32 2, !dbg !950
  store i8 0, i8* %color19, align 8, !dbg !951
  %21 = load %struct.rbnode_s*, %struct.rbnode_s** %z.addr, align 8, !dbg !952
  %parent20 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %21, i32 0, i32 3, !dbg !953
  %22 = load %struct.rbnode_s*, %struct.rbnode_s** %parent20, align 8, !dbg !953
  %parent21 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %22, i32 0, i32 3, !dbg !954
  %23 = load %struct.rbnode_s*, %struct.rbnode_s** %parent21, align 8, !dbg !954
  store %struct.rbnode_s* %23, %struct.rbnode_s** %z.addr, align 8, !dbg !955
  br label %if.end69, !dbg !956

if.else:                                          ; preds = %if.then
  %24 = load %struct.rbnode_s*, %struct.rbnode_s** %z.addr, align 8, !dbg !957
  %25 = load %struct.rbnode_s*, %struct.rbnode_s** %z.addr, align 8, !dbg !960
  %parent22 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %25, i32 0, i32 3, !dbg !961
  %26 = load %struct.rbnode_s*, %struct.rbnode_s** %parent22, align 8, !dbg !961
  %right23 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %26, i32 0, i32 5, !dbg !962
  %27 = load %struct.rbnode_s*, %struct.rbnode_s** %right23, align 8, !dbg !962
  %cmp24 = icmp eq %struct.rbnode_s* %24, %27, !dbg !963
  br i1 %cmp24, label %if.then26, label %if.end, !dbg !964

if.then26:                                        ; preds = %if.else
  %28 = load %struct.rbnode_s*, %struct.rbnode_s** %z.addr, align 8, !dbg !965
  %parent27 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %28, i32 0, i32 3, !dbg !967
  %29 = load %struct.rbnode_s*, %struct.rbnode_s** %parent27, align 8, !dbg !967
  store %struct.rbnode_s* %29, %struct.rbnode_s** %z.addr, align 8, !dbg !968
  %30 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !969
  %31 = load %struct.rbnode_s*, %struct.rbnode_s** %z.addr, align 8, !dbg !970
  call void @rotate_left(%struct.treetable_s* %30, %struct.rbnode_s* %31), !dbg !971
  br label %if.end, !dbg !972

if.end:                                           ; preds = %if.then26, %if.else
  %32 = load %struct.rbnode_s*, %struct.rbnode_s** %z.addr, align 8, !dbg !973
  %parent28 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %32, i32 0, i32 3, !dbg !974
  %33 = load %struct.rbnode_s*, %struct.rbnode_s** %parent28, align 8, !dbg !974
  %color29 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %33, i32 0, i32 2, !dbg !975
  store i8 1, i8* %color29, align 8, !dbg !976
  %34 = load %struct.rbnode_s*, %struct.rbnode_s** %z.addr, align 8, !dbg !977
  %parent30 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %34, i32 0, i32 3, !dbg !978
  %35 = load %struct.rbnode_s*, %struct.rbnode_s** %parent30, align 8, !dbg !978
  %parent31 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %35, i32 0, i32 3, !dbg !979
  %36 = load %struct.rbnode_s*, %struct.rbnode_s** %parent31, align 8, !dbg !979
  %color32 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %36, i32 0, i32 2, !dbg !980
  store i8 0, i8* %color32, align 8, !dbg !981
  %37 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !982
  %38 = load %struct.rbnode_s*, %struct.rbnode_s** %z.addr, align 8, !dbg !983
  %parent33 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %38, i32 0, i32 3, !dbg !984
  %39 = load %struct.rbnode_s*, %struct.rbnode_s** %parent33, align 8, !dbg !984
  %parent34 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %39, i32 0, i32 3, !dbg !985
  %40 = load %struct.rbnode_s*, %struct.rbnode_s** %parent34, align 8, !dbg !985
  call void @rotate_right(%struct.treetable_s* %37, %struct.rbnode_s* %40), !dbg !986
  br label %if.end69

if.else36:                                        ; preds = %while.body
  %41 = load %struct.rbnode_s*, %struct.rbnode_s** %z.addr, align 8, !dbg !987
  %parent37 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %41, i32 0, i32 3, !dbg !989
  %42 = load %struct.rbnode_s*, %struct.rbnode_s** %parent37, align 8, !dbg !989
  %parent38 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %42, i32 0, i32 3, !dbg !990
  %43 = load %struct.rbnode_s*, %struct.rbnode_s** %parent38, align 8, !dbg !990
  %left39 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %43, i32 0, i32 4, !dbg !991
  %44 = load %struct.rbnode_s*, %struct.rbnode_s** %left39, align 8, !dbg !991
  store %struct.rbnode_s* %44, %struct.rbnode_s** %y, align 8, !dbg !992
  %45 = load %struct.rbnode_s*, %struct.rbnode_s** %y, align 8, !dbg !993
  %color40 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %45, i32 0, i32 2, !dbg !995
  %46 = load i8, i8* %color40, align 8, !dbg !995
  %conv41 = sext i8 %46 to i32, !dbg !993
  %cmp42 = icmp eq i32 %conv41, 0, !dbg !996
  br i1 %cmp42, label %if.then44, label %if.else53, !dbg !997

if.then44:                                        ; preds = %if.else36
  %47 = load %struct.rbnode_s*, %struct.rbnode_s** %z.addr, align 8, !dbg !998
  %parent45 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %47, i32 0, i32 3, !dbg !1000
  %48 = load %struct.rbnode_s*, %struct.rbnode_s** %parent45, align 8, !dbg !1000
  %color46 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %48, i32 0, i32 2, !dbg !1001
  store i8 1, i8* %color46, align 8, !dbg !1002
  %49 = load %struct.rbnode_s*, %struct.rbnode_s** %y, align 8, !dbg !1003
  %color47 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %49, i32 0, i32 2, !dbg !1004
  store i8 1, i8* %color47, align 8, !dbg !1005
  %50 = load %struct.rbnode_s*, %struct.rbnode_s** %z.addr, align 8, !dbg !1006
  %parent48 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %50, i32 0, i32 3, !dbg !1007
  %51 = load %struct.rbnode_s*, %struct.rbnode_s** %parent48, align 8, !dbg !1007
  %parent49 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %51, i32 0, i32 3, !dbg !1008
  %52 = load %struct.rbnode_s*, %struct.rbnode_s** %parent49, align 8, !dbg !1008
  %color50 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %52, i32 0, i32 2, !dbg !1009
  store i8 0, i8* %color50, align 8, !dbg !1010
  %53 = load %struct.rbnode_s*, %struct.rbnode_s** %z.addr, align 8, !dbg !1011
  %parent51 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %53, i32 0, i32 3, !dbg !1012
  %54 = load %struct.rbnode_s*, %struct.rbnode_s** %parent51, align 8, !dbg !1012
  %parent52 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %54, i32 0, i32 3, !dbg !1013
  %55 = load %struct.rbnode_s*, %struct.rbnode_s** %parent52, align 8, !dbg !1013
  store %struct.rbnode_s* %55, %struct.rbnode_s** %z.addr, align 8, !dbg !1014
  br label %if.end69, !dbg !1015

if.else53:                                        ; preds = %if.else36
  %56 = load %struct.rbnode_s*, %struct.rbnode_s** %z.addr, align 8, !dbg !1016
  %57 = load %struct.rbnode_s*, %struct.rbnode_s** %z.addr, align 8, !dbg !1019
  %parent54 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %57, i32 0, i32 3, !dbg !1020
  %58 = load %struct.rbnode_s*, %struct.rbnode_s** %parent54, align 8, !dbg !1020
  %left55 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %58, i32 0, i32 4, !dbg !1021
  %59 = load %struct.rbnode_s*, %struct.rbnode_s** %left55, align 8, !dbg !1021
  %cmp56 = icmp eq %struct.rbnode_s* %56, %59, !dbg !1022
  br i1 %cmp56, label %if.then58, label %if.end60, !dbg !1023

if.then58:                                        ; preds = %if.else53
  %60 = load %struct.rbnode_s*, %struct.rbnode_s** %z.addr, align 8, !dbg !1024
  %parent59 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %60, i32 0, i32 3, !dbg !1026
  %61 = load %struct.rbnode_s*, %struct.rbnode_s** %parent59, align 8, !dbg !1026
  store %struct.rbnode_s* %61, %struct.rbnode_s** %z.addr, align 8, !dbg !1027
  %62 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !1028
  %63 = load %struct.rbnode_s*, %struct.rbnode_s** %z.addr, align 8, !dbg !1029
  call void @rotate_right(%struct.treetable_s* %62, %struct.rbnode_s* %63), !dbg !1030
  br label %if.end60, !dbg !1031

if.end60:                                         ; preds = %if.then58, %if.else53
  %64 = load %struct.rbnode_s*, %struct.rbnode_s** %z.addr, align 8, !dbg !1032
  %parent61 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %64, i32 0, i32 3, !dbg !1033
  %65 = load %struct.rbnode_s*, %struct.rbnode_s** %parent61, align 8, !dbg !1033
  %color62 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %65, i32 0, i32 2, !dbg !1034
  store i8 1, i8* %color62, align 8, !dbg !1035
  %66 = load %struct.rbnode_s*, %struct.rbnode_s** %z.addr, align 8, !dbg !1036
  %parent63 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %66, i32 0, i32 3, !dbg !1037
  %67 = load %struct.rbnode_s*, %struct.rbnode_s** %parent63, align 8, !dbg !1037
  %parent64 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %67, i32 0, i32 3, !dbg !1038
  %68 = load %struct.rbnode_s*, %struct.rbnode_s** %parent64, align 8, !dbg !1038
  %color65 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %68, i32 0, i32 2, !dbg !1039
  store i8 0, i8* %color65, align 8, !dbg !1040
  %69 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !1041
  %70 = load %struct.rbnode_s*, %struct.rbnode_s** %z.addr, align 8, !dbg !1042
  %parent66 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %70, i32 0, i32 3, !dbg !1043
  %71 = load %struct.rbnode_s*, %struct.rbnode_s** %parent66, align 8, !dbg !1043
  %parent67 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %71, i32 0, i32 3, !dbg !1044
  %72 = load %struct.rbnode_s*, %struct.rbnode_s** %parent67, align 8, !dbg !1044
  call void @rotate_left(%struct.treetable_s* %69, %struct.rbnode_s* %72), !dbg !1045
  br label %if.end69

if.end69:                                         ; preds = %if.then44, %if.end60, %if.then13, %if.end
  br label %while.cond, !dbg !913, !llvm.loop !1046

while.end:                                        ; preds = %while.cond
  %73 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !1048
  %root = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %73, i32 0, i32 0, !dbg !1049
  %74 = load %struct.rbnode_s*, %struct.rbnode_s** %root, align 8, !dbg !1049
  %color70 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %74, i32 0, i32 2, !dbg !1050
  store i8 1, i8* %color70, align 8, !dbg !1051
  ret void, !dbg !1052
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @test_get_greater_than_absent_key_fails() #0 !dbg !1053 {
entry:
  %present = alloca i32, align 4
  %absent = alloca i32, align 4
  %value = alloca i32, align 4
  %out = alloca i8*, align 8
  %table = alloca %struct.treetable_s*, align 8
  call void @llvm.dbg.declare(metadata i32* %present, metadata !1056, metadata !DIExpression()), !dbg !1057
  %call = call i32 @symbolic_int(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str, i64 0, i64 0), i32 5), !dbg !1058
  store i32 %call, i32* %present, align 4, !dbg !1057
  call void @llvm.dbg.declare(metadata i32* %absent, metadata !1059, metadata !DIExpression()), !dbg !1060
  %call1 = call i32 @symbolic_int(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.1, i64 0, i64 0), i32 6), !dbg !1061
  store i32 %call1, i32* %absent, align 4, !dbg !1060
  call void @llvm.dbg.declare(metadata i32* %value, metadata !1062, metadata !DIExpression()), !dbg !1063
  %call2 = call i32 @symbolic_int(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.2, i64 0, i64 0), i32 1), !dbg !1064
  store i32 %call2, i32* %value, align 4, !dbg !1063
  call void @llvm.dbg.declare(metadata i8** %out, metadata !1065, metadata !DIExpression()), !dbg !1066
  store i8* null, i8** %out, align 8, !dbg !1066
  %0 = load i32, i32* %present, align 4, !dbg !1067
  %1 = load i32, i32* %absent, align 4, !dbg !1068
  %cmp = icmp ne i32 %0, %1, !dbg !1069
  %conv = zext i1 %cmp to i32, !dbg !1069
  %conv3 = sext i32 %conv to i64, !dbg !1067
  call void @klee_assume(i64 %conv3), !dbg !1070
  call void @llvm.dbg.declare(metadata %struct.treetable_s** %table, metadata !1071, metadata !DIExpression()), !dbg !1072
  %call4 = call %struct.treetable_s* @make_table(), !dbg !1073
  store %struct.treetable_s* %call4, %struct.treetable_s** %table, align 8, !dbg !1072
  %2 = load %struct.treetable_s*, %struct.treetable_s** %table, align 8, !dbg !1074
  %3 = bitcast i32* %present to i8*, !dbg !1074
  %4 = bitcast i32* %value to i8*, !dbg !1074
  %call5 = call i32 @treetable_add(%struct.treetable_s* %2, i8* %3, i8* %4), !dbg !1074
  %cmp6 = icmp eq i32 %call5, 0, !dbg !1074
  br i1 %cmp6, label %cond.end, label %cond.false, !dbg !1074

cond.false:                                       ; preds = %entry
  call void @__assert_fail(i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.3, i64 0, i64 0), i8* getelementptr inbounds ([41 x i8], [41 x i8]* @.str.4, i64 0, i64 0), i32 33, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.test_get_greater_than_absent_key_fails, i64 0, i64 0)) #6, !dbg !1074
  unreachable, !dbg !1074

cond.end:                                         ; preds = %entry
  %5 = load %struct.treetable_s*, %struct.treetable_s** %table, align 8, !dbg !1075
  %6 = bitcast i32* %absent to i8*, !dbg !1075
  %call8 = call i32 @treetable_get_greater_than(%struct.treetable_s* %5, i8* %6, i8** %out), !dbg !1075
  %cmp9 = icmp eq i32 %call8, 6, !dbg !1075
  br i1 %cmp9, label %cond.end13, label %cond.false12, !dbg !1075

cond.false12:                                     ; preds = %cond.end
  call void @__assert_fail(i8* getelementptr inbounds ([73 x i8], [73 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([41 x i8], [41 x i8]* @.str.4, i64 0, i64 0), i32 35, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.test_get_greater_than_absent_key_fails, i64 0, i64 0)) #6, !dbg !1075
  unreachable, !dbg !1075

cond.end13:                                       ; preds = %cond.end
  %7 = load %struct.treetable_s*, %struct.treetable_s** %table, align 8, !dbg !1076
  call void @treetable_destroy(%struct.treetable_s* %7), !dbg !1077
  ret void, !dbg !1078
}

; Function Attrs: noinline nounwind uwtable
define internal i32 @symbolic_int(i8* %name, i32 %concrete_fallback) #0 !dbg !1079 {
entry:
  %name.addr = alloca i8*, align 8
  %concrete_fallback.addr = alloca i32, align 4
  %value = alloca i32, align 4
  store i8* %name, i8** %name.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %name.addr, metadata !1085, metadata !DIExpression()), !dbg !1086
  store i32 %concrete_fallback, i32* %concrete_fallback.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %concrete_fallback.addr, metadata !1087, metadata !DIExpression()), !dbg !1088
  call void @llvm.dbg.declare(metadata i32* %value, metadata !1089, metadata !DIExpression()), !dbg !1090
  %0 = load i32, i32* %concrete_fallback.addr, align 4, !dbg !1091
  store i32 %0, i32* %value, align 4, !dbg !1090
  %1 = bitcast i32* %value to i8*, !dbg !1092
  %2 = load i8*, i8** %name.addr, align 8, !dbg !1093
  call void @klee_make_symbolic(i8* %1, i64 4, i8* %2), !dbg !1094
  %3 = load i32, i32* %value, align 4, !dbg !1095
  ret i32 %3, !dbg !1096
}

declare dso_local void @klee_assume(i64) #4

; Function Attrs: noinline nounwind uwtable
define internal %struct.treetable_s* @make_table() #0 !dbg !1097 {
entry:
  %conf = alloca %struct.treetable_conf_s, align 8
  %table = alloca %struct.treetable_s*, align 8
  call void @llvm.dbg.declare(metadata %struct.treetable_conf_s* %conf, metadata !1100, metadata !DIExpression()), !dbg !1101
  call void @llvm.dbg.declare(metadata %struct.treetable_s** %table, metadata !1102, metadata !DIExpression()), !dbg !1103
  store %struct.treetable_s* null, %struct.treetable_s** %table, align 8, !dbg !1103
  call void @treetable_conf_init(%struct.treetable_conf_s* %conf), !dbg !1104
  %mem_alloc = getelementptr inbounds %struct.treetable_conf_s, %struct.treetable_conf_s* %conf, i32 0, i32 1, !dbg !1105
  store i8* (i64)* @safe_malloc, i8* (i64)** %mem_alloc, align 8, !dbg !1106
  %mem_calloc = getelementptr inbounds %struct.treetable_conf_s, %struct.treetable_conf_s* %conf, i32 0, i32 2, !dbg !1107
  store i8* (i64, i64)* @safe_calloc, i8* (i64, i64)** %mem_calloc, align 8, !dbg !1108
  %call = call i32 @treetable_new_conf(%struct.treetable_conf_s* %conf, %struct.treetable_s** %table), !dbg !1109
  %cmp = icmp eq i32 %call, 0, !dbg !1109
  br i1 %cmp, label %cond.end, label %cond.false, !dbg !1109

cond.false:                                       ; preds = %entry
  call void @__assert_fail(i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.6, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.7, i64 0, i64 0), i32 60, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__PRETTY_FUNCTION__.make_table, i64 0, i64 0)) #6, !dbg !1109
  unreachable, !dbg !1109

cond.end:                                         ; preds = %entry
  %0 = load %struct.treetable_s*, %struct.treetable_s** %table, align 8, !dbg !1110
  %cmp1 = icmp ne %struct.treetable_s* %0, null, !dbg !1110
  br i1 %cmp1, label %cond.end4, label %cond.false3, !dbg !1110

cond.false3:                                      ; preds = %cond.end
  call void @__assert_fail(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.8, i64 0, i64 0), i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.7, i64 0, i64 0), i32 61, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @__PRETTY_FUNCTION__.make_table, i64 0, i64 0)) #6, !dbg !1110
  unreachable, !dbg !1110

cond.end4:                                        ; preds = %cond.end
  %1 = load %struct.treetable_s*, %struct.treetable_s** %table, align 8, !dbg !1111
  ret %struct.treetable_s* %1, !dbg !1112
}

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #5

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !1113 {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @test_get_greater_than_absent_key_fails(), !dbg !1116
  ret i32 0, !dbg !1117
}

; Function Attrs: noinline nounwind uwtable
define internal void @rotate_left(%struct.treetable_s* %table, %struct.rbnode_s* %x) #0 !dbg !1118 {
entry:
  %table.addr = alloca %struct.treetable_s*, align 8
  %x.addr = alloca %struct.rbnode_s*, align 8
  %y = alloca %struct.rbnode_s*, align 8
  store %struct.treetable_s* %table, %struct.treetable_s** %table.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.treetable_s** %table.addr, metadata !1119, metadata !DIExpression()), !dbg !1120
  store %struct.rbnode_s* %x, %struct.rbnode_s** %x.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.rbnode_s** %x.addr, metadata !1121, metadata !DIExpression()), !dbg !1122
  call void @llvm.dbg.declare(metadata %struct.rbnode_s** %y, metadata !1123, metadata !DIExpression()), !dbg !1124
  %0 = load %struct.rbnode_s*, %struct.rbnode_s** %x.addr, align 8, !dbg !1125
  %right = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %0, i32 0, i32 5, !dbg !1126
  %1 = load %struct.rbnode_s*, %struct.rbnode_s** %right, align 8, !dbg !1126
  store %struct.rbnode_s* %1, %struct.rbnode_s** %y, align 8, !dbg !1124
  %2 = load %struct.rbnode_s*, %struct.rbnode_s** %y, align 8, !dbg !1127
  %left = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %2, i32 0, i32 4, !dbg !1128
  %3 = load %struct.rbnode_s*, %struct.rbnode_s** %left, align 8, !dbg !1128
  %4 = load %struct.rbnode_s*, %struct.rbnode_s** %x.addr, align 8, !dbg !1129
  %right1 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %4, i32 0, i32 5, !dbg !1130
  store %struct.rbnode_s* %3, %struct.rbnode_s** %right1, align 8, !dbg !1131
  %5 = load %struct.rbnode_s*, %struct.rbnode_s** %y, align 8, !dbg !1132
  %left2 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %5, i32 0, i32 4, !dbg !1134
  %6 = load %struct.rbnode_s*, %struct.rbnode_s** %left2, align 8, !dbg !1134
  %7 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !1135
  %sentinel = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %7, i32 0, i32 1, !dbg !1136
  %8 = load %struct.rbnode_s*, %struct.rbnode_s** %sentinel, align 8, !dbg !1136
  %cmp = icmp ne %struct.rbnode_s* %6, %8, !dbg !1137
  br i1 %cmp, label %if.then, label %if.end, !dbg !1138

if.then:                                          ; preds = %entry
  %9 = load %struct.rbnode_s*, %struct.rbnode_s** %x.addr, align 8, !dbg !1139
  %10 = load %struct.rbnode_s*, %struct.rbnode_s** %y, align 8, !dbg !1140
  %left3 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %10, i32 0, i32 4, !dbg !1141
  %11 = load %struct.rbnode_s*, %struct.rbnode_s** %left3, align 8, !dbg !1141
  %parent = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %11, i32 0, i32 3, !dbg !1142
  store %struct.rbnode_s* %9, %struct.rbnode_s** %parent, align 8, !dbg !1143
  br label %if.end, !dbg !1140

if.end:                                           ; preds = %if.then, %entry
  %12 = load %struct.rbnode_s*, %struct.rbnode_s** %x.addr, align 8, !dbg !1144
  %parent4 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %12, i32 0, i32 3, !dbg !1145
  %13 = load %struct.rbnode_s*, %struct.rbnode_s** %parent4, align 8, !dbg !1145
  %14 = load %struct.rbnode_s*, %struct.rbnode_s** %y, align 8, !dbg !1146
  %parent5 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %14, i32 0, i32 3, !dbg !1147
  store %struct.rbnode_s* %13, %struct.rbnode_s** %parent5, align 8, !dbg !1148
  %15 = load %struct.rbnode_s*, %struct.rbnode_s** %x.addr, align 8, !dbg !1149
  %parent6 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %15, i32 0, i32 3, !dbg !1151
  %16 = load %struct.rbnode_s*, %struct.rbnode_s** %parent6, align 8, !dbg !1151
  %17 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !1152
  %sentinel7 = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %17, i32 0, i32 1, !dbg !1153
  %18 = load %struct.rbnode_s*, %struct.rbnode_s** %sentinel7, align 8, !dbg !1153
  %cmp8 = icmp eq %struct.rbnode_s* %16, %18, !dbg !1154
  br i1 %cmp8, label %if.then9, label %if.else, !dbg !1155

if.then9:                                         ; preds = %if.end
  %19 = load %struct.rbnode_s*, %struct.rbnode_s** %y, align 8, !dbg !1156
  %20 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !1157
  %root = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %20, i32 0, i32 0, !dbg !1158
  store %struct.rbnode_s* %19, %struct.rbnode_s** %root, align 8, !dbg !1159
  br label %if.end20, !dbg !1157

if.else:                                          ; preds = %if.end
  %21 = load %struct.rbnode_s*, %struct.rbnode_s** %x.addr, align 8, !dbg !1160
  %22 = load %struct.rbnode_s*, %struct.rbnode_s** %x.addr, align 8, !dbg !1162
  %parent10 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %22, i32 0, i32 3, !dbg !1163
  %23 = load %struct.rbnode_s*, %struct.rbnode_s** %parent10, align 8, !dbg !1163
  %left11 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %23, i32 0, i32 4, !dbg !1164
  %24 = load %struct.rbnode_s*, %struct.rbnode_s** %left11, align 8, !dbg !1164
  %cmp12 = icmp eq %struct.rbnode_s* %21, %24, !dbg !1165
  br i1 %cmp12, label %if.then13, label %if.else16, !dbg !1166

if.then13:                                        ; preds = %if.else
  %25 = load %struct.rbnode_s*, %struct.rbnode_s** %y, align 8, !dbg !1167
  %26 = load %struct.rbnode_s*, %struct.rbnode_s** %x.addr, align 8, !dbg !1168
  %parent14 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %26, i32 0, i32 3, !dbg !1169
  %27 = load %struct.rbnode_s*, %struct.rbnode_s** %parent14, align 8, !dbg !1169
  %left15 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %27, i32 0, i32 4, !dbg !1170
  store %struct.rbnode_s* %25, %struct.rbnode_s** %left15, align 8, !dbg !1171
  br label %if.end20, !dbg !1168

if.else16:                                        ; preds = %if.else
  %28 = load %struct.rbnode_s*, %struct.rbnode_s** %y, align 8, !dbg !1172
  %29 = load %struct.rbnode_s*, %struct.rbnode_s** %x.addr, align 8, !dbg !1173
  %parent17 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %29, i32 0, i32 3, !dbg !1174
  %30 = load %struct.rbnode_s*, %struct.rbnode_s** %parent17, align 8, !dbg !1174
  %right18 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %30, i32 0, i32 5, !dbg !1175
  store %struct.rbnode_s* %28, %struct.rbnode_s** %right18, align 8, !dbg !1176
  br label %if.end20

if.end20:                                         ; preds = %if.then13, %if.else16, %if.then9
  %31 = load %struct.rbnode_s*, %struct.rbnode_s** %x.addr, align 8, !dbg !1177
  %32 = load %struct.rbnode_s*, %struct.rbnode_s** %y, align 8, !dbg !1178
  %left21 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %32, i32 0, i32 4, !dbg !1179
  store %struct.rbnode_s* %31, %struct.rbnode_s** %left21, align 8, !dbg !1180
  %33 = load %struct.rbnode_s*, %struct.rbnode_s** %y, align 8, !dbg !1181
  %34 = load %struct.rbnode_s*, %struct.rbnode_s** %x.addr, align 8, !dbg !1182
  %parent22 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %34, i32 0, i32 3, !dbg !1183
  store %struct.rbnode_s* %33, %struct.rbnode_s** %parent22, align 8, !dbg !1184
  ret void, !dbg !1185
}

; Function Attrs: noinline nounwind uwtable
define internal void @rotate_right(%struct.treetable_s* %table, %struct.rbnode_s* %x) #0 !dbg !1186 {
entry:
  %table.addr = alloca %struct.treetable_s*, align 8
  %x.addr = alloca %struct.rbnode_s*, align 8
  %y = alloca %struct.rbnode_s*, align 8
  store %struct.treetable_s* %table, %struct.treetable_s** %table.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.treetable_s** %table.addr, metadata !1187, metadata !DIExpression()), !dbg !1188
  store %struct.rbnode_s* %x, %struct.rbnode_s** %x.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.rbnode_s** %x.addr, metadata !1189, metadata !DIExpression()), !dbg !1190
  call void @llvm.dbg.declare(metadata %struct.rbnode_s** %y, metadata !1191, metadata !DIExpression()), !dbg !1192
  %0 = load %struct.rbnode_s*, %struct.rbnode_s** %x.addr, align 8, !dbg !1193
  %left = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %0, i32 0, i32 4, !dbg !1194
  %1 = load %struct.rbnode_s*, %struct.rbnode_s** %left, align 8, !dbg !1194
  store %struct.rbnode_s* %1, %struct.rbnode_s** %y, align 8, !dbg !1192
  %2 = load %struct.rbnode_s*, %struct.rbnode_s** %y, align 8, !dbg !1195
  %right = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %2, i32 0, i32 5, !dbg !1196
  %3 = load %struct.rbnode_s*, %struct.rbnode_s** %right, align 8, !dbg !1196
  %4 = load %struct.rbnode_s*, %struct.rbnode_s** %x.addr, align 8, !dbg !1197
  %left1 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %4, i32 0, i32 4, !dbg !1198
  store %struct.rbnode_s* %3, %struct.rbnode_s** %left1, align 8, !dbg !1199
  %5 = load %struct.rbnode_s*, %struct.rbnode_s** %y, align 8, !dbg !1200
  %right2 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %5, i32 0, i32 5, !dbg !1202
  %6 = load %struct.rbnode_s*, %struct.rbnode_s** %right2, align 8, !dbg !1202
  %7 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !1203
  %sentinel = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %7, i32 0, i32 1, !dbg !1204
  %8 = load %struct.rbnode_s*, %struct.rbnode_s** %sentinel, align 8, !dbg !1204
  %cmp = icmp ne %struct.rbnode_s* %6, %8, !dbg !1205
  br i1 %cmp, label %if.then, label %if.end, !dbg !1206

if.then:                                          ; preds = %entry
  %9 = load %struct.rbnode_s*, %struct.rbnode_s** %x.addr, align 8, !dbg !1207
  %10 = load %struct.rbnode_s*, %struct.rbnode_s** %y, align 8, !dbg !1208
  %right3 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %10, i32 0, i32 5, !dbg !1209
  %11 = load %struct.rbnode_s*, %struct.rbnode_s** %right3, align 8, !dbg !1209
  %parent = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %11, i32 0, i32 3, !dbg !1210
  store %struct.rbnode_s* %9, %struct.rbnode_s** %parent, align 8, !dbg !1211
  br label %if.end, !dbg !1208

if.end:                                           ; preds = %if.then, %entry
  %12 = load %struct.rbnode_s*, %struct.rbnode_s** %x.addr, align 8, !dbg !1212
  %parent4 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %12, i32 0, i32 3, !dbg !1213
  %13 = load %struct.rbnode_s*, %struct.rbnode_s** %parent4, align 8, !dbg !1213
  %14 = load %struct.rbnode_s*, %struct.rbnode_s** %y, align 8, !dbg !1214
  %parent5 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %14, i32 0, i32 3, !dbg !1215
  store %struct.rbnode_s* %13, %struct.rbnode_s** %parent5, align 8, !dbg !1216
  %15 = load %struct.rbnode_s*, %struct.rbnode_s** %x.addr, align 8, !dbg !1217
  %parent6 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %15, i32 0, i32 3, !dbg !1219
  %16 = load %struct.rbnode_s*, %struct.rbnode_s** %parent6, align 8, !dbg !1219
  %17 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !1220
  %sentinel7 = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %17, i32 0, i32 1, !dbg !1221
  %18 = load %struct.rbnode_s*, %struct.rbnode_s** %sentinel7, align 8, !dbg !1221
  %cmp8 = icmp eq %struct.rbnode_s* %16, %18, !dbg !1222
  br i1 %cmp8, label %if.then9, label %if.else, !dbg !1223

if.then9:                                         ; preds = %if.end
  %19 = load %struct.rbnode_s*, %struct.rbnode_s** %y, align 8, !dbg !1224
  %20 = load %struct.treetable_s*, %struct.treetable_s** %table.addr, align 8, !dbg !1225
  %root = getelementptr inbounds %struct.treetable_s, %struct.treetable_s* %20, i32 0, i32 0, !dbg !1226
  store %struct.rbnode_s* %19, %struct.rbnode_s** %root, align 8, !dbg !1227
  br label %if.end20, !dbg !1225

if.else:                                          ; preds = %if.end
  %21 = load %struct.rbnode_s*, %struct.rbnode_s** %x.addr, align 8, !dbg !1228
  %22 = load %struct.rbnode_s*, %struct.rbnode_s** %x.addr, align 8, !dbg !1230
  %parent10 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %22, i32 0, i32 3, !dbg !1231
  %23 = load %struct.rbnode_s*, %struct.rbnode_s** %parent10, align 8, !dbg !1231
  %right11 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %23, i32 0, i32 5, !dbg !1232
  %24 = load %struct.rbnode_s*, %struct.rbnode_s** %right11, align 8, !dbg !1232
  %cmp12 = icmp eq %struct.rbnode_s* %21, %24, !dbg !1233
  br i1 %cmp12, label %if.then13, label %if.else16, !dbg !1234

if.then13:                                        ; preds = %if.else
  %25 = load %struct.rbnode_s*, %struct.rbnode_s** %y, align 8, !dbg !1235
  %26 = load %struct.rbnode_s*, %struct.rbnode_s** %x.addr, align 8, !dbg !1236
  %parent14 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %26, i32 0, i32 3, !dbg !1237
  %27 = load %struct.rbnode_s*, %struct.rbnode_s** %parent14, align 8, !dbg !1237
  %right15 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %27, i32 0, i32 5, !dbg !1238
  store %struct.rbnode_s* %25, %struct.rbnode_s** %right15, align 8, !dbg !1239
  br label %if.end20, !dbg !1236

if.else16:                                        ; preds = %if.else
  %28 = load %struct.rbnode_s*, %struct.rbnode_s** %y, align 8, !dbg !1240
  %29 = load %struct.rbnode_s*, %struct.rbnode_s** %x.addr, align 8, !dbg !1241
  %parent17 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %29, i32 0, i32 3, !dbg !1242
  %30 = load %struct.rbnode_s*, %struct.rbnode_s** %parent17, align 8, !dbg !1242
  %left18 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %30, i32 0, i32 4, !dbg !1243
  store %struct.rbnode_s* %28, %struct.rbnode_s** %left18, align 8, !dbg !1244
  br label %if.end20

if.end20:                                         ; preds = %if.then13, %if.else16, %if.then9
  %31 = load %struct.rbnode_s*, %struct.rbnode_s** %x.addr, align 8, !dbg !1245
  %32 = load %struct.rbnode_s*, %struct.rbnode_s** %y, align 8, !dbg !1246
  %right21 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %32, i32 0, i32 5, !dbg !1247
  store %struct.rbnode_s* %31, %struct.rbnode_s** %right21, align 8, !dbg !1248
  %33 = load %struct.rbnode_s*, %struct.rbnode_s** %y, align 8, !dbg !1249
  %34 = load %struct.rbnode_s*, %struct.rbnode_s** %x.addr, align 8, !dbg !1250
  %parent22 = getelementptr inbounds %struct.rbnode_s, %struct.rbnode_s* %34, i32 0, i32 3, !dbg !1251
  store %struct.rbnode_s* %33, %struct.rbnode_s** %parent22, align 8, !dbg !1252
  ret void, !dbg !1253
}

declare dso_local void @klee_make_symbolic(i8*, i64, i8*) #4

; Function Attrs: noinline nounwind uwtable
define internal i8* @safe_malloc(i64 %size) #0 !dbg !1254 {
entry:
  %size.addr = alloca i64, align 8
  %ptr = alloca i8*, align 8
  store i64 %size, i64* %size.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %size.addr, metadata !1255, metadata !DIExpression()), !dbg !1256
  call void @llvm.dbg.declare(metadata i8** %ptr, metadata !1257, metadata !DIExpression()), !dbg !1258
  %0 = load i64, i64* %size.addr, align 8, !dbg !1259
  %call = call noalias align 16 i8* @malloc(i64 %0) #7, !dbg !1260
  store i8* %call, i8** %ptr, align 8, !dbg !1258
  %1 = load i8*, i8** %ptr, align 8, !dbg !1261
  %cmp = icmp ne i8* %1, null, !dbg !1262
  %conv = zext i1 %cmp to i32, !dbg !1262
  %conv1 = sext i32 %conv to i64, !dbg !1261
  call void @klee_assume(i64 %conv1), !dbg !1263
  %2 = load i8*, i8** %ptr, align 8, !dbg !1264
  ret i8* %2, !dbg !1265
}

; Function Attrs: noinline nounwind uwtable
define internal i8* @safe_calloc(i64 %count, i64 %size) #0 !dbg !1266 {
entry:
  %count.addr = alloca i64, align 8
  %size.addr = alloca i64, align 8
  %ptr = alloca i8*, align 8
  store i64 %count, i64* %count.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %count.addr, metadata !1267, metadata !DIExpression()), !dbg !1268
  store i64 %size, i64* %size.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %size.addr, metadata !1269, metadata !DIExpression()), !dbg !1270
  call void @llvm.dbg.declare(metadata i8** %ptr, metadata !1271, metadata !DIExpression()), !dbg !1272
  %0 = load i64, i64* %count.addr, align 8, !dbg !1273
  %1 = load i64, i64* %size.addr, align 8, !dbg !1274
  %call = call noalias align 16 i8* @calloc(i64 %0, i64 %1) #7, !dbg !1275
  store i8* %call, i8** %ptr, align 8, !dbg !1272
  %2 = load i8*, i8** %ptr, align 8, !dbg !1276
  %cmp = icmp ne i8* %2, null, !dbg !1277
  %conv = zext i1 %cmp to i32, !dbg !1277
  %conv1 = sext i32 %conv to i64, !dbg !1276
  call void @klee_assume(i64 %conv1), !dbg !1278
  %3 = load i8*, i8** %ptr, align 8, !dbg !1279
  ret i8* %3, !dbg !1280
}

; Function Attrs: noinline nounwind uwtable
define dso_local i8* @memcpy(i8* %destaddr, i8* %srcaddr, i64 %len) #0 !dbg !1281 {
entry:
  %destaddr.addr = alloca i8*, align 8
  %srcaddr.addr = alloca i8*, align 8
  %len.addr = alloca i64, align 8
  %dest = alloca i8*, align 8
  %src = alloca i8*, align 8
  store i8* %destaddr, i8** %destaddr.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %destaddr.addr, metadata !1287, metadata !DIExpression()), !dbg !1288
  store i8* %srcaddr, i8** %srcaddr.addr, align 8
  call void @llvm.dbg.declare(metadata i8** %srcaddr.addr, metadata !1289, metadata !DIExpression()), !dbg !1290
  store i64 %len, i64* %len.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %len.addr, metadata !1291, metadata !DIExpression()), !dbg !1292
  call void @llvm.dbg.declare(metadata i8** %dest, metadata !1293, metadata !DIExpression()), !dbg !1295
  %0 = load i8*, i8** %destaddr.addr, align 8, !dbg !1296
  store i8* %0, i8** %dest, align 8, !dbg !1295
  call void @llvm.dbg.declare(metadata i8** %src, metadata !1297, metadata !DIExpression()), !dbg !1298
  %1 = load i8*, i8** %srcaddr.addr, align 8, !dbg !1299
  store i8* %1, i8** %src, align 8, !dbg !1298
  br label %while.cond, !dbg !1300

while.cond:                                       ; preds = %while.body, %entry
  %2 = load i64, i64* %len.addr, align 8, !dbg !1301
  %dec = add i64 %2, -1, !dbg !1301
  store i64 %dec, i64* %len.addr, align 8, !dbg !1301
  %cmp = icmp ugt i64 %2, 0, !dbg !1302
  br i1 %cmp, label %while.body, label %while.end, !dbg !1300

while.body:                                       ; preds = %while.cond
  %3 = load i8*, i8** %src, align 8, !dbg !1303
  %incdec.ptr = getelementptr inbounds i8, i8* %3, i32 1, !dbg !1303
  store i8* %incdec.ptr, i8** %src, align 8, !dbg !1303
  %4 = load i8, i8* %3, align 1, !dbg !1304
  %5 = load i8*, i8** %dest, align 8, !dbg !1305
  %incdec.ptr1 = getelementptr inbounds i8, i8* %5, i32 1, !dbg !1305
  store i8* %incdec.ptr1, i8** %dest, align 8, !dbg !1305
  store i8 %4, i8* %5, align 1, !dbg !1306
  br label %while.cond, !dbg !1300, !llvm.loop !1307

while.end:                                        ; preds = %while.cond
  %6 = load i8*, i8** %destaddr.addr, align 8, !dbg !1308
  ret i8* %6, !dbg !1309
}

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { argmemonly nofree nounwind willreturn }
attributes #4 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { noreturn nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { noreturn nounwind }
attributes #7 = { nounwind }

!llvm.dbg.cu = !{!0, !20}
!llvm.module.flags = !{!23, !24, !25, !26, !27}
!llvm.ident = !{!28, !28}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 13.0.1 (https://github.com/llvm/llvm-project.git 75e33f71c2dae584b13a7d1186ae0a038ba98838)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !16, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "test_get_greater_than_absent_key_fails.c", directory: "/home/klee/work/ex3/Ex3SymbTestSuite")
!2 = !{!3}
!3 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "cc_stat", file: !4, line: 29, baseType: !5, size: 32, elements: !6)
!4 = !DIFile(filename: "./../../ex2/common.h", directory: "/home/klee/work/ex3/Ex3SymbTestSuite")
!5 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!6 = !{!7, !8, !9, !10, !11, !12, !13, !14, !15}
!7 = !DIEnumerator(name: "CC_OK", value: 0)
!8 = !DIEnumerator(name: "CC_ERR_ALLOC", value: 1)
!9 = !DIEnumerator(name: "CC_ERR_INVALID_CAPACITY", value: 2)
!10 = !DIEnumerator(name: "CC_ERR_INVALID_RANGE", value: 3)
!11 = !DIEnumerator(name: "CC_ERR_MAX_CAPACITY", value: 4)
!12 = !DIEnumerator(name: "CC_ERR_KEY_NOT_FOUND", value: 6)
!13 = !DIEnumerator(name: "CC_ERR_VALUE_NOT_FOUND", value: 7)
!14 = !DIEnumerator(name: "CC_ERR_OUT_OF_RANGE", value: 8)
!15 = !DIEnumerator(name: "CC_ITER_END", value: 9)
!16 = !{!17, !19}
!17 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !18, size: 64)
!18 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!19 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!20 = distinct !DICompileUnit(language: DW_LANG_C99, file: !21, producer: "clang version 13.0.1 (https://github.com/llvm/llvm-project.git 75e33f71c2dae584b13a7d1186ae0a038ba98838)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !22, splitDebugInlining: false, nameTableKind: None)
!21 = !DIFile(filename: "/tmp/klee_src/runtime/Freestanding/memcpy.c", directory: "/tmp/klee_build130stp_z3/runtime/Freestanding")
!22 = !{}
!23 = !{i32 7, !"Dwarf Version", i32 4}
!24 = !{i32 2, !"Debug Info Version", i32 3}
!25 = !{i32 1, !"wchar_size", i32 4}
!26 = !{i32 7, !"uwtable", i32 1}
!27 = !{i32 7, !"frame-pointer", i32 2}
!28 = !{!"clang version 13.0.1 (https://github.com/llvm/llvm-project.git 75e33f71c2dae584b13a7d1186ae0a038ba98838)"}
!29 = distinct !DISubprogram(name: "cmp", scope: !30, file: !30, line: 53, type: !31, scopeLine: 53, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !22)
!30 = !DIFile(filename: "./../../ex2/treetable.c", directory: "/home/klee/work/ex3/Ex3SymbTestSuite")
!31 = !DISubroutineType(types: !32)
!32 = !{!18, !33, !33}
!33 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !34, size: 64)
!34 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!35 = !DILocalVariable(name: "e1", arg: 1, scope: !29, file: !30, line: 53, type: !33)
!36 = !DILocation(line: 53, column: 21, scope: !29)
!37 = !DILocalVariable(name: "e2", arg: 2, scope: !29, file: !30, line: 53, type: !33)
!38 = !DILocation(line: 53, column: 37, scope: !29)
!39 = !DILocalVariable(name: "i", scope: !29, file: !30, line: 54, type: !18)
!40 = !DILocation(line: 54, column: 9, scope: !29)
!41 = !DILocation(line: 54, column: 22, scope: !29)
!42 = !DILocation(line: 54, column: 15, scope: !29)
!43 = !DILocation(line: 54, column: 13, scope: !29)
!44 = !DILocalVariable(name: "j", scope: !29, file: !30, line: 55, type: !18)
!45 = !DILocation(line: 55, column: 9, scope: !29)
!46 = !DILocation(line: 55, column: 22, scope: !29)
!47 = !DILocation(line: 55, column: 15, scope: !29)
!48 = !DILocation(line: 55, column: 13, scope: !29)
!49 = !DILocation(line: 57, column: 9, scope: !50)
!50 = distinct !DILexicalBlock(scope: !29, file: !30, line: 57, column: 9)
!51 = !DILocation(line: 57, column: 13, scope: !50)
!52 = !DILocation(line: 57, column: 11, scope: !50)
!53 = !DILocation(line: 57, column: 9, scope: !29)
!54 = !DILocation(line: 58, column: 9, scope: !50)
!55 = !DILocation(line: 59, column: 9, scope: !56)
!56 = distinct !DILexicalBlock(scope: !29, file: !30, line: 59, column: 9)
!57 = !DILocation(line: 59, column: 14, scope: !56)
!58 = !DILocation(line: 59, column: 11, scope: !56)
!59 = !DILocation(line: 59, column: 9, scope: !29)
!60 = !DILocation(line: 60, column: 9, scope: !56)
!61 = !DILocation(line: 61, column: 5, scope: !29)
!62 = !DILocation(line: 62, column: 1, scope: !29)
!63 = distinct !DISubprogram(name: "treetable_conf_init", scope: !30, file: !30, line: 70, type: !64, scopeLine: 71, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !22)
!64 = !DISubroutineType(types: !65)
!65 = !{null, !66}
!66 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !67, size: 64)
!67 = !DIDerivedType(tag: DW_TAG_typedef, name: "TreeTableConf", file: !68, line: 94, baseType: !69)
!68 = !DIFile(filename: "./../../ex2/treetable.h", directory: "/home/klee/work/ex3/Ex3SymbTestSuite")
!69 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "treetable_conf_s", file: !68, line: 89, size: 256, elements: !70)
!70 = !{!71, !73, !80, !84}
!71 = !DIDerivedType(tag: DW_TAG_member, name: "cmp", scope: !69, file: !68, line: 90, baseType: !72, size: 64)
!72 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !31, size: 64)
!73 = !DIDerivedType(tag: DW_TAG_member, name: "mem_alloc", scope: !69, file: !68, line: 91, baseType: !74, size: 64, offset: 64)
!74 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !75, size: 64)
!75 = !DISubroutineType(types: !76)
!76 = !{!19, !77}
!77 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !78, line: 46, baseType: !79)
!78 = !DIFile(filename: "/tmp/llvm-130-install_O_D_A/lib/clang/13.0.1/include/stddef.h", directory: "")
!79 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!80 = !DIDerivedType(tag: DW_TAG_member, name: "mem_calloc", scope: !69, file: !68, line: 92, baseType: !81, size: 64, offset: 128)
!81 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !82, size: 64)
!82 = !DISubroutineType(types: !83)
!83 = !{!19, !77, !77}
!84 = !DIDerivedType(tag: DW_TAG_member, name: "mem_free", scope: !69, file: !68, line: 93, baseType: !85, size: 64, offset: 192)
!85 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !86, size: 64)
!86 = !DISubroutineType(types: !87)
!87 = !{null, !19}
!88 = !DILocalVariable(name: "conf", arg: 1, scope: !63, file: !30, line: 70, type: !66)
!89 = !DILocation(line: 70, column: 41, scope: !63)
!90 = !DILocation(line: 72, column: 5, scope: !63)
!91 = !DILocation(line: 72, column: 11, scope: !63)
!92 = !DILocation(line: 72, column: 22, scope: !63)
!93 = !DILocation(line: 73, column: 5, scope: !63)
!94 = !DILocation(line: 73, column: 11, scope: !63)
!95 = !DILocation(line: 73, column: 22, scope: !63)
!96 = !DILocation(line: 74, column: 5, scope: !63)
!97 = !DILocation(line: 74, column: 11, scope: !63)
!98 = !DILocation(line: 74, column: 22, scope: !63)
!99 = !DILocation(line: 75, column: 5, scope: !63)
!100 = !DILocation(line: 75, column: 11, scope: !63)
!101 = !DILocation(line: 75, column: 22, scope: !63)
!102 = !DILocation(line: 76, column: 1, scope: !63)
!103 = distinct !DISubprogram(name: "treetable_new", scope: !30, file: !30, line: 87, type: !104, scopeLine: 88, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !22)
!104 = !DISubroutineType(types: !105)
!105 = !{!3, !106}
!106 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !107, size: 64)
!107 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !108, size: 64)
!108 = !DIDerivedType(tag: DW_TAG_typedef, name: "TreeTable", file: !68, line: 30, baseType: !109)
!109 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "treetable_s", file: !30, line: 30, size: 448, elements: !110)
!110 = !{!111, !124, !125, !126, !127, !128, !129}
!111 = !DIDerivedType(tag: DW_TAG_member, name: "root", scope: !109, file: !30, line: 31, baseType: !112, size: 64)
!112 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !113, size: 64)
!113 = !DIDerivedType(tag: DW_TAG_typedef, name: "RBNode", file: !68, line: 61, baseType: !114)
!114 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "rbnode_s", file: !68, line: 37, size: 384, elements: !115)
!115 = !{!116, !117, !118, !120, !122, !123}
!116 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !114, file: !68, line: 40, baseType: !19, size: 64)
!117 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !114, file: !68, line: 44, baseType: !19, size: 64, offset: 64)
!118 = !DIDerivedType(tag: DW_TAG_member, name: "color", scope: !114, file: !68, line: 48, baseType: !119, size: 8, offset: 128)
!119 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!120 = !DIDerivedType(tag: DW_TAG_member, name: "parent", scope: !114, file: !68, line: 52, baseType: !121, size: 64, offset: 192)
!121 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !114, size: 64)
!122 = !DIDerivedType(tag: DW_TAG_member, name: "left", scope: !114, file: !68, line: 56, baseType: !121, size: 64, offset: 256)
!123 = !DIDerivedType(tag: DW_TAG_member, name: "right", scope: !114, file: !68, line: 60, baseType: !121, size: 64, offset: 320)
!124 = !DIDerivedType(tag: DW_TAG_member, name: "sentinel", scope: !109, file: !30, line: 32, baseType: !112, size: 64, offset: 64)
!125 = !DIDerivedType(tag: DW_TAG_member, name: "size", scope: !109, file: !30, line: 33, baseType: !77, size: 64, offset: 128)
!126 = !DIDerivedType(tag: DW_TAG_member, name: "cmp", scope: !109, file: !30, line: 35, baseType: !72, size: 64, offset: 192)
!127 = !DIDerivedType(tag: DW_TAG_member, name: "mem_alloc", scope: !109, file: !30, line: 36, baseType: !74, size: 64, offset: 256)
!128 = !DIDerivedType(tag: DW_TAG_member, name: "mem_calloc", scope: !109, file: !30, line: 37, baseType: !81, size: 64, offset: 320)
!129 = !DIDerivedType(tag: DW_TAG_member, name: "mem_free", scope: !109, file: !30, line: 38, baseType: !85, size: 64, offset: 384)
!130 = !DILocalVariable(name: "tt", arg: 1, scope: !103, file: !30, line: 87, type: !106)
!131 = !DILocation(line: 87, column: 40, scope: !103)
!132 = !DILocalVariable(name: "conf", scope: !103, file: !30, line: 89, type: !67)
!133 = !DILocation(line: 89, column: 19, scope: !103)
!134 = !DILocation(line: 90, column: 5, scope: !103)
!135 = !DILocation(line: 91, column: 38, scope: !103)
!136 = !DILocation(line: 91, column: 12, scope: !103)
!137 = !DILocation(line: 91, column: 5, scope: !103)
!138 = distinct !DISubprogram(name: "treetable_new_conf", scope: !30, file: !30, line: 107, type: !139, scopeLine: 108, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !22)
!139 = !DISubroutineType(types: !140)
!140 = !{!3, !141, !106}
!141 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !142)
!142 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !143, size: 64)
!143 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !67)
!144 = !DILocalVariable(name: "conf", arg: 1, scope: !138, file: !30, line: 107, type: !141)
!145 = !DILocation(line: 107, column: 61, scope: !138)
!146 = !DILocalVariable(name: "tt", arg: 2, scope: !138, file: !30, line: 107, type: !106)
!147 = !DILocation(line: 107, column: 79, scope: !138)
!148 = !DILocalVariable(name: "table", scope: !138, file: !30, line: 109, type: !107)
!149 = !DILocation(line: 109, column: 16, scope: !138)
!150 = !DILocation(line: 109, column: 24, scope: !138)
!151 = !DILocation(line: 109, column: 30, scope: !138)
!152 = !DILocation(line: 111, column: 10, scope: !153)
!153 = distinct !DILexicalBlock(scope: !138, file: !30, line: 111, column: 9)
!154 = !DILocation(line: 111, column: 9, scope: !138)
!155 = !DILocation(line: 112, column: 9, scope: !153)
!156 = !DILocalVariable(name: "sentinel", scope: !138, file: !30, line: 114, type: !112)
!157 = !DILocation(line: 114, column: 13, scope: !138)
!158 = !DILocation(line: 114, column: 24, scope: !138)
!159 = !DILocation(line: 114, column: 30, scope: !138)
!160 = !DILocation(line: 116, column: 10, scope: !161)
!161 = distinct !DILexicalBlock(scope: !138, file: !30, line: 116, column: 9)
!162 = !DILocation(line: 116, column: 9, scope: !138)
!163 = !DILocation(line: 117, column: 9, scope: !164)
!164 = distinct !DILexicalBlock(scope: !161, file: !30, line: 116, column: 20)
!165 = !DILocation(line: 117, column: 15, scope: !164)
!166 = !DILocation(line: 117, column: 24, scope: !164)
!167 = !DILocation(line: 118, column: 9, scope: !164)
!168 = !DILocation(line: 121, column: 5, scope: !138)
!169 = !DILocation(line: 121, column: 15, scope: !138)
!170 = !DILocation(line: 121, column: 23, scope: !138)
!171 = !DILocation(line: 123, column: 5, scope: !138)
!172 = !DILocation(line: 123, column: 12, scope: !138)
!173 = !DILocation(line: 123, column: 23, scope: !138)
!174 = !DILocation(line: 124, column: 25, scope: !138)
!175 = !DILocation(line: 124, column: 31, scope: !138)
!176 = !DILocation(line: 124, column: 5, scope: !138)
!177 = !DILocation(line: 124, column: 12, scope: !138)
!178 = !DILocation(line: 124, column: 23, scope: !138)
!179 = !DILocation(line: 125, column: 25, scope: !138)
!180 = !DILocation(line: 125, column: 31, scope: !138)
!181 = !DILocation(line: 125, column: 5, scope: !138)
!182 = !DILocation(line: 125, column: 12, scope: !138)
!183 = !DILocation(line: 125, column: 23, scope: !138)
!184 = !DILocation(line: 126, column: 25, scope: !138)
!185 = !DILocation(line: 126, column: 31, scope: !138)
!186 = !DILocation(line: 126, column: 5, scope: !138)
!187 = !DILocation(line: 126, column: 12, scope: !138)
!188 = !DILocation(line: 126, column: 23, scope: !138)
!189 = !DILocation(line: 127, column: 25, scope: !138)
!190 = !DILocation(line: 127, column: 31, scope: !138)
!191 = !DILocation(line: 127, column: 5, scope: !138)
!192 = !DILocation(line: 127, column: 12, scope: !138)
!193 = !DILocation(line: 127, column: 23, scope: !138)
!194 = !DILocation(line: 128, column: 25, scope: !138)
!195 = !DILocation(line: 128, column: 5, scope: !138)
!196 = !DILocation(line: 128, column: 12, scope: !138)
!197 = !DILocation(line: 128, column: 23, scope: !138)
!198 = !DILocation(line: 129, column: 25, scope: !138)
!199 = !DILocation(line: 129, column: 5, scope: !138)
!200 = !DILocation(line: 129, column: 12, scope: !138)
!201 = !DILocation(line: 129, column: 23, scope: !138)
!202 = !DILocation(line: 131, column: 11, scope: !138)
!203 = !DILocation(line: 131, column: 6, scope: !138)
!204 = !DILocation(line: 131, column: 9, scope: !138)
!205 = !DILocation(line: 132, column: 5, scope: !138)
!206 = !DILocation(line: 133, column: 1, scope: !138)
!207 = distinct !DISubprogram(name: "treetable_destroy", scope: !30, file: !30, line: 159, type: !208, scopeLine: 160, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !22)
!208 = !DISubroutineType(types: !209)
!209 = !{null, !107}
!210 = !DILocalVariable(name: "table", arg: 1, scope: !207, file: !30, line: 159, type: !107)
!211 = !DILocation(line: 159, column: 35, scope: !207)
!212 = !DILocation(line: 161, column: 18, scope: !207)
!213 = !DILocation(line: 161, column: 25, scope: !207)
!214 = !DILocation(line: 161, column: 32, scope: !207)
!215 = !DILocation(line: 161, column: 5, scope: !207)
!216 = !DILocation(line: 163, column: 5, scope: !207)
!217 = !DILocation(line: 163, column: 12, scope: !207)
!218 = !DILocation(line: 163, column: 21, scope: !207)
!219 = !DILocation(line: 163, column: 28, scope: !207)
!220 = !DILocation(line: 164, column: 5, scope: !207)
!221 = !DILocation(line: 164, column: 12, scope: !207)
!222 = !DILocation(line: 164, column: 21, scope: !207)
!223 = !DILocation(line: 165, column: 1, scope: !207)
!224 = distinct !DISubprogram(name: "tree_destroy", scope: !30, file: !30, line: 141, type: !225, scopeLine: 142, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !22)
!225 = !DISubroutineType(types: !226)
!226 = !{null, !107, !112}
!227 = !DILocalVariable(name: "table", arg: 1, scope: !224, file: !30, line: 141, type: !107)
!228 = !DILocation(line: 141, column: 37, scope: !224)
!229 = !DILocalVariable(name: "n", arg: 2, scope: !224, file: !30, line: 141, type: !112)
!230 = !DILocation(line: 141, column: 52, scope: !224)
!231 = !DILocation(line: 143, column: 9, scope: !232)
!232 = distinct !DILexicalBlock(scope: !224, file: !30, line: 143, column: 9)
!233 = !DILocation(line: 143, column: 14, scope: !232)
!234 = !DILocation(line: 143, column: 21, scope: !232)
!235 = !DILocation(line: 143, column: 11, scope: !232)
!236 = !DILocation(line: 143, column: 9, scope: !224)
!237 = !DILocation(line: 146, column: 18, scope: !224)
!238 = !DILocation(line: 146, column: 25, scope: !224)
!239 = !DILocation(line: 146, column: 28, scope: !224)
!240 = !DILocation(line: 146, column: 5, scope: !224)
!241 = !DILocation(line: 147, column: 18, scope: !224)
!242 = !DILocation(line: 147, column: 25, scope: !224)
!243 = !DILocation(line: 147, column: 28, scope: !224)
!244 = !DILocation(line: 147, column: 5, scope: !224)
!245 = !DILocation(line: 149, column: 5, scope: !224)
!246 = !DILocation(line: 149, column: 12, scope: !224)
!247 = !DILocation(line: 149, column: 21, scope: !224)
!248 = !DILocation(line: 150, column: 1, scope: !224)
!249 = distinct !DISubprogram(name: "treetable_get", scope: !30, file: !30, line: 177, type: !250, scopeLine: 178, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !22)
!250 = !DISubroutineType(types: !251)
!251 = !{!3, !252, !33, !255}
!252 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !253)
!253 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !254, size: 64)
!254 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !108)
!255 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !19, size: 64)
!256 = !DILocalVariable(name: "table", arg: 1, scope: !249, file: !30, line: 177, type: !252)
!257 = !DILocation(line: 177, column: 52, scope: !249)
!258 = !DILocalVariable(name: "key", arg: 2, scope: !249, file: !30, line: 177, type: !33)
!259 = !DILocation(line: 177, column: 71, scope: !249)
!260 = !DILocalVariable(name: "out", arg: 3, scope: !249, file: !30, line: 177, type: !255)
!261 = !DILocation(line: 177, column: 83, scope: !249)
!262 = !DILocalVariable(name: "node", scope: !249, file: !30, line: 179, type: !112)
!263 = !DILocation(line: 179, column: 13, scope: !249)
!264 = !DILocation(line: 179, column: 41, scope: !249)
!265 = !DILocation(line: 179, column: 48, scope: !249)
!266 = !DILocation(line: 179, column: 20, scope: !249)
!267 = !DILocation(line: 181, column: 10, scope: !268)
!268 = distinct !DILexicalBlock(scope: !249, file: !30, line: 181, column: 9)
!269 = !DILocation(line: 181, column: 9, scope: !249)
!270 = !DILocation(line: 182, column: 9, scope: !268)
!271 = !DILocation(line: 184, column: 12, scope: !249)
!272 = !DILocation(line: 184, column: 18, scope: !249)
!273 = !DILocation(line: 184, column: 6, scope: !249)
!274 = !DILocation(line: 184, column: 10, scope: !249)
!275 = !DILocation(line: 185, column: 5, scope: !249)
!276 = !DILocation(line: 186, column: 1, scope: !249)
!277 = distinct !DISubprogram(name: "get_tree_node_by_key", scope: !30, file: !30, line: 577, type: !278, scopeLine: 578, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !22)
!278 = !DISubroutineType(types: !279)
!279 = !{!112, !252, !33}
!280 = !DILocalVariable(name: "table", arg: 1, scope: !277, file: !30, line: 577, type: !252)
!281 = !DILocation(line: 577, column: 61, scope: !277)
!282 = !DILocalVariable(name: "key", arg: 2, scope: !277, file: !30, line: 577, type: !33)
!283 = !DILocation(line: 577, column: 80, scope: !277)
!284 = !DILocation(line: 579, column: 9, scope: !285)
!285 = distinct !DILexicalBlock(scope: !277, file: !30, line: 579, column: 9)
!286 = !DILocation(line: 579, column: 16, scope: !285)
!287 = !DILocation(line: 579, column: 21, scope: !285)
!288 = !DILocation(line: 579, column: 9, scope: !277)
!289 = !DILocation(line: 580, column: 9, scope: !285)
!290 = !DILocalVariable(name: "n", scope: !277, file: !30, line: 582, type: !112)
!291 = !DILocation(line: 582, column: 13, scope: !277)
!292 = !DILocation(line: 582, column: 17, scope: !277)
!293 = !DILocation(line: 582, column: 24, scope: !277)
!294 = !DILocalVariable(name: "s", scope: !277, file: !30, line: 583, type: !112)
!295 = !DILocation(line: 583, column: 13, scope: !277)
!296 = !DILocation(line: 583, column: 17, scope: !277)
!297 = !DILocation(line: 583, column: 24, scope: !277)
!298 = !DILocalVariable(name: "cmp", scope: !277, file: !30, line: 585, type: !18)
!299 = !DILocation(line: 585, column: 9, scope: !277)
!300 = !DILocation(line: 586, column: 5, scope: !277)
!301 = !DILocation(line: 587, column: 15, scope: !302)
!302 = distinct !DILexicalBlock(scope: !277, file: !30, line: 586, column: 8)
!303 = !DILocation(line: 587, column: 22, scope: !302)
!304 = !DILocation(line: 587, column: 26, scope: !302)
!305 = !DILocation(line: 587, column: 31, scope: !302)
!306 = !DILocation(line: 587, column: 34, scope: !302)
!307 = !DILocation(line: 587, column: 13, scope: !302)
!308 = !DILocation(line: 589, column: 13, scope: !309)
!309 = distinct !DILexicalBlock(scope: !302, file: !30, line: 589, column: 13)
!310 = !DILocation(line: 589, column: 17, scope: !309)
!311 = !DILocation(line: 589, column: 13, scope: !302)
!312 = !DILocation(line: 590, column: 17, scope: !309)
!313 = !DILocation(line: 590, column: 20, scope: !309)
!314 = !DILocation(line: 590, column: 15, scope: !309)
!315 = !DILocation(line: 590, column: 13, scope: !309)
!316 = !DILocation(line: 591, column: 18, scope: !317)
!317 = distinct !DILexicalBlock(scope: !309, file: !30, line: 591, column: 18)
!318 = !DILocation(line: 591, column: 22, scope: !317)
!319 = !DILocation(line: 591, column: 18, scope: !309)
!320 = !DILocation(line: 592, column: 17, scope: !317)
!321 = !DILocation(line: 592, column: 20, scope: !317)
!322 = !DILocation(line: 592, column: 15, scope: !317)
!323 = !DILocation(line: 594, column: 20, scope: !317)
!324 = !DILocation(line: 594, column: 13, scope: !317)
!325 = !DILocation(line: 595, column: 14, scope: !277)
!326 = !DILocation(line: 595, column: 19, scope: !277)
!327 = !DILocation(line: 595, column: 16, scope: !277)
!328 = !DILocation(line: 595, column: 21, scope: !277)
!329 = !DILocation(line: 595, column: 5, scope: !302)
!330 = distinct !{!330, !300, !331, !332}
!331 = !DILocation(line: 595, column: 32, scope: !277)
!332 = !{!"llvm.loop.mustprogress"}
!333 = !DILocation(line: 597, column: 5, scope: !277)
!334 = !DILocation(line: 598, column: 1, scope: !277)
!335 = distinct !DISubprogram(name: "treetable_get_first_key", scope: !30, file: !30, line: 198, type: !336, scopeLine: 199, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !22)
!336 = !DISubroutineType(types: !337)
!337 = !{!3, !252, !255}
!338 = !DILocalVariable(name: "table", arg: 1, scope: !335, file: !30, line: 198, type: !252)
!339 = !DILocation(line: 198, column: 62, scope: !335)
!340 = !DILocalVariable(name: "out", arg: 2, scope: !335, file: !30, line: 198, type: !255)
!341 = !DILocation(line: 198, column: 76, scope: !335)
!342 = !DILocalVariable(name: "node", scope: !335, file: !30, line: 200, type: !112)
!343 = !DILocation(line: 200, column: 13, scope: !335)
!344 = !DILocation(line: 200, column: 29, scope: !335)
!345 = !DILocation(line: 200, column: 36, scope: !335)
!346 = !DILocation(line: 200, column: 43, scope: !335)
!347 = !DILocation(line: 200, column: 20, scope: !335)
!348 = !DILocation(line: 202, column: 9, scope: !349)
!349 = distinct !DILexicalBlock(scope: !335, file: !30, line: 202, column: 9)
!350 = !DILocation(line: 202, column: 17, scope: !349)
!351 = !DILocation(line: 202, column: 24, scope: !349)
!352 = !DILocation(line: 202, column: 14, scope: !349)
!353 = !DILocation(line: 202, column: 9, scope: !335)
!354 = !DILocation(line: 203, column: 16, scope: !355)
!355 = distinct !DILexicalBlock(scope: !349, file: !30, line: 202, column: 34)
!356 = !DILocation(line: 203, column: 22, scope: !355)
!357 = !DILocation(line: 203, column: 10, scope: !355)
!358 = !DILocation(line: 203, column: 14, scope: !355)
!359 = !DILocation(line: 204, column: 9, scope: !355)
!360 = !DILocation(line: 206, column: 5, scope: !335)
!361 = !DILocation(line: 207, column: 1, scope: !335)
!362 = distinct !DISubprogram(name: "tree_min", scope: !30, file: !30, line: 493, type: !363, scopeLine: 494, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !22)
!363 = !DISubroutineType(types: !364)
!364 = !{!112, !252, !112}
!365 = !DILocalVariable(name: "table", arg: 1, scope: !362, file: !30, line: 493, type: !252)
!366 = !DILocation(line: 493, column: 56, scope: !362)
!367 = !DILocalVariable(name: "n", arg: 2, scope: !362, file: !30, line: 493, type: !112)
!368 = !DILocation(line: 493, column: 71, scope: !362)
!369 = !DILocalVariable(name: "s", scope: !362, file: !30, line: 495, type: !112)
!370 = !DILocation(line: 495, column: 13, scope: !362)
!371 = !DILocation(line: 495, column: 17, scope: !362)
!372 = !DILocation(line: 495, column: 24, scope: !362)
!373 = !DILocation(line: 497, column: 5, scope: !362)
!374 = !DILocation(line: 497, column: 12, scope: !362)
!375 = !DILocation(line: 497, column: 15, scope: !362)
!376 = !DILocation(line: 497, column: 23, scope: !362)
!377 = !DILocation(line: 497, column: 20, scope: !362)
!378 = !DILocation(line: 498, column: 13, scope: !362)
!379 = !DILocation(line: 498, column: 16, scope: !362)
!380 = !DILocation(line: 498, column: 11, scope: !362)
!381 = distinct !{!381, !373, !379, !332}
!382 = !DILocation(line: 499, column: 12, scope: !362)
!383 = !DILocation(line: 499, column: 5, scope: !362)
!384 = distinct !DISubprogram(name: "treetable_get_greater_than", scope: !30, file: !30, line: 219, type: !250, scopeLine: 220, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !22)
!385 = !DILocalVariable(name: "table", arg: 1, scope: !384, file: !30, line: 219, type: !252)
!386 = !DILocation(line: 219, column: 65, scope: !384)
!387 = !DILocalVariable(name: "key", arg: 2, scope: !384, file: !30, line: 219, type: !33)
!388 = !DILocation(line: 219, column: 84, scope: !384)
!389 = !DILocalVariable(name: "out", arg: 3, scope: !384, file: !30, line: 219, type: !255)
!390 = !DILocation(line: 219, column: 96, scope: !384)
!391 = !DILocalVariable(name: "n", scope: !384, file: !30, line: 221, type: !112)
!392 = !DILocation(line: 221, column: 13, scope: !384)
!393 = !DILocation(line: 221, column: 38, scope: !384)
!394 = !DILocation(line: 221, column: 45, scope: !384)
!395 = !DILocation(line: 221, column: 17, scope: !384)
!396 = !DILocalVariable(name: "s", scope: !384, file: !30, line: 222, type: !112)
!397 = !DILocation(line: 222, column: 13, scope: !384)
!398 = !DILocation(line: 222, column: 36, scope: !384)
!399 = !DILocation(line: 222, column: 43, scope: !384)
!400 = !DILocation(line: 222, column: 17, scope: !384)
!401 = !DILocation(line: 224, column: 9, scope: !402)
!402 = distinct !DILexicalBlock(scope: !384, file: !30, line: 224, column: 9)
!403 = !DILocation(line: 224, column: 11, scope: !402)
!404 = !DILocation(line: 225, column: 16, scope: !405)
!405 = distinct !DILexicalBlock(scope: !402, file: !30, line: 224, column: 17)
!406 = !DILocation(line: 225, column: 19, scope: !405)
!407 = !DILocation(line: 225, column: 10, scope: !405)
!408 = !DILocation(line: 225, column: 14, scope: !405)
!409 = !DILocation(line: 226, column: 9, scope: !405)
!410 = !DILocation(line: 228, column: 5, scope: !384)
!411 = !DILocation(line: 229, column: 1, scope: !384)
!412 = distinct !DISubprogram(name: "get_successor_node", scope: !30, file: !30, line: 608, type: !363, scopeLine: 609, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !22)
!413 = !DILocalVariable(name: "table", arg: 1, scope: !412, file: !30, line: 608, type: !252)
!414 = !DILocation(line: 608, column: 59, scope: !412)
!415 = !DILocalVariable(name: "x", arg: 2, scope: !412, file: !30, line: 608, type: !112)
!416 = !DILocation(line: 608, column: 74, scope: !412)
!417 = !DILocation(line: 610, column: 9, scope: !418)
!418 = distinct !DILexicalBlock(scope: !412, file: !30, line: 610, column: 9)
!419 = !DILocation(line: 610, column: 11, scope: !418)
!420 = !DILocation(line: 610, column: 9, scope: !412)
!421 = !DILocation(line: 611, column: 9, scope: !418)
!422 = !DILocation(line: 613, column: 9, scope: !423)
!423 = distinct !DILexicalBlock(scope: !412, file: !30, line: 613, column: 9)
!424 = !DILocation(line: 613, column: 12, scope: !423)
!425 = !DILocation(line: 613, column: 21, scope: !423)
!426 = !DILocation(line: 613, column: 28, scope: !423)
!427 = !DILocation(line: 613, column: 18, scope: !423)
!428 = !DILocation(line: 613, column: 9, scope: !412)
!429 = !DILocation(line: 614, column: 25, scope: !423)
!430 = !DILocation(line: 614, column: 32, scope: !423)
!431 = !DILocation(line: 614, column: 35, scope: !423)
!432 = !DILocation(line: 614, column: 16, scope: !423)
!433 = !DILocation(line: 614, column: 9, scope: !423)
!434 = !DILocalVariable(name: "y", scope: !412, file: !30, line: 616, type: !112)
!435 = !DILocation(line: 616, column: 13, scope: !412)
!436 = !DILocation(line: 616, column: 17, scope: !412)
!437 = !DILocation(line: 616, column: 20, scope: !412)
!438 = !DILocation(line: 618, column: 5, scope: !412)
!439 = !DILocation(line: 618, column: 12, scope: !412)
!440 = !DILocation(line: 618, column: 17, scope: !412)
!441 = !DILocation(line: 618, column: 24, scope: !412)
!442 = !DILocation(line: 618, column: 14, scope: !412)
!443 = !DILocation(line: 618, column: 33, scope: !412)
!444 = !DILocation(line: 618, column: 36, scope: !412)
!445 = !DILocation(line: 618, column: 41, scope: !412)
!446 = !DILocation(line: 618, column: 44, scope: !412)
!447 = !DILocation(line: 618, column: 38, scope: !412)
!448 = !DILocation(line: 619, column: 13, scope: !449)
!449 = distinct !DILexicalBlock(scope: !412, file: !30, line: 618, column: 51)
!450 = !DILocation(line: 619, column: 11, scope: !449)
!451 = !DILocation(line: 620, column: 13, scope: !449)
!452 = !DILocation(line: 620, column: 16, scope: !449)
!453 = !DILocation(line: 620, column: 11, scope: !449)
!454 = distinct !{!454, !438, !455, !332}
!455 = !DILocation(line: 621, column: 5, scope: !412)
!456 = !DILocation(line: 622, column: 12, scope: !412)
!457 = !DILocation(line: 622, column: 5, scope: !412)
!458 = !DILocation(line: 623, column: 1, scope: !412)
!459 = distinct !DISubprogram(name: "treetable_size", scope: !30, file: !30, line: 239, type: !460, scopeLine: 240, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !22)
!460 = !DISubroutineType(types: !461)
!461 = !{!77, !252}
!462 = !DILocalVariable(name: "table", arg: 1, scope: !459, file: !30, line: 239, type: !252)
!463 = !DILocation(line: 239, column: 47, scope: !459)
!464 = !DILocation(line: 241, column: 12, scope: !459)
!465 = !DILocation(line: 241, column: 19, scope: !459)
!466 = !DILocation(line: 241, column: 5, scope: !459)
!467 = distinct !DISubprogram(name: "treetable_contains_key", scope: !30, file: !30, line: 252, type: !468, scopeLine: 253, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !22)
!468 = !DISubroutineType(types: !469)
!469 = !{!470, !252, !33}
!470 = !DIBasicType(name: "_Bool", size: 8, encoding: DW_ATE_boolean)
!471 = !DILocalVariable(name: "table", arg: 1, scope: !467, file: !30, line: 252, type: !252)
!472 = !DILocation(line: 252, column: 53, scope: !467)
!473 = !DILocalVariable(name: "key", arg: 2, scope: !467, file: !30, line: 252, type: !33)
!474 = !DILocation(line: 252, column: 72, scope: !467)
!475 = !DILocalVariable(name: "node", scope: !467, file: !30, line: 254, type: !112)
!476 = !DILocation(line: 254, column: 13, scope: !467)
!477 = !DILocation(line: 254, column: 41, scope: !467)
!478 = !DILocation(line: 254, column: 48, scope: !467)
!479 = !DILocation(line: 254, column: 20, scope: !467)
!480 = !DILocation(line: 256, column: 9, scope: !481)
!481 = distinct !DILexicalBlock(scope: !467, file: !30, line: 256, column: 9)
!482 = !DILocation(line: 256, column: 9, scope: !467)
!483 = !DILocation(line: 257, column: 9, scope: !481)
!484 = !DILocation(line: 259, column: 5, scope: !467)
!485 = !DILocation(line: 260, column: 1, scope: !467)
!486 = distinct !DISubprogram(name: "treetable_contains_value", scope: !30, file: !30, line: 270, type: !487, scopeLine: 271, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !22)
!487 = !DISubroutineType(types: !488)
!488 = !{!77, !252, !33}
!489 = !DILocalVariable(name: "table", arg: 1, scope: !486, file: !30, line: 270, type: !252)
!490 = !DILocation(line: 270, column: 57, scope: !486)
!491 = !DILocalVariable(name: "value", arg: 2, scope: !486, file: !30, line: 270, type: !33)
!492 = !DILocation(line: 270, column: 76, scope: !486)
!493 = !DILocalVariable(name: "node", scope: !486, file: !30, line: 272, type: !112)
!494 = !DILocation(line: 272, column: 13, scope: !486)
!495 = !DILocation(line: 272, column: 29, scope: !486)
!496 = !DILocation(line: 272, column: 36, scope: !486)
!497 = !DILocation(line: 272, column: 43, scope: !486)
!498 = !DILocation(line: 272, column: 20, scope: !486)
!499 = !DILocalVariable(name: "o", scope: !486, file: !30, line: 274, type: !77)
!500 = !DILocation(line: 274, column: 12, scope: !486)
!501 = !DILocation(line: 275, column: 5, scope: !486)
!502 = !DILocation(line: 275, column: 12, scope: !486)
!503 = !DILocation(line: 275, column: 20, scope: !486)
!504 = !DILocation(line: 275, column: 27, scope: !486)
!505 = !DILocation(line: 275, column: 17, scope: !486)
!506 = !DILocation(line: 276, column: 13, scope: !507)
!507 = distinct !DILexicalBlock(scope: !508, file: !30, line: 276, column: 13)
!508 = distinct !DILexicalBlock(scope: !486, file: !30, line: 275, column: 37)
!509 = !DILocation(line: 276, column: 19, scope: !507)
!510 = !DILocation(line: 276, column: 28, scope: !507)
!511 = !DILocation(line: 276, column: 25, scope: !507)
!512 = !DILocation(line: 276, column: 13, scope: !508)
!513 = !DILocation(line: 277, column: 14, scope: !507)
!514 = !DILocation(line: 277, column: 13, scope: !507)
!515 = !DILocation(line: 278, column: 35, scope: !508)
!516 = !DILocation(line: 278, column: 42, scope: !508)
!517 = !DILocation(line: 278, column: 16, scope: !508)
!518 = !DILocation(line: 278, column: 14, scope: !508)
!519 = distinct !{!519, !501, !520, !332}
!520 = !DILocation(line: 279, column: 5, scope: !486)
!521 = !DILocation(line: 280, column: 12, scope: !486)
!522 = !DILocation(line: 280, column: 5, scope: !486)
!523 = distinct !DISubprogram(name: "balanced", scope: !30, file: !30, line: 283, type: !524, scopeLine: 284, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !22)
!524 = !DISubroutineType(types: !525)
!525 = !{!18, !107}
!526 = !DILocalVariable(name: "t", arg: 1, scope: !523, file: !30, line: 283, type: !107)
!527 = !DILocation(line: 283, column: 25, scope: !523)
!528 = !DILocation(line: 285, column: 10, scope: !529)
!529 = distinct !DILexicalBlock(scope: !523, file: !30, line: 285, column: 9)
!530 = !DILocation(line: 285, column: 9, scope: !523)
!531 = !DILocation(line: 286, column: 9, scope: !529)
!532 = !DILocation(line: 288, column: 9, scope: !533)
!533 = distinct !DILexicalBlock(scope: !523, file: !30, line: 288, column: 9)
!534 = !DILocation(line: 288, column: 12, scope: !533)
!535 = !DILocation(line: 288, column: 20, scope: !533)
!536 = !DILocation(line: 288, column: 23, scope: !533)
!537 = !DILocation(line: 288, column: 17, scope: !533)
!538 = !DILocation(line: 288, column: 9, scope: !523)
!539 = !DILocation(line: 289, column: 9, scope: !533)
!540 = !DILocalVariable(name: "stack", scope: !523, file: !30, line: 302, type: !541)
!541 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !542, size: 64)
!542 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "frame", scope: !523, file: !30, line: 291, size: 192, elements: !543)
!543 = !{!544, !545, !546, !547}
!544 = !DIDerivedType(tag: DW_TAG_member, name: "node", scope: !542, file: !30, line: 292, baseType: !112, size: 64)
!545 = !DIDerivedType(tag: DW_TAG_member, name: "state", scope: !542, file: !30, line: 297, baseType: !18, size: 32, offset: 64)
!546 = !DIDerivedType(tag: DW_TAG_member, name: "left_height", scope: !542, file: !30, line: 298, baseType: !18, size: 32, offset: 96)
!547 = !DIDerivedType(tag: DW_TAG_member, name: "right_height", scope: !542, file: !30, line: 299, baseType: !18, size: 32, offset: 128)
!548 = !DILocation(line: 302, column: 19, scope: !523)
!549 = !DILocation(line: 302, column: 27, scope: !523)
!550 = !DILocation(line: 302, column: 30, scope: !523)
!551 = !DILocation(line: 302, column: 40, scope: !523)
!552 = !DILocation(line: 302, column: 43, scope: !523)
!553 = !DILocation(line: 302, column: 48, scope: !523)
!554 = !DILocation(line: 303, column: 10, scope: !555)
!555 = distinct !DILexicalBlock(scope: !523, file: !30, line: 303, column: 9)
!556 = !DILocation(line: 303, column: 9, scope: !523)
!557 = !DILocation(line: 304, column: 9, scope: !555)
!558 = !DILocalVariable(name: "top", scope: !523, file: !30, line: 306, type: !77)
!559 = !DILocation(line: 306, column: 12, scope: !523)
!560 = !DILocalVariable(name: "ok", scope: !523, file: !30, line: 307, type: !18)
!561 = !DILocation(line: 307, column: 9, scope: !523)
!562 = !DILocation(line: 309, column: 5, scope: !523)
!563 = !DILocation(line: 309, column: 14, scope: !523)
!564 = !DILocation(line: 309, column: 35, scope: !523)
!565 = !DILocation(line: 309, column: 37, scope: !523)
!566 = !DILocation(line: 309, column: 40, scope: !523)
!567 = !DILocation(line: 309, column: 20, scope: !523)
!568 = !DILocation(line: 311, column: 5, scope: !523)
!569 = !DILocation(line: 311, column: 12, scope: !523)
!570 = !DILocation(line: 311, column: 16, scope: !523)
!571 = !DILocation(line: 311, column: 20, scope: !523)
!572 = !DILocalVariable(name: "current", scope: !573, file: !30, line: 312, type: !541)
!573 = distinct !DILexicalBlock(scope: !523, file: !30, line: 311, column: 27)
!574 = !DILocation(line: 312, column: 23, scope: !573)
!575 = !DILocation(line: 312, column: 34, scope: !573)
!576 = !DILocation(line: 312, column: 40, scope: !573)
!577 = !DILocation(line: 312, column: 44, scope: !573)
!578 = !DILocation(line: 314, column: 13, scope: !579)
!579 = distinct !DILexicalBlock(scope: !573, file: !30, line: 314, column: 13)
!580 = !DILocation(line: 314, column: 22, scope: !579)
!581 = !DILocation(line: 314, column: 28, scope: !579)
!582 = !DILocation(line: 314, column: 13, scope: !573)
!583 = !DILocation(line: 315, column: 13, scope: !584)
!584 = distinct !DILexicalBlock(scope: !579, file: !30, line: 314, column: 34)
!585 = !DILocation(line: 315, column: 22, scope: !584)
!586 = !DILocation(line: 315, column: 28, scope: !584)
!587 = !DILocation(line: 316, column: 17, scope: !588)
!588 = distinct !DILexicalBlock(scope: !584, file: !30, line: 316, column: 17)
!589 = !DILocation(line: 316, column: 26, scope: !588)
!590 = !DILocation(line: 316, column: 32, scope: !588)
!591 = !DILocation(line: 316, column: 40, scope: !588)
!592 = !DILocation(line: 316, column: 43, scope: !588)
!593 = !DILocation(line: 316, column: 37, scope: !588)
!594 = !DILocation(line: 316, column: 17, scope: !584)
!595 = !DILocation(line: 317, column: 17, scope: !588)
!596 = !DILocation(line: 317, column: 26, scope: !588)
!597 = !DILocation(line: 317, column: 47, scope: !588)
!598 = !DILocation(line: 317, column: 49, scope: !588)
!599 = !DILocation(line: 317, column: 58, scope: !588)
!600 = !DILocation(line: 317, column: 64, scope: !588)
!601 = !DILocation(line: 317, column: 32, scope: !588)
!602 = !DILocation(line: 318, column: 20, scope: !603)
!603 = distinct !DILexicalBlock(scope: !579, file: !30, line: 318, column: 20)
!604 = !DILocation(line: 318, column: 29, scope: !603)
!605 = !DILocation(line: 318, column: 35, scope: !603)
!606 = !DILocation(line: 318, column: 20, scope: !579)
!607 = !DILocation(line: 319, column: 13, scope: !608)
!608 = distinct !DILexicalBlock(scope: !603, file: !30, line: 318, column: 41)
!609 = !DILocation(line: 319, column: 22, scope: !608)
!610 = !DILocation(line: 319, column: 28, scope: !608)
!611 = !DILocation(line: 320, column: 17, scope: !612)
!612 = distinct !DILexicalBlock(scope: !608, file: !30, line: 320, column: 17)
!613 = !DILocation(line: 320, column: 26, scope: !612)
!614 = !DILocation(line: 320, column: 32, scope: !612)
!615 = !DILocation(line: 320, column: 41, scope: !612)
!616 = !DILocation(line: 320, column: 44, scope: !612)
!617 = !DILocation(line: 320, column: 38, scope: !612)
!618 = !DILocation(line: 320, column: 17, scope: !608)
!619 = !DILocation(line: 321, column: 17, scope: !612)
!620 = !DILocation(line: 321, column: 26, scope: !612)
!621 = !DILocation(line: 321, column: 47, scope: !612)
!622 = !DILocation(line: 321, column: 49, scope: !612)
!623 = !DILocation(line: 321, column: 58, scope: !612)
!624 = !DILocation(line: 321, column: 64, scope: !612)
!625 = !DILocation(line: 321, column: 32, scope: !612)
!626 = !DILocalVariable(name: "diff", scope: !627, file: !30, line: 324, type: !18)
!627 = distinct !DILexicalBlock(scope: !603, file: !30, line: 322, column: 16)
!628 = !DILocation(line: 324, column: 17, scope: !627)
!629 = !DILocation(line: 324, column: 24, scope: !627)
!630 = !DILocation(line: 324, column: 33, scope: !627)
!631 = !DILocation(line: 324, column: 47, scope: !627)
!632 = !DILocation(line: 324, column: 56, scope: !627)
!633 = !DILocation(line: 324, column: 45, scope: !627)
!634 = !DILocation(line: 325, column: 17, scope: !635)
!635 = distinct !DILexicalBlock(scope: !627, file: !30, line: 325, column: 17)
!636 = !DILocation(line: 325, column: 22, scope: !635)
!637 = !DILocation(line: 325, column: 27, scope: !635)
!638 = !DILocation(line: 326, column: 20, scope: !639)
!639 = distinct !DILexicalBlock(scope: !635, file: !30, line: 325, column: 40)
!640 = !DILocation(line: 327, column: 17, scope: !639)
!641 = !DILocalVariable(name: "height", scope: !627, file: !30, line: 330, type: !18)
!642 = !DILocation(line: 330, column: 17, scope: !627)
!643 = !DILocation(line: 332, column: 23, scope: !627)
!644 = !DILocation(line: 332, column: 32, scope: !627)
!645 = !DILocation(line: 332, column: 46, scope: !627)
!646 = !DILocation(line: 332, column: 55, scope: !627)
!647 = !DILocation(line: 332, column: 44, scope: !627)
!648 = !DILocation(line: 333, column: 23, scope: !627)
!649 = !DILocation(line: 333, column: 32, scope: !627)
!650 = !DILocation(line: 333, column: 46, scope: !627)
!651 = !DILocation(line: 333, column: 55, scope: !627)
!652 = !DILocation(line: 333, column: 69, scope: !627)
!653 = !DILocation(line: 332, column: 20, scope: !627)
!654 = !DILocation(line: 334, column: 16, scope: !627)
!655 = !DILocation(line: 336, column: 17, scope: !656)
!656 = distinct !DILexicalBlock(scope: !627, file: !30, line: 336, column: 17)
!657 = !DILocation(line: 336, column: 21, scope: !656)
!658 = !DILocation(line: 336, column: 17, scope: !627)
!659 = !DILocation(line: 337, column: 21, scope: !660)
!660 = distinct !DILexicalBlock(scope: !661, file: !30, line: 337, column: 21)
!661 = distinct !DILexicalBlock(scope: !656, file: !30, line: 336, column: 26)
!662 = !DILocation(line: 337, column: 27, scope: !660)
!663 = !DILocation(line: 337, column: 31, scope: !660)
!664 = !DILocation(line: 337, column: 36, scope: !660)
!665 = !DILocation(line: 337, column: 42, scope: !660)
!666 = !DILocation(line: 337, column: 21, scope: !661)
!667 = !DILocation(line: 338, column: 50, scope: !660)
!668 = !DILocation(line: 338, column: 21, scope: !660)
!669 = !DILocation(line: 338, column: 27, scope: !660)
!670 = !DILocation(line: 338, column: 31, scope: !660)
!671 = !DILocation(line: 338, column: 36, scope: !660)
!672 = !DILocation(line: 338, column: 48, scope: !660)
!673 = !DILocation(line: 340, column: 51, scope: !660)
!674 = !DILocation(line: 340, column: 21, scope: !660)
!675 = !DILocation(line: 340, column: 27, scope: !660)
!676 = !DILocation(line: 340, column: 31, scope: !660)
!677 = !DILocation(line: 340, column: 36, scope: !660)
!678 = !DILocation(line: 340, column: 49, scope: !660)
!679 = distinct !{!679, !568, !680, !332}
!680 = !DILocation(line: 343, column: 5, scope: !523)
!681 = !DILocation(line: 345, column: 5, scope: !523)
!682 = !DILocation(line: 345, column: 8, scope: !523)
!683 = !DILocation(line: 345, column: 17, scope: !523)
!684 = !DILocation(line: 346, column: 12, scope: !523)
!685 = !DILocation(line: 346, column: 5, scope: !523)
!686 = !DILocation(line: 347, column: 1, scope: !523)
!687 = distinct !DISubprogram(name: "sorted", scope: !30, file: !30, line: 349, type: !524, scopeLine: 350, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !22)
!688 = !DILocalVariable(name: "t", arg: 1, scope: !687, file: !30, line: 349, type: !107)
!689 = !DILocation(line: 349, column: 23, scope: !687)
!690 = !DILocation(line: 351, column: 10, scope: !691)
!691 = distinct !DILexicalBlock(scope: !687, file: !30, line: 351, column: 9)
!692 = !DILocation(line: 351, column: 9, scope: !687)
!693 = !DILocation(line: 352, column: 9, scope: !691)
!694 = !DILocation(line: 354, column: 9, scope: !695)
!695 = distinct !DILexicalBlock(scope: !687, file: !30, line: 354, column: 9)
!696 = !DILocation(line: 354, column: 12, scope: !695)
!697 = !DILocation(line: 354, column: 20, scope: !695)
!698 = !DILocation(line: 354, column: 23, scope: !695)
!699 = !DILocation(line: 354, column: 17, scope: !695)
!700 = !DILocation(line: 354, column: 9, scope: !687)
!701 = !DILocation(line: 355, column: 9, scope: !695)
!702 = !DILocalVariable(name: "stack", scope: !687, file: !30, line: 357, type: !703)
!703 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !112, size: 64)
!704 = !DILocation(line: 357, column: 14, scope: !687)
!705 = !DILocation(line: 357, column: 22, scope: !687)
!706 = !DILocation(line: 357, column: 25, scope: !687)
!707 = !DILocation(line: 357, column: 35, scope: !687)
!708 = !DILocation(line: 357, column: 38, scope: !687)
!709 = !DILocation(line: 357, column: 43, scope: !687)
!710 = !DILocation(line: 358, column: 10, scope: !711)
!711 = distinct !DILexicalBlock(scope: !687, file: !30, line: 358, column: 9)
!712 = !DILocation(line: 358, column: 9, scope: !687)
!713 = !DILocation(line: 359, column: 9, scope: !711)
!714 = !DILocalVariable(name: "top", scope: !687, file: !30, line: 361, type: !77)
!715 = !DILocation(line: 361, column: 12, scope: !687)
!716 = !DILocalVariable(name: "ok", scope: !687, file: !30, line: 362, type: !18)
!717 = !DILocation(line: 362, column: 9, scope: !687)
!718 = !DILocalVariable(name: "node", scope: !687, file: !30, line: 363, type: !112)
!719 = !DILocation(line: 363, column: 13, scope: !687)
!720 = !DILocation(line: 363, column: 20, scope: !687)
!721 = !DILocation(line: 363, column: 23, scope: !687)
!722 = !DILocalVariable(name: "previous", scope: !687, file: !30, line: 364, type: !112)
!723 = !DILocation(line: 364, column: 13, scope: !687)
!724 = !DILocation(line: 366, column: 5, scope: !687)
!725 = !DILocation(line: 366, column: 13, scope: !687)
!726 = !DILocation(line: 366, column: 21, scope: !687)
!727 = !DILocation(line: 366, column: 24, scope: !687)
!728 = !DILocation(line: 366, column: 18, scope: !687)
!729 = !DILocation(line: 366, column: 33, scope: !687)
!730 = !DILocation(line: 367, column: 16, scope: !731)
!731 = distinct !DILexicalBlock(scope: !687, file: !30, line: 366, column: 52)
!732 = !DILocation(line: 367, column: 24, scope: !731)
!733 = !DILocation(line: 367, column: 27, scope: !731)
!734 = !DILocation(line: 367, column: 21, scope: !731)
!735 = !DILocation(line: 367, column: 9, scope: !731)
!736 = !DILocation(line: 368, column: 28, scope: !737)
!737 = distinct !DILexicalBlock(scope: !731, file: !30, line: 367, column: 37)
!738 = !DILocation(line: 368, column: 13, scope: !737)
!739 = !DILocation(line: 368, column: 22, scope: !737)
!740 = !DILocation(line: 368, column: 26, scope: !737)
!741 = !DILocation(line: 369, column: 20, scope: !737)
!742 = !DILocation(line: 369, column: 26, scope: !737)
!743 = !DILocation(line: 369, column: 18, scope: !737)
!744 = distinct !{!744, !735, !745, !332}
!745 = !DILocation(line: 370, column: 9, scope: !731)
!746 = !DILocation(line: 372, column: 16, scope: !731)
!747 = !DILocation(line: 372, column: 22, scope: !731)
!748 = !DILocation(line: 372, column: 14, scope: !731)
!749 = !DILocation(line: 374, column: 13, scope: !750)
!750 = distinct !DILexicalBlock(scope: !731, file: !30, line: 374, column: 13)
!751 = !DILocation(line: 374, column: 22, scope: !750)
!752 = !DILocation(line: 374, column: 25, scope: !750)
!753 = !DILocation(line: 374, column: 28, scope: !750)
!754 = !DILocation(line: 374, column: 32, scope: !750)
!755 = !DILocation(line: 374, column: 42, scope: !750)
!756 = !DILocation(line: 374, column: 47, scope: !750)
!757 = !DILocation(line: 374, column: 53, scope: !750)
!758 = !DILocation(line: 374, column: 58, scope: !750)
!759 = !DILocation(line: 374, column: 13, scope: !731)
!760 = !DILocation(line: 375, column: 16, scope: !761)
!761 = distinct !DILexicalBlock(scope: !750, file: !30, line: 374, column: 64)
!762 = !DILocation(line: 376, column: 13, scope: !761)
!763 = !DILocation(line: 379, column: 20, scope: !731)
!764 = !DILocation(line: 379, column: 18, scope: !731)
!765 = !DILocation(line: 380, column: 16, scope: !731)
!766 = !DILocation(line: 380, column: 22, scope: !731)
!767 = !DILocation(line: 380, column: 14, scope: !731)
!768 = distinct !{!768, !724, !769, !332}
!769 = !DILocation(line: 381, column: 5, scope: !687)
!770 = !DILocation(line: 383, column: 5, scope: !687)
!771 = !DILocation(line: 383, column: 8, scope: !687)
!772 = !DILocation(line: 383, column: 17, scope: !687)
!773 = !DILocation(line: 384, column: 12, scope: !687)
!774 = !DILocation(line: 384, column: 5, scope: !687)
!775 = !DILocation(line: 385, column: 1, scope: !687)
!776 = distinct !DISubprogram(name: "treetable_add", scope: !30, file: !30, line: 401, type: !777, scopeLine: 402, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !22)
!777 = !DISubroutineType(types: !778)
!778 = !{!3, !107, !19, !19}
!779 = !DILocalVariable(name: "table", arg: 1, scope: !776, file: !30, line: 401, type: !107)
!780 = !DILocation(line: 401, column: 39, scope: !776)
!781 = !DILocalVariable(name: "key", arg: 2, scope: !776, file: !30, line: 401, type: !19)
!782 = !DILocation(line: 401, column: 52, scope: !776)
!783 = !DILocalVariable(name: "val", arg: 3, scope: !776, file: !30, line: 401, type: !19)
!784 = !DILocation(line: 401, column: 63, scope: !776)
!785 = !DILocalVariable(name: "y", scope: !776, file: !30, line: 403, type: !112)
!786 = !DILocation(line: 403, column: 13, scope: !776)
!787 = !DILocation(line: 403, column: 17, scope: !776)
!788 = !DILocation(line: 403, column: 24, scope: !776)
!789 = !DILocalVariable(name: "x", scope: !776, file: !30, line: 404, type: !112)
!790 = !DILocation(line: 404, column: 13, scope: !776)
!791 = !DILocation(line: 404, column: 17, scope: !776)
!792 = !DILocation(line: 404, column: 24, scope: !776)
!793 = !DILocalVariable(name: "cmp", scope: !776, file: !30, line: 406, type: !18)
!794 = !DILocation(line: 406, column: 9, scope: !776)
!795 = !DILocation(line: 407, column: 5, scope: !776)
!796 = !DILocation(line: 407, column: 12, scope: !776)
!797 = !DILocation(line: 407, column: 17, scope: !776)
!798 = !DILocation(line: 407, column: 24, scope: !776)
!799 = !DILocation(line: 407, column: 14, scope: !776)
!800 = !DILocation(line: 408, column: 15, scope: !801)
!801 = distinct !DILexicalBlock(scope: !776, file: !30, line: 407, column: 34)
!802 = !DILocation(line: 408, column: 22, scope: !801)
!803 = !DILocation(line: 408, column: 26, scope: !801)
!804 = !DILocation(line: 408, column: 31, scope: !801)
!805 = !DILocation(line: 408, column: 34, scope: !801)
!806 = !DILocation(line: 408, column: 13, scope: !801)
!807 = !DILocation(line: 409, column: 15, scope: !801)
!808 = !DILocation(line: 409, column: 13, scope: !801)
!809 = !DILocation(line: 411, column: 13, scope: !810)
!810 = distinct !DILexicalBlock(scope: !801, file: !30, line: 411, column: 13)
!811 = !DILocation(line: 411, column: 17, scope: !810)
!812 = !DILocation(line: 411, column: 13, scope: !801)
!813 = !DILocation(line: 412, column: 17, scope: !814)
!814 = distinct !DILexicalBlock(scope: !810, file: !30, line: 411, column: 22)
!815 = !DILocation(line: 412, column: 20, scope: !814)
!816 = !DILocation(line: 412, column: 15, scope: !814)
!817 = !DILocation(line: 413, column: 9, scope: !814)
!818 = !DILocation(line: 413, column: 20, scope: !819)
!819 = distinct !DILexicalBlock(scope: !810, file: !30, line: 413, column: 20)
!820 = !DILocation(line: 413, column: 24, scope: !819)
!821 = !DILocation(line: 413, column: 20, scope: !810)
!822 = !DILocation(line: 414, column: 17, scope: !823)
!823 = distinct !DILexicalBlock(scope: !819, file: !30, line: 413, column: 29)
!824 = !DILocation(line: 414, column: 20, scope: !823)
!825 = !DILocation(line: 414, column: 15, scope: !823)
!826 = !DILocation(line: 416, column: 24, scope: !827)
!827 = distinct !DILexicalBlock(scope: !819, file: !30, line: 415, column: 16)
!828 = !DILocation(line: 416, column: 13, scope: !827)
!829 = !DILocation(line: 416, column: 16, scope: !827)
!830 = !DILocation(line: 416, column: 22, scope: !827)
!831 = !DILocation(line: 417, column: 13, scope: !827)
!832 = distinct !{!832, !795, !833, !332}
!833 = !DILocation(line: 419, column: 5, scope: !776)
!834 = !DILocalVariable(name: "n", scope: !776, file: !30, line: 420, type: !112)
!835 = !DILocation(line: 420, column: 13, scope: !776)
!836 = !DILocation(line: 420, column: 17, scope: !776)
!837 = !DILocation(line: 420, column: 24, scope: !776)
!838 = !DILocation(line: 422, column: 17, scope: !776)
!839 = !DILocation(line: 422, column: 5, scope: !776)
!840 = !DILocation(line: 422, column: 8, scope: !776)
!841 = !DILocation(line: 422, column: 15, scope: !776)
!842 = !DILocation(line: 423, column: 17, scope: !776)
!843 = !DILocation(line: 423, column: 5, scope: !776)
!844 = !DILocation(line: 423, column: 8, scope: !776)
!845 = !DILocation(line: 423, column: 15, scope: !776)
!846 = !DILocation(line: 424, column: 17, scope: !776)
!847 = !DILocation(line: 424, column: 5, scope: !776)
!848 = !DILocation(line: 424, column: 8, scope: !776)
!849 = !DILocation(line: 424, column: 15, scope: !776)
!850 = !DILocation(line: 425, column: 17, scope: !776)
!851 = !DILocation(line: 425, column: 24, scope: !776)
!852 = !DILocation(line: 425, column: 5, scope: !776)
!853 = !DILocation(line: 425, column: 8, scope: !776)
!854 = !DILocation(line: 425, column: 15, scope: !776)
!855 = !DILocation(line: 426, column: 17, scope: !776)
!856 = !DILocation(line: 426, column: 24, scope: !776)
!857 = !DILocation(line: 426, column: 5, scope: !776)
!858 = !DILocation(line: 426, column: 8, scope: !776)
!859 = !DILocation(line: 426, column: 15, scope: !776)
!860 = !DILocation(line: 428, column: 5, scope: !776)
!861 = !DILocation(line: 428, column: 12, scope: !776)
!862 = !DILocation(line: 428, column: 16, scope: !776)
!863 = !DILocation(line: 430, column: 9, scope: !864)
!864 = distinct !DILexicalBlock(scope: !776, file: !30, line: 430, column: 9)
!865 = !DILocation(line: 430, column: 14, scope: !864)
!866 = !DILocation(line: 430, column: 21, scope: !864)
!867 = !DILocation(line: 430, column: 11, scope: !864)
!868 = !DILocation(line: 430, column: 9, scope: !776)
!869 = !DILocation(line: 431, column: 23, scope: !870)
!870 = distinct !DILexicalBlock(scope: !864, file: !30, line: 430, column: 31)
!871 = !DILocation(line: 431, column: 9, scope: !870)
!872 = !DILocation(line: 431, column: 16, scope: !870)
!873 = !DILocation(line: 431, column: 21, scope: !870)
!874 = !DILocation(line: 432, column: 9, scope: !870)
!875 = !DILocation(line: 432, column: 12, scope: !870)
!876 = !DILocation(line: 432, column: 21, scope: !870)
!877 = !DILocation(line: 433, column: 5, scope: !870)
!878 = !DILocation(line: 434, column: 9, scope: !879)
!879 = distinct !DILexicalBlock(scope: !864, file: !30, line: 433, column: 12)
!880 = !DILocation(line: 434, column: 12, scope: !879)
!881 = !DILocation(line: 434, column: 18, scope: !879)
!882 = !DILocation(line: 435, column: 13, scope: !883)
!883 = distinct !DILexicalBlock(scope: !879, file: !30, line: 435, column: 13)
!884 = !DILocation(line: 435, column: 20, scope: !883)
!885 = !DILocation(line: 435, column: 24, scope: !883)
!886 = !DILocation(line: 435, column: 29, scope: !883)
!887 = !DILocation(line: 435, column: 32, scope: !883)
!888 = !DILocation(line: 435, column: 37, scope: !883)
!889 = !DILocation(line: 435, column: 13, scope: !879)
!890 = !DILocation(line: 436, column: 23, scope: !891)
!891 = distinct !DILexicalBlock(scope: !883, file: !30, line: 435, column: 42)
!892 = !DILocation(line: 436, column: 13, scope: !891)
!893 = !DILocation(line: 436, column: 16, scope: !891)
!894 = !DILocation(line: 436, column: 21, scope: !891)
!895 = !DILocation(line: 437, column: 9, scope: !891)
!896 = !DILocation(line: 438, column: 24, scope: !897)
!897 = distinct !DILexicalBlock(scope: !883, file: !30, line: 437, column: 16)
!898 = !DILocation(line: 438, column: 13, scope: !897)
!899 = !DILocation(line: 438, column: 16, scope: !897)
!900 = !DILocation(line: 438, column: 22, scope: !897)
!901 = !DILocation(line: 440, column: 32, scope: !879)
!902 = !DILocation(line: 440, column: 39, scope: !879)
!903 = !DILocation(line: 440, column: 9, scope: !879)
!904 = !DILocation(line: 442, column: 5, scope: !776)
!905 = !DILocation(line: 443, column: 1, scope: !776)
!906 = distinct !DISubprogram(name: "rebalance_after_insert", scope: !30, file: !30, line: 451, type: !225, scopeLine: 452, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !22)
!907 = !DILocalVariable(name: "table", arg: 1, scope: !906, file: !30, line: 451, type: !107)
!908 = !DILocation(line: 451, column: 47, scope: !906)
!909 = !DILocalVariable(name: "z", arg: 2, scope: !906, file: !30, line: 451, type: !112)
!910 = !DILocation(line: 451, column: 62, scope: !906)
!911 = !DILocalVariable(name: "y", scope: !906, file: !30, line: 453, type: !112)
!912 = !DILocation(line: 453, column: 13, scope: !906)
!913 = !DILocation(line: 455, column: 5, scope: !906)
!914 = !DILocation(line: 455, column: 12, scope: !906)
!915 = !DILocation(line: 455, column: 15, scope: !906)
!916 = !DILocation(line: 455, column: 23, scope: !906)
!917 = !DILocation(line: 455, column: 29, scope: !906)
!918 = !DILocation(line: 456, column: 13, scope: !919)
!919 = distinct !DILexicalBlock(scope: !920, file: !30, line: 456, column: 13)
!920 = distinct !DILexicalBlock(scope: !906, file: !30, line: 455, column: 40)
!921 = !DILocation(line: 456, column: 16, scope: !919)
!922 = !DILocation(line: 456, column: 26, scope: !919)
!923 = !DILocation(line: 456, column: 29, scope: !919)
!924 = !DILocation(line: 456, column: 37, scope: !919)
!925 = !DILocation(line: 456, column: 45, scope: !919)
!926 = !DILocation(line: 456, column: 23, scope: !919)
!927 = !DILocation(line: 456, column: 13, scope: !920)
!928 = !DILocation(line: 457, column: 17, scope: !929)
!929 = distinct !DILexicalBlock(scope: !919, file: !30, line: 456, column: 51)
!930 = !DILocation(line: 457, column: 20, scope: !929)
!931 = !DILocation(line: 457, column: 28, scope: !929)
!932 = !DILocation(line: 457, column: 36, scope: !929)
!933 = !DILocation(line: 457, column: 15, scope: !929)
!934 = !DILocation(line: 458, column: 17, scope: !935)
!935 = distinct !DILexicalBlock(scope: !929, file: !30, line: 458, column: 17)
!936 = !DILocation(line: 458, column: 20, scope: !935)
!937 = !DILocation(line: 458, column: 26, scope: !935)
!938 = !DILocation(line: 458, column: 17, scope: !929)
!939 = !DILocation(line: 459, column: 17, scope: !940)
!940 = distinct !DILexicalBlock(scope: !935, file: !30, line: 458, column: 37)
!941 = !DILocation(line: 459, column: 20, scope: !940)
!942 = !DILocation(line: 459, column: 28, scope: !940)
!943 = !DILocation(line: 459, column: 42, scope: !940)
!944 = !DILocation(line: 460, column: 17, scope: !940)
!945 = !DILocation(line: 460, column: 20, scope: !940)
!946 = !DILocation(line: 460, column: 42, scope: !940)
!947 = !DILocation(line: 461, column: 17, scope: !940)
!948 = !DILocation(line: 461, column: 20, scope: !940)
!949 = !DILocation(line: 461, column: 28, scope: !940)
!950 = !DILocation(line: 461, column: 36, scope: !940)
!951 = !DILocation(line: 461, column: 42, scope: !940)
!952 = !DILocation(line: 462, column: 21, scope: !940)
!953 = !DILocation(line: 462, column: 24, scope: !940)
!954 = !DILocation(line: 462, column: 32, scope: !940)
!955 = !DILocation(line: 462, column: 19, scope: !940)
!956 = !DILocation(line: 463, column: 13, scope: !940)
!957 = !DILocation(line: 464, column: 21, scope: !958)
!958 = distinct !DILexicalBlock(scope: !959, file: !30, line: 464, column: 21)
!959 = distinct !DILexicalBlock(scope: !935, file: !30, line: 463, column: 20)
!960 = !DILocation(line: 464, column: 26, scope: !958)
!961 = !DILocation(line: 464, column: 29, scope: !958)
!962 = !DILocation(line: 464, column: 37, scope: !958)
!963 = !DILocation(line: 464, column: 23, scope: !958)
!964 = !DILocation(line: 464, column: 21, scope: !959)
!965 = !DILocation(line: 465, column: 25, scope: !966)
!966 = distinct !DILexicalBlock(scope: !958, file: !30, line: 464, column: 44)
!967 = !DILocation(line: 465, column: 28, scope: !966)
!968 = !DILocation(line: 465, column: 23, scope: !966)
!969 = !DILocation(line: 466, column: 33, scope: !966)
!970 = !DILocation(line: 466, column: 40, scope: !966)
!971 = !DILocation(line: 466, column: 21, scope: !966)
!972 = !DILocation(line: 467, column: 17, scope: !966)
!973 = !DILocation(line: 468, column: 17, scope: !959)
!974 = !DILocation(line: 468, column: 20, scope: !959)
!975 = !DILocation(line: 468, column: 28, scope: !959)
!976 = !DILocation(line: 468, column: 42, scope: !959)
!977 = !DILocation(line: 469, column: 17, scope: !959)
!978 = !DILocation(line: 469, column: 20, scope: !959)
!979 = !DILocation(line: 469, column: 28, scope: !959)
!980 = !DILocation(line: 469, column: 36, scope: !959)
!981 = !DILocation(line: 469, column: 42, scope: !959)
!982 = !DILocation(line: 470, column: 30, scope: !959)
!983 = !DILocation(line: 470, column: 37, scope: !959)
!984 = !DILocation(line: 470, column: 40, scope: !959)
!985 = !DILocation(line: 470, column: 48, scope: !959)
!986 = !DILocation(line: 470, column: 17, scope: !959)
!987 = !DILocation(line: 473, column: 17, scope: !988)
!988 = distinct !DILexicalBlock(scope: !919, file: !30, line: 472, column: 16)
!989 = !DILocation(line: 473, column: 20, scope: !988)
!990 = !DILocation(line: 473, column: 28, scope: !988)
!991 = !DILocation(line: 473, column: 36, scope: !988)
!992 = !DILocation(line: 473, column: 15, scope: !988)
!993 = !DILocation(line: 474, column: 17, scope: !994)
!994 = distinct !DILexicalBlock(scope: !988, file: !30, line: 474, column: 17)
!995 = !DILocation(line: 474, column: 20, scope: !994)
!996 = !DILocation(line: 474, column: 26, scope: !994)
!997 = !DILocation(line: 474, column: 17, scope: !988)
!998 = !DILocation(line: 475, column: 17, scope: !999)
!999 = distinct !DILexicalBlock(scope: !994, file: !30, line: 474, column: 37)
!1000 = !DILocation(line: 475, column: 20, scope: !999)
!1001 = !DILocation(line: 475, column: 28, scope: !999)
!1002 = !DILocation(line: 475, column: 42, scope: !999)
!1003 = !DILocation(line: 476, column: 17, scope: !999)
!1004 = !DILocation(line: 476, column: 20, scope: !999)
!1005 = !DILocation(line: 476, column: 42, scope: !999)
!1006 = !DILocation(line: 477, column: 17, scope: !999)
!1007 = !DILocation(line: 477, column: 20, scope: !999)
!1008 = !DILocation(line: 477, column: 28, scope: !999)
!1009 = !DILocation(line: 477, column: 36, scope: !999)
!1010 = !DILocation(line: 477, column: 42, scope: !999)
!1011 = !DILocation(line: 478, column: 21, scope: !999)
!1012 = !DILocation(line: 478, column: 24, scope: !999)
!1013 = !DILocation(line: 478, column: 32, scope: !999)
!1014 = !DILocation(line: 478, column: 19, scope: !999)
!1015 = !DILocation(line: 479, column: 13, scope: !999)
!1016 = !DILocation(line: 480, column: 21, scope: !1017)
!1017 = distinct !DILexicalBlock(scope: !1018, file: !30, line: 480, column: 21)
!1018 = distinct !DILexicalBlock(scope: !994, file: !30, line: 479, column: 20)
!1019 = !DILocation(line: 480, column: 26, scope: !1017)
!1020 = !DILocation(line: 480, column: 29, scope: !1017)
!1021 = !DILocation(line: 480, column: 37, scope: !1017)
!1022 = !DILocation(line: 480, column: 23, scope: !1017)
!1023 = !DILocation(line: 480, column: 21, scope: !1018)
!1024 = !DILocation(line: 481, column: 25, scope: !1025)
!1025 = distinct !DILexicalBlock(scope: !1017, file: !30, line: 480, column: 43)
!1026 = !DILocation(line: 481, column: 28, scope: !1025)
!1027 = !DILocation(line: 481, column: 23, scope: !1025)
!1028 = !DILocation(line: 482, column: 34, scope: !1025)
!1029 = !DILocation(line: 482, column: 41, scope: !1025)
!1030 = !DILocation(line: 482, column: 21, scope: !1025)
!1031 = !DILocation(line: 483, column: 17, scope: !1025)
!1032 = !DILocation(line: 484, column: 17, scope: !1018)
!1033 = !DILocation(line: 484, column: 20, scope: !1018)
!1034 = !DILocation(line: 484, column: 28, scope: !1018)
!1035 = !DILocation(line: 484, column: 42, scope: !1018)
!1036 = !DILocation(line: 485, column: 17, scope: !1018)
!1037 = !DILocation(line: 485, column: 20, scope: !1018)
!1038 = !DILocation(line: 485, column: 28, scope: !1018)
!1039 = !DILocation(line: 485, column: 36, scope: !1018)
!1040 = !DILocation(line: 485, column: 42, scope: !1018)
!1041 = !DILocation(line: 486, column: 29, scope: !1018)
!1042 = !DILocation(line: 486, column: 36, scope: !1018)
!1043 = !DILocation(line: 486, column: 39, scope: !1018)
!1044 = !DILocation(line: 486, column: 47, scope: !1018)
!1045 = !DILocation(line: 486, column: 17, scope: !1018)
!1046 = distinct !{!1046, !913, !1047, !332}
!1047 = !DILocation(line: 489, column: 5, scope: !906)
!1048 = !DILocation(line: 490, column: 5, scope: !906)
!1049 = !DILocation(line: 490, column: 12, scope: !906)
!1050 = !DILocation(line: 490, column: 18, scope: !906)
!1051 = !DILocation(line: 490, column: 24, scope: !906)
!1052 = !DILocation(line: 491, column: 1, scope: !906)
!1053 = distinct !DISubprogram(name: "test_get_greater_than_absent_key_fails", scope: !1, file: !1, line: 22, type: !1054, scopeLine: 23, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !22)
!1054 = !DISubroutineType(types: !1055)
!1055 = !{null}
!1056 = !DILocalVariable(name: "present", scope: !1053, file: !1, line: 24, type: !18)
!1057 = !DILocation(line: 24, column: 9, scope: !1053)
!1058 = !DILocation(line: 24, column: 19, scope: !1053)
!1059 = !DILocalVariable(name: "absent", scope: !1053, file: !1, line: 25, type: !18)
!1060 = !DILocation(line: 25, column: 9, scope: !1053)
!1061 = !DILocation(line: 25, column: 19, scope: !1053)
!1062 = !DILocalVariable(name: "value", scope: !1053, file: !1, line: 26, type: !18)
!1063 = !DILocation(line: 26, column: 9, scope: !1053)
!1064 = !DILocation(line: 26, column: 19, scope: !1053)
!1065 = !DILocalVariable(name: "out", scope: !1053, file: !1, line: 27, type: !19)
!1066 = !DILocation(line: 27, column: 11, scope: !1053)
!1067 = !DILocation(line: 29, column: 17, scope: !1053)
!1068 = !DILocation(line: 29, column: 28, scope: !1053)
!1069 = !DILocation(line: 29, column: 25, scope: !1053)
!1070 = !DILocation(line: 29, column: 5, scope: !1053)
!1071 = !DILocalVariable(name: "table", scope: !1053, file: !1, line: 31, type: !107)
!1072 = !DILocation(line: 31, column: 16, scope: !1053)
!1073 = !DILocation(line: 31, column: 24, scope: !1053)
!1074 = !DILocation(line: 33, column: 5, scope: !1053)
!1075 = !DILocation(line: 34, column: 5, scope: !1053)
!1076 = !DILocation(line: 37, column: 23, scope: !1053)
!1077 = !DILocation(line: 37, column: 5, scope: !1053)
!1078 = !DILocation(line: 38, column: 1, scope: !1053)
!1079 = distinct !DISubprogram(name: "symbolic_int", scope: !1080, file: !1080, line: 32, type: !1081, scopeLine: 33, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !22)
!1080 = !DIFile(filename: "./klee_helpers.h", directory: "/home/klee/work/ex3/Ex3SymbTestSuite")
!1081 = !DISubroutineType(types: !1082)
!1082 = !{!18, !1083, !18}
!1083 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1084, size: 64)
!1084 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !119)
!1085 = !DILocalVariable(name: "name", arg: 1, scope: !1079, file: !1080, line: 32, type: !1083)
!1086 = !DILocation(line: 32, column: 37, scope: !1079)
!1087 = !DILocalVariable(name: "concrete_fallback", arg: 2, scope: !1079, file: !1080, line: 32, type: !18)
!1088 = !DILocation(line: 32, column: 47, scope: !1079)
!1089 = !DILocalVariable(name: "value", scope: !1079, file: !1080, line: 34, type: !18)
!1090 = !DILocation(line: 34, column: 9, scope: !1079)
!1091 = !DILocation(line: 34, column: 17, scope: !1079)
!1092 = !DILocation(line: 35, column: 24, scope: !1079)
!1093 = !DILocation(line: 35, column: 47, scope: !1079)
!1094 = !DILocation(line: 35, column: 5, scope: !1079)
!1095 = !DILocation(line: 36, column: 12, scope: !1079)
!1096 = !DILocation(line: 36, column: 5, scope: !1079)
!1097 = distinct !DISubprogram(name: "make_table", scope: !1080, file: !1080, line: 53, type: !1098, scopeLine: 54, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !22)
!1098 = !DISubroutineType(types: !1099)
!1099 = !{!107}
!1100 = !DILocalVariable(name: "conf", scope: !1097, file: !1080, line: 55, type: !67)
!1101 = !DILocation(line: 55, column: 19, scope: !1097)
!1102 = !DILocalVariable(name: "table", scope: !1097, file: !1080, line: 56, type: !107)
!1103 = !DILocation(line: 56, column: 16, scope: !1097)
!1104 = !DILocation(line: 57, column: 5, scope: !1097)
!1105 = !DILocation(line: 58, column: 10, scope: !1097)
!1106 = !DILocation(line: 58, column: 22, scope: !1097)
!1107 = !DILocation(line: 59, column: 10, scope: !1097)
!1108 = !DILocation(line: 59, column: 22, scope: !1097)
!1109 = !DILocation(line: 60, column: 5, scope: !1097)
!1110 = !DILocation(line: 61, column: 5, scope: !1097)
!1111 = !DILocation(line: 62, column: 12, scope: !1097)
!1112 = !DILocation(line: 62, column: 5, scope: !1097)
!1113 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 40, type: !1114, scopeLine: 41, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !22)
!1114 = !DISubroutineType(types: !1115)
!1115 = !{!18}
!1116 = !DILocation(line: 42, column: 5, scope: !1113)
!1117 = !DILocation(line: 43, column: 5, scope: !1113)
!1118 = distinct !DISubprogram(name: "rotate_left", scope: !30, file: !30, line: 547, type: !225, scopeLine: 548, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !22)
!1119 = !DILocalVariable(name: "table", arg: 1, scope: !1118, file: !30, line: 547, type: !107)
!1120 = !DILocation(line: 547, column: 36, scope: !1118)
!1121 = !DILocalVariable(name: "x", arg: 2, scope: !1118, file: !30, line: 547, type: !112)
!1122 = !DILocation(line: 547, column: 51, scope: !1118)
!1123 = !DILocalVariable(name: "y", scope: !1118, file: !30, line: 549, type: !112)
!1124 = !DILocation(line: 549, column: 13, scope: !1118)
!1125 = !DILocation(line: 549, column: 17, scope: !1118)
!1126 = !DILocation(line: 549, column: 20, scope: !1118)
!1127 = !DILocation(line: 551, column: 16, scope: !1118)
!1128 = !DILocation(line: 551, column: 19, scope: !1118)
!1129 = !DILocation(line: 551, column: 5, scope: !1118)
!1130 = !DILocation(line: 551, column: 8, scope: !1118)
!1131 = !DILocation(line: 551, column: 14, scope: !1118)
!1132 = !DILocation(line: 553, column: 9, scope: !1133)
!1133 = distinct !DILexicalBlock(scope: !1118, file: !30, line: 553, column: 9)
!1134 = !DILocation(line: 553, column: 12, scope: !1133)
!1135 = !DILocation(line: 553, column: 20, scope: !1133)
!1136 = !DILocation(line: 553, column: 27, scope: !1133)
!1137 = !DILocation(line: 553, column: 17, scope: !1133)
!1138 = !DILocation(line: 553, column: 9, scope: !1118)
!1139 = !DILocation(line: 554, column: 27, scope: !1133)
!1140 = !DILocation(line: 554, column: 9, scope: !1133)
!1141 = !DILocation(line: 554, column: 12, scope: !1133)
!1142 = !DILocation(line: 554, column: 18, scope: !1133)
!1143 = !DILocation(line: 554, column: 25, scope: !1133)
!1144 = !DILocation(line: 556, column: 17, scope: !1118)
!1145 = !DILocation(line: 556, column: 20, scope: !1118)
!1146 = !DILocation(line: 556, column: 5, scope: !1118)
!1147 = !DILocation(line: 556, column: 8, scope: !1118)
!1148 = !DILocation(line: 556, column: 15, scope: !1118)
!1149 = !DILocation(line: 558, column: 9, scope: !1150)
!1150 = distinct !DILexicalBlock(scope: !1118, file: !30, line: 558, column: 9)
!1151 = !DILocation(line: 558, column: 12, scope: !1150)
!1152 = !DILocation(line: 558, column: 22, scope: !1150)
!1153 = !DILocation(line: 558, column: 29, scope: !1150)
!1154 = !DILocation(line: 558, column: 19, scope: !1150)
!1155 = !DILocation(line: 558, column: 9, scope: !1118)
!1156 = !DILocation(line: 559, column: 23, scope: !1150)
!1157 = !DILocation(line: 559, column: 9, scope: !1150)
!1158 = !DILocation(line: 559, column: 16, scope: !1150)
!1159 = !DILocation(line: 559, column: 21, scope: !1150)
!1160 = !DILocation(line: 560, column: 14, scope: !1161)
!1161 = distinct !DILexicalBlock(scope: !1150, file: !30, line: 560, column: 14)
!1162 = !DILocation(line: 560, column: 19, scope: !1161)
!1163 = !DILocation(line: 560, column: 22, scope: !1161)
!1164 = !DILocation(line: 560, column: 30, scope: !1161)
!1165 = !DILocation(line: 560, column: 16, scope: !1161)
!1166 = !DILocation(line: 560, column: 14, scope: !1150)
!1167 = !DILocation(line: 561, column: 27, scope: !1161)
!1168 = !DILocation(line: 561, column: 9, scope: !1161)
!1169 = !DILocation(line: 561, column: 12, scope: !1161)
!1170 = !DILocation(line: 561, column: 20, scope: !1161)
!1171 = !DILocation(line: 561, column: 25, scope: !1161)
!1172 = !DILocation(line: 563, column: 28, scope: !1161)
!1173 = !DILocation(line: 563, column: 9, scope: !1161)
!1174 = !DILocation(line: 563, column: 12, scope: !1161)
!1175 = !DILocation(line: 563, column: 20, scope: !1161)
!1176 = !DILocation(line: 563, column: 26, scope: !1161)
!1177 = !DILocation(line: 565, column: 17, scope: !1118)
!1178 = !DILocation(line: 565, column: 5, scope: !1118)
!1179 = !DILocation(line: 565, column: 8, scope: !1118)
!1180 = !DILocation(line: 565, column: 15, scope: !1118)
!1181 = !DILocation(line: 566, column: 17, scope: !1118)
!1182 = !DILocation(line: 566, column: 5, scope: !1118)
!1183 = !DILocation(line: 566, column: 8, scope: !1118)
!1184 = !DILocation(line: 566, column: 15, scope: !1118)
!1185 = !DILocation(line: 567, column: 1, scope: !1118)
!1186 = distinct !DISubprogram(name: "rotate_right", scope: !30, file: !30, line: 518, type: !225, scopeLine: 519, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !22)
!1187 = !DILocalVariable(name: "table", arg: 1, scope: !1186, file: !30, line: 518, type: !107)
!1188 = !DILocation(line: 518, column: 37, scope: !1186)
!1189 = !DILocalVariable(name: "x", arg: 2, scope: !1186, file: !30, line: 518, type: !112)
!1190 = !DILocation(line: 518, column: 52, scope: !1186)
!1191 = !DILocalVariable(name: "y", scope: !1186, file: !30, line: 520, type: !112)
!1192 = !DILocation(line: 520, column: 13, scope: !1186)
!1193 = !DILocation(line: 520, column: 17, scope: !1186)
!1194 = !DILocation(line: 520, column: 20, scope: !1186)
!1195 = !DILocation(line: 522, column: 15, scope: !1186)
!1196 = !DILocation(line: 522, column: 18, scope: !1186)
!1197 = !DILocation(line: 522, column: 5, scope: !1186)
!1198 = !DILocation(line: 522, column: 8, scope: !1186)
!1199 = !DILocation(line: 522, column: 13, scope: !1186)
!1200 = !DILocation(line: 524, column: 9, scope: !1201)
!1201 = distinct !DILexicalBlock(scope: !1186, file: !30, line: 524, column: 9)
!1202 = !DILocation(line: 524, column: 12, scope: !1201)
!1203 = !DILocation(line: 524, column: 21, scope: !1201)
!1204 = !DILocation(line: 524, column: 28, scope: !1201)
!1205 = !DILocation(line: 524, column: 18, scope: !1201)
!1206 = !DILocation(line: 524, column: 9, scope: !1186)
!1207 = !DILocation(line: 525, column: 28, scope: !1201)
!1208 = !DILocation(line: 525, column: 9, scope: !1201)
!1209 = !DILocation(line: 525, column: 12, scope: !1201)
!1210 = !DILocation(line: 525, column: 19, scope: !1201)
!1211 = !DILocation(line: 525, column: 26, scope: !1201)
!1212 = !DILocation(line: 527, column: 17, scope: !1186)
!1213 = !DILocation(line: 527, column: 20, scope: !1186)
!1214 = !DILocation(line: 527, column: 5, scope: !1186)
!1215 = !DILocation(line: 527, column: 8, scope: !1186)
!1216 = !DILocation(line: 527, column: 15, scope: !1186)
!1217 = !DILocation(line: 529, column: 9, scope: !1218)
!1218 = distinct !DILexicalBlock(scope: !1186, file: !30, line: 529, column: 9)
!1219 = !DILocation(line: 529, column: 12, scope: !1218)
!1220 = !DILocation(line: 529, column: 22, scope: !1218)
!1221 = !DILocation(line: 529, column: 29, scope: !1218)
!1222 = !DILocation(line: 529, column: 19, scope: !1218)
!1223 = !DILocation(line: 529, column: 9, scope: !1186)
!1224 = !DILocation(line: 530, column: 23, scope: !1218)
!1225 = !DILocation(line: 530, column: 9, scope: !1218)
!1226 = !DILocation(line: 530, column: 16, scope: !1218)
!1227 = !DILocation(line: 530, column: 21, scope: !1218)
!1228 = !DILocation(line: 531, column: 14, scope: !1229)
!1229 = distinct !DILexicalBlock(scope: !1218, file: !30, line: 531, column: 14)
!1230 = !DILocation(line: 531, column: 19, scope: !1229)
!1231 = !DILocation(line: 531, column: 22, scope: !1229)
!1232 = !DILocation(line: 531, column: 30, scope: !1229)
!1233 = !DILocation(line: 531, column: 16, scope: !1229)
!1234 = !DILocation(line: 531, column: 14, scope: !1218)
!1235 = !DILocation(line: 532, column: 28, scope: !1229)
!1236 = !DILocation(line: 532, column: 9, scope: !1229)
!1237 = !DILocation(line: 532, column: 12, scope: !1229)
!1238 = !DILocation(line: 532, column: 20, scope: !1229)
!1239 = !DILocation(line: 532, column: 26, scope: !1229)
!1240 = !DILocation(line: 534, column: 27, scope: !1229)
!1241 = !DILocation(line: 534, column: 9, scope: !1229)
!1242 = !DILocation(line: 534, column: 12, scope: !1229)
!1243 = !DILocation(line: 534, column: 20, scope: !1229)
!1244 = !DILocation(line: 534, column: 25, scope: !1229)
!1245 = !DILocation(line: 536, column: 17, scope: !1186)
!1246 = !DILocation(line: 536, column: 5, scope: !1186)
!1247 = !DILocation(line: 536, column: 8, scope: !1186)
!1248 = !DILocation(line: 536, column: 15, scope: !1186)
!1249 = !DILocation(line: 537, column: 17, scope: !1186)
!1250 = !DILocation(line: 537, column: 5, scope: !1186)
!1251 = !DILocation(line: 537, column: 8, scope: !1186)
!1252 = !DILocation(line: 537, column: 15, scope: !1186)
!1253 = !DILocation(line: 538, column: 1, scope: !1186)
!1254 = distinct !DISubprogram(name: "safe_malloc", scope: !1080, file: !1080, line: 39, type: !75, scopeLine: 40, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !22)
!1255 = !DILocalVariable(name: "size", arg: 1, scope: !1254, file: !1080, line: 39, type: !77)
!1256 = !DILocation(line: 39, column: 33, scope: !1254)
!1257 = !DILocalVariable(name: "ptr", scope: !1254, file: !1080, line: 41, type: !19)
!1258 = !DILocation(line: 41, column: 11, scope: !1254)
!1259 = !DILocation(line: 41, column: 24, scope: !1254)
!1260 = !DILocation(line: 41, column: 17, scope: !1254)
!1261 = !DILocation(line: 42, column: 17, scope: !1254)
!1262 = !DILocation(line: 42, column: 21, scope: !1254)
!1263 = !DILocation(line: 42, column: 5, scope: !1254)
!1264 = !DILocation(line: 43, column: 12, scope: !1254)
!1265 = !DILocation(line: 43, column: 5, scope: !1254)
!1266 = distinct !DISubprogram(name: "safe_calloc", scope: !1080, file: !1080, line: 46, type: !82, scopeLine: 47, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !22)
!1267 = !DILocalVariable(name: "count", arg: 1, scope: !1266, file: !1080, line: 46, type: !77)
!1268 = !DILocation(line: 46, column: 33, scope: !1266)
!1269 = !DILocalVariable(name: "size", arg: 2, scope: !1266, file: !1080, line: 46, type: !77)
!1270 = !DILocation(line: 46, column: 47, scope: !1266)
!1271 = !DILocalVariable(name: "ptr", scope: !1266, file: !1080, line: 48, type: !19)
!1272 = !DILocation(line: 48, column: 11, scope: !1266)
!1273 = !DILocation(line: 48, column: 24, scope: !1266)
!1274 = !DILocation(line: 48, column: 31, scope: !1266)
!1275 = !DILocation(line: 48, column: 17, scope: !1266)
!1276 = !DILocation(line: 49, column: 17, scope: !1266)
!1277 = !DILocation(line: 49, column: 21, scope: !1266)
!1278 = !DILocation(line: 49, column: 5, scope: !1266)
!1279 = !DILocation(line: 50, column: 12, scope: !1266)
!1280 = !DILocation(line: 50, column: 5, scope: !1266)
!1281 = distinct !DISubprogram(name: "memcpy", scope: !1282, file: !1282, line: 12, type: !1283, scopeLine: 12, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !20, retainedNodes: !22)
!1282 = !DIFile(filename: "klee_src/runtime/Freestanding/memcpy.c", directory: "/tmp")
!1283 = !DISubroutineType(types: !1284)
!1284 = !{!19, !19, !33, !1285}
!1285 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !1286, line: 46, baseType: !79)
!1286 = !DIFile(filename: "llvm-130-install_O_D_A/lib/clang/13.0.1/include/stddef.h", directory: "/tmp")
!1287 = !DILocalVariable(name: "destaddr", arg: 1, scope: !1281, file: !1282, line: 12, type: !19)
!1288 = !DILocation(line: 12, column: 20, scope: !1281)
!1289 = !DILocalVariable(name: "srcaddr", arg: 2, scope: !1281, file: !1282, line: 12, type: !33)
!1290 = !DILocation(line: 12, column: 42, scope: !1281)
!1291 = !DILocalVariable(name: "len", arg: 3, scope: !1281, file: !1282, line: 12, type: !1285)
!1292 = !DILocation(line: 12, column: 58, scope: !1281)
!1293 = !DILocalVariable(name: "dest", scope: !1281, file: !1282, line: 13, type: !1294)
!1294 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !119, size: 64)
!1295 = !DILocation(line: 13, column: 9, scope: !1281)
!1296 = !DILocation(line: 13, column: 16, scope: !1281)
!1297 = !DILocalVariable(name: "src", scope: !1281, file: !1282, line: 14, type: !1083)
!1298 = !DILocation(line: 14, column: 15, scope: !1281)
!1299 = !DILocation(line: 14, column: 21, scope: !1281)
!1300 = !DILocation(line: 16, column: 3, scope: !1281)
!1301 = !DILocation(line: 16, column: 13, scope: !1281)
!1302 = !DILocation(line: 16, column: 16, scope: !1281)
!1303 = !DILocation(line: 17, column: 19, scope: !1281)
!1304 = !DILocation(line: 17, column: 15, scope: !1281)
!1305 = !DILocation(line: 17, column: 10, scope: !1281)
!1306 = !DILocation(line: 17, column: 13, scope: !1281)
!1307 = distinct !{!1307, !1300, !1303, !332}
!1308 = !DILocation(line: 18, column: 10, scope: !1281)
!1309 = !DILocation(line: 18, column: 3, scope: !1281)
