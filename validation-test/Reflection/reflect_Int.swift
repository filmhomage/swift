// RUN: rm -rf %t && mkdir -p %t
// RUN: %target-build-swift -lswiftSwiftReflectionTest %s -o %t/reflect_Int
// RUN: %target-run %target-swift-reflection-test %t/reflect_Int 2>&1 | FileCheck %s --check-prefix=CHECK-%target-ptrsize
// REQUIRES: objc_interop

import SwiftReflectionTest

class TestClass {
    var t: Int
    init(t: Int) {
        self.t = t
    }
}

var obj = TestClass(t: 123)

reflect(object: obj)

// CHECK-64: Reflecting an object.
// CHECK-64: Instance pointer in child address space: 0x{{[0-9a-fA-F]+}}
// CHECK-64: Type reference:
// CHECK-64: (class reflect_Int.TestClass)

// CHECK-64: Type info:
// CHECK-64: (class_instance size=24 alignment=16 stride=32 num_extra_inhabitants=0
// CHECK-64:   (field name=t offset=16
// CHECK-64:     (struct size=8 alignment=8 stride=8 num_extra_inhabitants=0
// CHECK-64:       (field name=_value offset=0
// CHECK-64:         (builtin size=8 alignment=8 stride=8 num_extra_inhabitants=0)))))

// CHECK-32: Reflecting an object.
// CHECK-32: Instance pointer in child address space: 0x{{[0-9a-fA-F]+}}
// CHECK-32: Type reference:
// CHECK-32: (class reflect_Int.TestClass)

// CHECK-32: Type info:
// CHECK-32: (class_instance size=16 alignment=16 stride=16 num_extra_inhabitants=0
// CHECK-32:   (field name=t offset=12
// CHECK-32:     (struct size=4 alignment=4 stride=4 num_extra_inhabitants=0
// CHECK-32:       (field name=_value offset=0
// CHECK-32:         (builtin size=4 alignment=4 stride=4 num_extra_inhabitants=0)))))

reflect(any: obj)

// CHECK-64: Reflecting an existential.
// CHECK-64: Instance pointer in child address space: 0x{{[0-9a-fA-F]+}}
// CHECK-64: Type reference:
// CHECK-64: (class reflect_Int.TestClass)

// CHECK-64: Type info:
// CHECK-64: (reference kind=strong refcounting=native)

// CHECK-32: Reflecting an existential.
// CHECK-32: Instance pointer in child address space: 0x{{[0-9a-fA-F]+}}
// CHECK-32: Type reference:
// CHECK-32: (class reflect_Int.TestClass)

// CHECK-32: Type info:
// CHECK-32: (reference kind=strong refcounting=native)

doneReflecting()

// CHECK-64: Done.

// CHECK-32: Done.
