//
//

const std = @import("std");
const heap = std.heap;

const SomeImportantHeapObject = struct {
    a: i128,
    b: u128,
};

pub fn main() !void {
    // Allocate the buffer on the stack with size of the ImportantHeapObject
    var buffer = u8[_]{0} ** @sizeOf(SomeImportantHeapObject); 

    const fba = heap.FixedBufferAllocator.init(&buffer);

    // Initiate the ArenaAllocator with the FixedBufferAllocator as its child allocator
    const arena = heap.ArenaAllocator.init();

    // Get the allocator instance
    var allocator = arena.allocator();

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