//
//

const std = @import("std");
const heap = std.heap;

const SomeImportantHeapObject = struct {
    a: i128,
    b: u128,
};

pub fn main() !void {
    // Create the buffer (in this case, a stack allocated buffer)
    // Hint: @sizeof is a fairly useful function :)
    var buffer: u8[_]{0} ** ;
    
    // Initiate the FixedBufferAllocator
    const fba = heap.FixedBufferAllocator.init(&buffer);

    // Get the allocator instance
    var allocator = fba.allocator();

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