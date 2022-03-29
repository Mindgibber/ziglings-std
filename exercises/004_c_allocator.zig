//
//

const std = @import("std");
const heap = std.heap;

const SomeImportantHeapObject = struct {
    a: i128,
    b: u128,
};

pub fn main() !void {
    // Initiate the C Allocator
    const allocator = heap.c_allocator;

    // Allocate our important heap object
    var heap_object = allocator.create(SomeImportantHeapObject);

    // Register the free call for the heap object
    defer allocator.destroy();

    // Derefence the heap object and initialize the struct
    heap_object.* = .{
        .a = 1,
        .b = 2,
    };
}