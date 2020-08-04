// RUN: mlir-opt -convert-std-to-llvm %s -split-input-file | FileCheck %s

// CHECK-LABEL: func @mlir_cast_to_llvm
// CHECK-SAME: %[[ARG1:[^,]*]]:
// CHECK-SAME: %[[ARG2:[^,]*]]:
// CHECK-SAME: %[[ARG3:[^,]*]]:
// CHECK-SAME: %[[ARG4:[^,]*]]:
// CHECK-SAME: %[[ARG5:[^,]*]]:
// CHECK-SAME: %[[ARG6:[^,]*]]:
// CHECK-SAME: %[[ARG7:[^,]*]]:
func @mlir_cast_to_llvm(%0 : memref<3x4xf32>) -> !llvm<"{ float*, float*, i64, [2 x i64], [2 x i64] }"> {
  %1 = llvm.mlir.cast %0 : memref<3x4xf32> to !llvm<"{ float*, float*, i64, [2 x i64], [2 x i64] }">
  // CHECK-NEXT: llvm.mlir.undef : !llvm<"{ float*, float*, i64, [2 x i64], [2 x i64] }">
  // CHECK-NEXT: llvm.insertvalue %[[ARG1]]
  // CHECK-NEXT: llvm.insertvalue %[[ARG2]]
  // CHECK-NEXT: llvm.insertvalue %[[ARG3]]
  // CHECK-NEXT: llvm.insertvalue %[[ARG4]]
  // CHECK-NEXT: llvm.insertvalue %[[ARG6]]
  // CHECK-NEXT: llvm.insertvalue %[[ARG5]]
  // CHECK-NEXT: %[[RES:.*]] = llvm.insertvalue %[[ARG7]]
  // CHECK-NEXT: llvm.return %[[RES]]
  return %1 : !llvm<"{ float*, float*, i64, [2 x i64], [2 x i64] }">
}

// CHECK-LABEL: func @mlir_cast_from_llvm
// CHECK-SAME: %[[ARG:.*]]:
func @mlir_cast_from_llvm(%0 : !llvm<"{ float*, float*, i64, [2 x i64], [2 x i64] }">) -> memref<3x4xf32> {
  %1 = llvm.mlir.cast %0 : !llvm<"{ float*, float*, i64, [2 x i64], [2 x i64] }"> to memref<3x4xf32>
  // CHECK-NEXT: llvm.return %[[ARG]]
  return %1 : memref<3x4xf32>
}
