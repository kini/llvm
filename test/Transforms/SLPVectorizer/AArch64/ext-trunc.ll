; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -slp-vectorizer -mtriple=aarch64--linux-gnu < %s | FileCheck %s

target datalayout = "e-m:e-i32:64-i128:128-n32:64-S128"

declare void @foo(i64, i64, i64, i64)

define void @test(<4 x i16> %a, <4 x i16> %b, i64* %p) {
; Make sure types of sub and its sources are not extended.
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[Z0:%.*]] = zext <4 x i16> [[A:%.*]] to <4 x i32>
; CHECK-NEXT:    [[Z1:%.*]] = zext <4 x i16> [[B:%.*]] to <4 x i32>
; CHECK-NEXT:    [[SUB0:%.*]] = sub <4 x i32> [[Z0]], [[Z1]]
; CHECK-NEXT:    [[TMP0:%.*]] = sext <4 x i32> [[SUB0]] to <4 x i64>
; CHECK-NEXT:    [[TMP1:%.*]] = trunc <4 x i64> [[TMP0]] to <4 x i32>
; CHECK-NEXT:    [[TMP2:%.*]] = extractelement <4 x i32> [[TMP1]], i32 0
; CHECK-NEXT:    [[TMP3:%.*]] = sext i32 [[TMP2]] to i64
; CHECK-NEXT:    [[GEP0:%.*]] = getelementptr inbounds i64, i64* [[P:%.*]], i64 [[TMP3]]
; CHECK-NEXT:    [[LOAD0:%.*]] = load i64, i64* [[GEP0]]
; CHECK-NEXT:    [[TMP4:%.*]] = extractelement <4 x i32> [[TMP1]], i32 1
; CHECK-NEXT:    [[TMP5:%.*]] = sext i32 [[TMP4]] to i64
; CHECK-NEXT:    [[GEP1:%.*]] = getelementptr inbounds i64, i64* [[P]], i64 [[TMP5]]
; CHECK-NEXT:    [[LOAD1:%.*]] = load i64, i64* [[GEP1]]
; CHECK-NEXT:    [[TMP6:%.*]] = extractelement <4 x i32> [[TMP1]], i32 2
; CHECK-NEXT:    [[TMP7:%.*]] = sext i32 [[TMP6]] to i64
; CHECK-NEXT:    [[GEP2:%.*]] = getelementptr inbounds i64, i64* [[P]], i64 [[TMP7]]
; CHECK-NEXT:    [[LOAD2:%.*]] = load i64, i64* [[GEP2]]
; CHECK-NEXT:    [[TMP8:%.*]] = extractelement <4 x i32> [[TMP1]], i32 3
; CHECK-NEXT:    [[TMP9:%.*]] = sext i32 [[TMP8]] to i64
; CHECK-NEXT:    [[GEP3:%.*]] = getelementptr inbounds i64, i64* [[P]], i64 [[TMP9]]
; CHECK-NEXT:    [[LOAD3:%.*]] = load i64, i64* [[GEP3]]
; CHECK-NEXT:    call void @foo(i64 [[LOAD0]], i64 [[LOAD1]], i64 [[LOAD2]], i64 [[LOAD3]])
; CHECK-NEXT:    ret void
;
entry:
  %z0 = zext <4 x i16> %a to <4 x i32>
  %z1 = zext <4 x i16> %b to <4 x i32>
  %sub0 = sub <4 x i32> %z0, %z1
  %e0 = extractelement <4 x i32> %sub0, i32 0
  %s0 = sext i32 %e0 to i64
  %gep0 = getelementptr inbounds i64, i64* %p, i64 %s0
  %load0 = load i64, i64* %gep0
  %e1 = extractelement <4 x i32> %sub0, i32 1
  %s1 = sext i32 %e1 to i64
  %gep1 = getelementptr inbounds i64, i64* %p, i64 %s1
  %load1 = load i64, i64* %gep1
  %e2 = extractelement <4 x i32> %sub0, i32 2
  %s2 = sext i32 %e2 to i64
  %gep2 = getelementptr inbounds i64, i64* %p, i64 %s2
  %load2 = load i64, i64* %gep2
  %e3 = extractelement <4 x i32> %sub0, i32 3
  %s3 = sext i32 %e3 to i64
  %gep3 = getelementptr inbounds i64, i64* %p, i64 %s3
  %load3 = load i64, i64* %gep3
  call void @foo(i64 %load0, i64 %load1, i64 %load2, i64 %load3)
  ret void
}
