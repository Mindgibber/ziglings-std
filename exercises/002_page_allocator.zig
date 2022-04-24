//

const std = @import("std");
const heap = std.heap;

const SomeImportantHeapObject = struct {
    a: i128,
    b: u128,
};

pub fn main() !void {
    // First create an object of the page allocator
    const pa = heap.page_allocator;

    // Get the allocator instance
    const allocator = pa.allocator();

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