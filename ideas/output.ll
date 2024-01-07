; ModuleID = 'source.c'
source_filename = "source.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, %struct._IO_codecvt*, %struct._IO_wide_data*, %struct._IO_FILE*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type opaque
%struct._IO_codecvt = type opaque
%struct._IO_wide_data = type opaque
%struct.file = type { i32, i32, i8*, [32 x i8], {}*, void (%struct.file*, i32)*, void (%struct.file*, i32, i8*)*, {}* }

@.str = private unnamed_addr constant [27 x i8] c"Reading %d bytes from %s:\0A\00", align 1
@stdout = external global %struct._IO_FILE*, align 8
@.str.1 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.2 = private unnamed_addr constant [24 x i8] c"Writing %d bytes to %s\0A\00", align 1
@.str.3 = private unnamed_addr constant [16 x i8] c"Duplicating %s\0A\00", align 1
@files = dso_local global [16 x %struct.file*] zeroinitializer, align 16
@.str.4 = private unnamed_addr constant [25 x i8] c"No more slots available\0A\00", align 1
@.str.5 = private unnamed_addr constant [28 x i8] c"Created file %s at slot %d\0A\00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"No such file %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [27 x i8] c"Closed file %s at slot %d\0A\00", align 1
@.str.8 = private unnamed_addr constant [33 x i8] c"Welcome to the CTF file manager\0A\00", align 1
@.str.9 = private unnamed_addr constant [11 x i8] c"Commands:\0A\00", align 1
@.str.10 = private unnamed_addr constant [15 x i8] c"create <name>\0A\00", align 1
@.str.11 = private unnamed_addr constant [14 x i8] c"close <name>\0A\00", align 1
@.str.12 = private unnamed_addr constant [12 x i8] c"dup <name>\0A\00", align 1
@.str.13 = private unnamed_addr constant [17 x i8] c"read <name> <n>\0A\00", align 1
@.str.14 = private unnamed_addr constant [25 x i8] c"write <name> <n> <data>\0A\00", align 1
@.str.15 = private unnamed_addr constant [6 x i8] c"quit\0A\00", align 1
@.str.16 = private unnamed_addr constant [11 x i8] c"create %ms\00", align 1
@.str.17 = private unnamed_addr constant [10 x i8] c"close %ms\00", align 1
@.str.18 = private unnamed_addr constant [8 x i8] c"dup %ms\00", align 1
@.str.19 = private unnamed_addr constant [12 x i8] c"read %ms %d\00", align 1
@.str.20 = private unnamed_addr constant [17 x i8] c"write %ms %d %ms\00", align 1
@.str.21 = private unnamed_addr constant [5 x i8] c"quit\00", align 1
@.str.22 = private unnamed_addr constant [17 x i8] c"Invalid command\0A\00", align 1
@.str.23 = private unnamed_addr constant [3 x i8] c"> \00", align 1
@stdin = external global %struct._IO_FILE*, align 8

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @ctf_file_close(%struct.file* noundef %0) #0 {
  %2 = alloca %struct.file*, align 8
  store %struct.file* %0, %struct.file** %2, align 8
  %3 = load %struct.file*, %struct.file** %2, align 8
  %4 = getelementptr inbounds %struct.file, %struct.file* %3, i32 0, i32 0
  %5 = load i32, i32* %4, align 8
  %6 = icmp sgt i32 %5, 0
  br i1 %6, label %7, label %12

7:                                                ; preds = %1
  %8 = load %struct.file*, %struct.file** %2, align 8
  %9 = getelementptr inbounds %struct.file, %struct.file* %8, i32 0, i32 0
  %10 = load i32, i32* %9, align 8
  %11 = add nsw i32 %10, -1
  store i32 %11, i32* %9, align 8
  br label %12

12:                                               ; preds = %7, %1
  %13 = load %struct.file*, %struct.file** %2, align 8
  %14 = getelementptr inbounds %struct.file, %struct.file* %13, i32 0, i32 0
  %15 = load i32, i32* %14, align 8
  %16 = icmp eq i32 %15, 0
  br i1 %16, label %17, label %23

17:                                               ; preds = %12
  %18 = load %struct.file*, %struct.file** %2, align 8
  %19 = getelementptr inbounds %struct.file, %struct.file* %18, i32 0, i32 2
  %20 = load i8*, i8** %19, align 8
  call void @free(i8* noundef %20) #6
  %21 = load %struct.file*, %struct.file** %2, align 8
  %22 = bitcast %struct.file* %21 to i8*
  call void @free(i8* noundef %22) #6
  br label %23

23:                                               ; preds = %17, %12
  ret void
}

; Function Attrs: nounwind
declare void @free(i8* noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @ctf_file_read(%struct.file* noundef %0, i32 noundef %1) #0 {
  %3 = alloca %struct.file*, align 8
  %4 = alloca i32, align 4
  store %struct.file* %0, %struct.file** %3, align 8
  store i32 %1, i32* %4, align 4
  %5 = load i32, i32* %4, align 4
  %6 = load %struct.file*, %struct.file** %3, align 8
  %7 = getelementptr inbounds %struct.file, %struct.file* %6, i32 0, i32 1
  %8 = load i32, i32* %7, align 4
  %9 = icmp sgt i32 %5, %8
  br i1 %9, label %10, label %14

10:                                               ; preds = %2
  %11 = load %struct.file*, %struct.file** %3, align 8
  %12 = getelementptr inbounds %struct.file, %struct.file* %11, i32 0, i32 1
  %13 = load i32, i32* %12, align 4
  store i32 %13, i32* %4, align 4
  br label %14

14:                                               ; preds = %10, %2
  %15 = load i32, i32* %4, align 4
  %16 = load %struct.file*, %struct.file** %3, align 8
  %17 = getelementptr inbounds %struct.file, %struct.file* %16, i32 0, i32 3
  %18 = getelementptr inbounds [32 x i8], [32 x i8]* %17, i64 0, i64 0
  %19 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([27 x i8], [27 x i8]* @.str, i64 0, i64 0), i32 noundef %15, i8* noundef %18)
  %20 = load %struct.file*, %struct.file** %3, align 8
  %21 = getelementptr inbounds %struct.file, %struct.file* %20, i32 0, i32 2
  %22 = load i8*, i8** %21, align 8
  %23 = load i32, i32* %4, align 4
  %24 = sext i32 %23 to i64
  %25 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8
  %26 = call i64 @fwrite(i8* noundef %22, i64 noundef 1, i64 noundef %24, %struct._IO_FILE* noundef %25)
  %27 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([2 x i8], [2 x i8]* @.str.1, i64 0, i64 0))
  ret void
}

declare i32 @printf(i8* noundef, ...) #2

declare i64 @fwrite(i8* noundef, i64 noundef, i64 noundef, %struct._IO_FILE* noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @ctf_file_write(%struct.file* noundef %0, i32 noundef %1, i8* noundef %2) #0 {
  %4 = alloca %struct.file*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i8*, align 8
  store %struct.file* %0, %struct.file** %4, align 8
  store i32 %1, i32* %5, align 4
  store i8* %2, i8** %6, align 8
  %7 = load i32, i32* %5, align 4
  %8 = icmp sgt i32 %7, 64
  br i1 %8, label %9, label %10

9:                                                ; preds = %3
  store i32 64, i32* %5, align 4
  br label %10

10:                                               ; preds = %9, %3
  %11 = load i32, i32* %5, align 4
  %12 = load %struct.file*, %struct.file** %4, align 8
  %13 = getelementptr inbounds %struct.file, %struct.file* %12, i32 0, i32 1
  %14 = load i32, i32* %13, align 4
  %15 = icmp sgt i32 %11, %14
  br i1 %15, label %16, label %28

16:                                               ; preds = %10
  %17 = load %struct.file*, %struct.file** %4, align 8
  %18 = getelementptr inbounds %struct.file, %struct.file* %17, i32 0, i32 2
  %19 = load i8*, i8** %18, align 8
  %20 = load i32, i32* %5, align 4
  %21 = sext i32 %20 to i64
  %22 = call i8* @realloc(i8* noundef %19, i64 noundef %21) #6
  %23 = load %struct.file*, %struct.file** %4, align 8
  %24 = getelementptr inbounds %struct.file, %struct.file* %23, i32 0, i32 2
  store i8* %22, i8** %24, align 8
  %25 = load i32, i32* %5, align 4
  %26 = load %struct.file*, %struct.file** %4, align 8
  %27 = getelementptr inbounds %struct.file, %struct.file* %26, i32 0, i32 1
  store i32 %25, i32* %27, align 4
  br label %28

28:                                               ; preds = %16, %10
  %29 = load %struct.file*, %struct.file** %4, align 8
  %30 = getelementptr inbounds %struct.file, %struct.file* %29, i32 0, i32 2
  %31 = load i8*, i8** %30, align 8
  %32 = load i8*, i8** %6, align 8
  %33 = load i32, i32* %5, align 4
  %34 = sext i32 %33 to i64
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %31, i8* align 1 %32, i64 %34, i1 false)
  %35 = load i32, i32* %5, align 4
  %36 = load %struct.file*, %struct.file** %4, align 8
  %37 = getelementptr inbounds %struct.file, %struct.file* %36, i32 0, i32 3
  %38 = getelementptr inbounds [32 x i8], [32 x i8]* %37, i64 0, i64 0
  %39 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([24 x i8], [24 x i8]* @.str.2, i64 0, i64 0), i32 noundef %35, i8* noundef %38)
  ret void
}

; Function Attrs: nounwind
declare i8* @realloc(i8* noundef, i64 noundef) #1

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #3

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @ctf_file_dup(%struct.file* noundef %0) #0 {
  %2 = alloca %struct.file*, align 8
  store %struct.file* %0, %struct.file** %2, align 8
  %3 = load %struct.file*, %struct.file** %2, align 8
  %4 = getelementptr inbounds %struct.file, %struct.file* %3, i32 0, i32 0
  %5 = load i32, i32* %4, align 8
  %6 = add nsw i32 %5, 1
  store i32 %6, i32* %4, align 8
  %7 = load %struct.file*, %struct.file** %2, align 8
  %8 = getelementptr inbounds %struct.file, %struct.file* %7, i32 0, i32 3
  %9 = getelementptr inbounds [32 x i8], [32 x i8]* %8, i64 0, i64 0
  %10 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([16 x i8], [16 x i8]* @.str.3, i64 0, i64 0), i8* noundef %9)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.file* @create_file(i8* noundef %0) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca %struct.file*, align 8
  store i8* %0, i8** %2, align 8
  %4 = call noalias i8* @calloc(i64 noundef 1, i64 noundef 80) #6
  %5 = bitcast i8* %4 to %struct.file*
  store %struct.file* %5, %struct.file** %3, align 8
  %6 = load %struct.file*, %struct.file** %3, align 8
  %7 = getelementptr inbounds %struct.file, %struct.file* %6, i32 0, i32 0
  store i32 1, i32* %7, align 8
  %8 = load %struct.file*, %struct.file** %3, align 8
  %9 = getelementptr inbounds %struct.file, %struct.file* %8, i32 0, i32 1
  store i32 0, i32* %9, align 4
  %10 = load %struct.file*, %struct.file** %3, align 8
  %11 = getelementptr inbounds %struct.file, %struct.file* %10, i32 0, i32 2
  store i8* null, i8** %11, align 8
  %12 = load %struct.file*, %struct.file** %3, align 8
  %13 = getelementptr inbounds %struct.file, %struct.file* %12, i32 0, i32 3
  %14 = getelementptr inbounds [32 x i8], [32 x i8]* %13, i64 0, i64 0
  %15 = load i8*, i8** %2, align 8
  %16 = call i8* @strncpy(i8* noundef %14, i8* noundef %15, i64 noundef 31) #6
  %17 = load %struct.file*, %struct.file** %3, align 8
  %18 = getelementptr inbounds %struct.file, %struct.file* %17, i32 0, i32 4
  %19 = bitcast {}** %18 to void (%struct.file*)**
  store void (%struct.file*)* @ctf_file_close, void (%struct.file*)** %19, align 8
  %20 = load %struct.file*, %struct.file** %3, align 8
  %21 = getelementptr inbounds %struct.file, %struct.file* %20, i32 0, i32 5
  store void (%struct.file*, i32)* @ctf_file_read, void (%struct.file*, i32)** %21, align 8
  %22 = load %struct.file*, %struct.file** %3, align 8
  %23 = getelementptr inbounds %struct.file, %struct.file* %22, i32 0, i32 6
  store void (%struct.file*, i32, i8*)* @ctf_file_write, void (%struct.file*, i32, i8*)** %23, align 8
  %24 = load %struct.file*, %struct.file** %3, align 8
  %25 = getelementptr inbounds %struct.file, %struct.file* %24, i32 0, i32 7
  %26 = bitcast {}** %25 to void (%struct.file*)**
  store void (%struct.file*)* @ctf_file_dup, void (%struct.file*)** %26, align 8
  %27 = load %struct.file*, %struct.file** %3, align 8
  ret %struct.file* %27
}

; Function Attrs: nounwind
declare noalias i8* @calloc(i64 noundef, i64 noundef) #1

; Function Attrs: nounwind
declare i8* @strncpy(i8* noundef, i8* noundef, i64 noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @find_empty_slot() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 0, i32* %2, align 4
  br label %3

3:                                                ; preds = %15, %0
  %4 = load i32, i32* %2, align 4
  %5 = icmp slt i32 %4, 16
  br i1 %5, label %6, label %18

6:                                                ; preds = %3
  %7 = load i32, i32* %2, align 4
  %8 = sext i32 %7 to i64
  %9 = getelementptr inbounds [16 x %struct.file*], [16 x %struct.file*]* @files, i64 0, i64 %8
  %10 = load %struct.file*, %struct.file** %9, align 8
  %11 = icmp eq %struct.file* %10, null
  br i1 %11, label %12, label %14

12:                                               ; preds = %6
  %13 = load i32, i32* %2, align 4
  store i32 %13, i32* %1, align 4
  br label %19

14:                                               ; preds = %6
  br label %15

15:                                               ; preds = %14
  %16 = load i32, i32* %2, align 4
  %17 = add nsw i32 %16, 1
  store i32 %17, i32* %2, align 4
  br label %3, !llvm.loop !6

18:                                               ; preds = %3
  store i32 -1, i32* %1, align 4
  br label %19

19:                                               ; preds = %18, %12
  %20 = load i32, i32* %1, align 4
  ret i32 %20
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @find_file_by_name(i8* noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i8*, align 8
  %4 = alloca i32, align 4
  store i8* %0, i8** %3, align 8
  store i32 0, i32* %4, align 4
  br label %5

5:                                                ; preds = %27, %1
  %6 = load i32, i32* %4, align 4
  %7 = icmp slt i32 %6, 16
  br i1 %7, label %8, label %30

8:                                                ; preds = %5
  %9 = load i32, i32* %4, align 4
  %10 = sext i32 %9 to i64
  %11 = getelementptr inbounds [16 x %struct.file*], [16 x %struct.file*]* @files, i64 0, i64 %10
  %12 = load %struct.file*, %struct.file** %11, align 8
  %13 = icmp ne %struct.file* %12, null
  br i1 %13, label %14, label %26

14:                                               ; preds = %8
  %15 = load i32, i32* %4, align 4
  %16 = sext i32 %15 to i64
  %17 = getelementptr inbounds [16 x %struct.file*], [16 x %struct.file*]* @files, i64 0, i64 %16
  %18 = load %struct.file*, %struct.file** %17, align 8
  %19 = getelementptr inbounds %struct.file, %struct.file* %18, i32 0, i32 3
  %20 = getelementptr inbounds [32 x i8], [32 x i8]* %19, i64 0, i64 0
  %21 = load i8*, i8** %3, align 8
  %22 = call i32 @strcmp(i8* noundef %20, i8* noundef %21) #7
  %23 = icmp eq i32 %22, 0
  br i1 %23, label %24, label %26

24:                                               ; preds = %14
  %25 = load i32, i32* %4, align 4
  store i32 %25, i32* %2, align 4
  br label %31

26:                                               ; preds = %14, %8
  br label %27

27:                                               ; preds = %26
  %28 = load i32, i32* %4, align 4
  %29 = add nsw i32 %28, 1
  store i32 %29, i32* %4, align 4
  br label %5, !llvm.loop !8

30:                                               ; preds = %5
  store i32 -1, i32* %2, align 4
  br label %31

31:                                               ; preds = %30, %24
  %32 = load i32, i32* %2, align 4
  ret i32 %32
}

; Function Attrs: nounwind readonly willreturn
declare i32 @strcmp(i8* noundef, i8* noundef) #4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @create(i8* noundef %0) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca i32, align 4
  %4 = alloca %struct.file*, align 8
  store i8* %0, i8** %2, align 8
  %5 = call i32 @find_empty_slot()
  store i32 %5, i32* %3, align 4
  %6 = load i32, i32* %3, align 4
  %7 = icmp eq i32 %6, -1
  br i1 %7, label %8, label %10

8:                                                ; preds = %1
  %9 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([25 x i8], [25 x i8]* @.str.4, i64 0, i64 0))
  br label %20

10:                                               ; preds = %1
  %11 = load i8*, i8** %2, align 8
  %12 = call %struct.file* @create_file(i8* noundef %11)
  store %struct.file* %12, %struct.file** %4, align 8
  %13 = load %struct.file*, %struct.file** %4, align 8
  %14 = load i32, i32* %3, align 4
  %15 = sext i32 %14 to i64
  %16 = getelementptr inbounds [16 x %struct.file*], [16 x %struct.file*]* @files, i64 0, i64 %15
  store %struct.file* %13, %struct.file** %16, align 8
  %17 = load i8*, i8** %2, align 8
  %18 = load i32, i32* %3, align 4
  %19 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([28 x i8], [28 x i8]* @.str.5, i64 0, i64 0), i8* noundef %17, i32 noundef %18)
  br label %20

20:                                               ; preds = %10, %8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @close(i8* noundef %0) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca i32, align 4
  %4 = alloca %struct.file*, align 8
  store i8* %0, i8** %2, align 8
  %5 = load i8*, i8** %2, align 8
  %6 = call i32 @find_file_by_name(i8* noundef %5)
  store i32 %6, i32* %3, align 4
  %7 = load i32, i32* %3, align 4
  %8 = icmp eq i32 %7, -1
  br i1 %8, label %9, label %12

9:                                                ; preds = %1
  %10 = load i8*, i8** %2, align 8
  %11 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([17 x i8], [17 x i8]* @.str.6, i64 0, i64 0), i8* noundef %10)
  br label %25

12:                                               ; preds = %1
  %13 = load i32, i32* %3, align 4
  %14 = sext i32 %13 to i64
  %15 = getelementptr inbounds [16 x %struct.file*], [16 x %struct.file*]* @files, i64 0, i64 %14
  %16 = load %struct.file*, %struct.file** %15, align 8
  store %struct.file* %16, %struct.file** %4, align 8
  %17 = load %struct.file*, %struct.file** %4, align 8
  %18 = getelementptr inbounds %struct.file, %struct.file* %17, i32 0, i32 4
  %19 = bitcast {}** %18 to void (%struct.file*)**
  %20 = load void (%struct.file*)*, void (%struct.file*)** %19, align 8
  %21 = load %struct.file*, %struct.file** %4, align 8
  call void %20(%struct.file* noundef %21)
  %22 = load i8*, i8** %2, align 8
  %23 = load i32, i32* %3, align 4
  %24 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([27 x i8], [27 x i8]* @.str.7, i64 0, i64 0), i8* noundef %22, i32 noundef %23)
  br label %25

25:                                               ; preds = %12, %9
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @dup(i8* noundef %0) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca i32, align 4
  %4 = alloca %struct.file*, align 8
  store i8* %0, i8** %2, align 8
  %5 = load i8*, i8** %2, align 8
  %6 = call i32 @find_file_by_name(i8* noundef %5)
  store i32 %6, i32* %3, align 4
  %7 = load i32, i32* %3, align 4
  %8 = icmp eq i32 %7, -1
  br i1 %8, label %9, label %12

9:                                                ; preds = %1
  %10 = load i8*, i8** %2, align 8
  %11 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([17 x i8], [17 x i8]* @.str.6, i64 0, i64 0), i8* noundef %10)
  br label %22

12:                                               ; preds = %1
  %13 = load i32, i32* %3, align 4
  %14 = sext i32 %13 to i64
  %15 = getelementptr inbounds [16 x %struct.file*], [16 x %struct.file*]* @files, i64 0, i64 %14
  %16 = load %struct.file*, %struct.file** %15, align 8
  store %struct.file* %16, %struct.file** %4, align 8
  %17 = load %struct.file*, %struct.file** %4, align 8
  %18 = getelementptr inbounds %struct.file, %struct.file* %17, i32 0, i32 7
  %19 = bitcast {}** %18 to void (%struct.file*)**
  %20 = load void (%struct.file*)*, void (%struct.file*)** %19, align 8
  %21 = load %struct.file*, %struct.file** %4, align 8
  call void %20(%struct.file* noundef %21)
  br label %22

22:                                               ; preds = %12, %9
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @read(i8* noundef %0, i32 noundef %1) #0 {
  %3 = alloca i8*, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca %struct.file*, align 8
  store i8* %0, i8** %3, align 8
  store i32 %1, i32* %4, align 4
  %7 = load i8*, i8** %3, align 8
  %8 = call i32 @find_file_by_name(i8* noundef %7)
  store i32 %8, i32* %5, align 4
  %9 = load i32, i32* %5, align 4
  %10 = icmp eq i32 %9, -1
  br i1 %10, label %11, label %14

11:                                               ; preds = %2
  %12 = load i8*, i8** %3, align 8
  %13 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([17 x i8], [17 x i8]* @.str.6, i64 0, i64 0), i8* noundef %12)
  br label %24

14:                                               ; preds = %2
  %15 = load i32, i32* %5, align 4
  %16 = sext i32 %15 to i64
  %17 = getelementptr inbounds [16 x %struct.file*], [16 x %struct.file*]* @files, i64 0, i64 %16
  %18 = load %struct.file*, %struct.file** %17, align 8
  store %struct.file* %18, %struct.file** %6, align 8
  %19 = load %struct.file*, %struct.file** %6, align 8
  %20 = getelementptr inbounds %struct.file, %struct.file* %19, i32 0, i32 5
  %21 = load void (%struct.file*, i32)*, void (%struct.file*, i32)** %20, align 8
  %22 = load %struct.file*, %struct.file** %6, align 8
  %23 = load i32, i32* %4, align 4
  call void %21(%struct.file* noundef %22, i32 noundef %23)
  br label %24

24:                                               ; preds = %14, %11
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @write(i8* noundef %0, i32 noundef %1, i8* noundef %2) #0 {
  %4 = alloca i8*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i8*, align 8
  %7 = alloca i32, align 4
  %8 = alloca %struct.file*, align 8
  store i8* %0, i8** %4, align 8
  store i32 %1, i32* %5, align 4
  store i8* %2, i8** %6, align 8
  %9 = load i8*, i8** %4, align 8
  %10 = call i32 @find_file_by_name(i8* noundef %9)
  store i32 %10, i32* %7, align 4
  %11 = load i32, i32* %7, align 4
  %12 = icmp eq i32 %11, -1
  br i1 %12, label %13, label %16

13:                                               ; preds = %3
  %14 = load i8*, i8** %4, align 8
  %15 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([17 x i8], [17 x i8]* @.str.6, i64 0, i64 0), i8* noundef %14)
  br label %27

16:                                               ; preds = %3
  %17 = load i32, i32* %7, align 4
  %18 = sext i32 %17 to i64
  %19 = getelementptr inbounds [16 x %struct.file*], [16 x %struct.file*]* @files, i64 0, i64 %18
  %20 = load %struct.file*, %struct.file** %19, align 8
  store %struct.file* %20, %struct.file** %8, align 8
  %21 = load %struct.file*, %struct.file** %8, align 8
  %22 = getelementptr inbounds %struct.file, %struct.file* %21, i32 0, i32 6
  %23 = load void (%struct.file*, i32, i8*)*, void (%struct.file*, i32, i8*)** %22, align 8
  %24 = load %struct.file*, %struct.file** %8, align 8
  %25 = load i32, i32* %5, align 4
  %26 = load i8*, i8** %6, align 8
  call void %23(%struct.file* noundef %24, i32 noundef %25, i8* noundef %26)
  br label %27

27:                                               ; preds = %16, %13
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @menu() #0 {
  %1 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([33 x i8], [33 x i8]* @.str.8, i64 0, i64 0))
  %2 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([11 x i8], [11 x i8]* @.str.9, i64 0, i64 0))
  %3 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([15 x i8], [15 x i8]* @.str.10, i64 0, i64 0))
  %4 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([14 x i8], [14 x i8]* @.str.11, i64 0, i64 0))
  %5 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([12 x i8], [12 x i8]* @.str.12, i64 0, i64 0))
  %6 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([17 x i8], [17 x i8]* @.str.13, i64 0, i64 0))
  %7 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([25 x i8], [25 x i8]* @.str.14, i64 0, i64 0))
  %8 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([6 x i8], [6 x i8]* @.str.15, i64 0, i64 0))
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @handle_command(i8* noundef %0) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca i8*, align 8
  %4 = alloca i8*, align 8
  %5 = alloca i32, align 4
  store i8* %0, i8** %2, align 8
  %6 = load i8*, i8** %2, align 8
  %7 = call i32 (i8*, i8*, ...) @__isoc99_sscanf(i8* noundef %6, i8* noundef getelementptr inbounds ([11 x i8], [11 x i8]* @.str.16, i64 0, i64 0), i8** noundef %3) #6
  %8 = icmp eq i32 %7, 1
  br i1 %8, label %9, label %12

9:                                                ; preds = %1
  %10 = load i8*, i8** %3, align 8
  call void @create(i8* noundef %10)
  %11 = load i8*, i8** %3, align 8
  call void @free(i8* noundef %11) #6
  br label %56

12:                                               ; preds = %1
  %13 = load i8*, i8** %2, align 8
  %14 = call i32 (i8*, i8*, ...) @__isoc99_sscanf(i8* noundef %13, i8* noundef getelementptr inbounds ([10 x i8], [10 x i8]* @.str.17, i64 0, i64 0), i8** noundef %3) #6
  %15 = icmp eq i32 %14, 1
  br i1 %15, label %16, label %19

16:                                               ; preds = %12
  %17 = load i8*, i8** %3, align 8
  call void @close(i8* noundef %17)
  %18 = load i8*, i8** %3, align 8
  call void @free(i8* noundef %18) #6
  br label %55

19:                                               ; preds = %12
  %20 = load i8*, i8** %2, align 8
  %21 = call i32 (i8*, i8*, ...) @__isoc99_sscanf(i8* noundef %20, i8* noundef getelementptr inbounds ([8 x i8], [8 x i8]* @.str.18, i64 0, i64 0), i8** noundef %3) #6
  %22 = icmp eq i32 %21, 1
  br i1 %22, label %23, label %26

23:                                               ; preds = %19
  %24 = load i8*, i8** %3, align 8
  call void @dup(i8* noundef %24)
  %25 = load i8*, i8** %3, align 8
  call void @free(i8* noundef %25) #6
  br label %54

26:                                               ; preds = %19
  %27 = load i8*, i8** %2, align 8
  %28 = call i32 (i8*, i8*, ...) @__isoc99_sscanf(i8* noundef %27, i8* noundef getelementptr inbounds ([12 x i8], [12 x i8]* @.str.19, i64 0, i64 0), i8** noundef %3, i32* noundef %5) #6
  %29 = icmp eq i32 %28, 2
  br i1 %29, label %30, label %34

30:                                               ; preds = %26
  %31 = load i8*, i8** %3, align 8
  %32 = load i32, i32* %5, align 4
  call void @read(i8* noundef %31, i32 noundef %32)
  %33 = load i8*, i8** %3, align 8
  call void @free(i8* noundef %33) #6
  br label %53

34:                                               ; preds = %26
  %35 = load i8*, i8** %2, align 8
  %36 = call i32 (i8*, i8*, ...) @__isoc99_sscanf(i8* noundef %35, i8* noundef getelementptr inbounds ([17 x i8], [17 x i8]* @.str.20, i64 0, i64 0), i8** noundef %3, i32* noundef %5, i8** noundef %4) #6
  %37 = icmp eq i32 %36, 3
  br i1 %37, label %38, label %44

38:                                               ; preds = %34
  %39 = load i8*, i8** %3, align 8
  %40 = load i32, i32* %5, align 4
  %41 = load i8*, i8** %4, align 8
  call void @write(i8* noundef %39, i32 noundef %40, i8* noundef %41)
  %42 = load i8*, i8** %3, align 8
  call void @free(i8* noundef %42) #6
  %43 = load i8*, i8** %4, align 8
  call void @free(i8* noundef %43) #6
  br label %52

44:                                               ; preds = %34
  %45 = load i8*, i8** %2, align 8
  %46 = call i32 @strcmp(i8* noundef %45, i8* noundef getelementptr inbounds ([5 x i8], [5 x i8]* @.str.21, i64 0, i64 0)) #7
  %47 = icmp eq i32 %46, 0
  br i1 %47, label %48, label %49

48:                                               ; preds = %44
  call void @exit(i32 noundef 0) #8
  unreachable

49:                                               ; preds = %44
  %50 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([17 x i8], [17 x i8]* @.str.22, i64 0, i64 0))
  br label %51

51:                                               ; preds = %49
  br label %52

52:                                               ; preds = %51, %38
  br label %53

53:                                               ; preds = %52, %30
  br label %54

54:                                               ; preds = %53, %23
  br label %55

55:                                               ; preds = %54, %16
  br label %56

56:                                               ; preds = %55, %9
  ret void
}

; Function Attrs: nounwind
declare i32 @__isoc99_sscanf(i8* noundef, i8* noundef, ...) #1

; Function Attrs: noreturn nounwind
declare void @exit(i32 noundef) #5

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [256 x i8], align 16
  store i32 0, i32* %1, align 4
  %3 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8
  %4 = call i32 @setvbuf(%struct._IO_FILE* noundef %3, i8* noundef null, i32 noundef 2, i64 noundef 0) #6
  call void @menu()
  br label %5

5:                                                ; preds = %0, %5
  %6 = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([3 x i8], [3 x i8]* @.str.23, i64 0, i64 0))
  %7 = getelementptr inbounds [256 x i8], [256 x i8]* %2, i64 0, i64 0
  %8 = load %struct._IO_FILE*, %struct._IO_FILE** @stdin, align 8
  %9 = call i8* @fgets(i8* noundef %7, i32 noundef 256, %struct._IO_FILE* noundef %8)
  %10 = getelementptr inbounds [256 x i8], [256 x i8]* %2, i64 0, i64 0
  %11 = call i64 @strcspn(i8* noundef %10, i8* noundef getelementptr inbounds ([2 x i8], [2 x i8]* @.str.1, i64 0, i64 0)) #7
  %12 = getelementptr inbounds [256 x i8], [256 x i8]* %2, i64 0, i64 %11
  store i8 0, i8* %12, align 1
  %13 = getelementptr inbounds [256 x i8], [256 x i8]* %2, i64 0, i64 0
  call void @handle_command(i8* noundef %13)
  br label %5
}

; Function Attrs: nounwind
declare i32 @setvbuf(%struct._IO_FILE* noundef, i8* noundef, i32 noundef, i64 noundef) #1

declare i8* @fgets(i8* noundef, i32 noundef, %struct._IO_FILE* noundef) #2

; Function Attrs: nounwind readonly willreturn
declare i64 @strcspn(i8* noundef, i8* noundef) #4

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { argmemonly nofree nounwind willreturn }
attributes #4 = { nounwind readonly willreturn "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { noreturn nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nounwind }
attributes #7 = { nounwind readonly willreturn }
attributes #8 = { noreturn nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
