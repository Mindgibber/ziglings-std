//
//


const std = @import("std");
const heap = std.heap;

const SomeImportantHeapObject = struct {
    a: i128,
    b: u128,
};

pub fn main() !void {
    // First create an object of the page allocator
    // important to note is how the page allocator is structured:
    //
    // pub const page_allocator = if (builtin.target.isWasm())
    //     Allocator{
    //         .ptr = undefined,
    //         .vtable = &WasmPageAllocator.vtable,
    //     }
    // else if (builtin.target.os.tag == .freestanding)
    //     root.os.heap.page_allocator
    // else
    //     Allocator{
    //         .ptr = undefined,
    //         .vtable = &PageAllocator.vtable,
    //     };
    //
    // as we can see in the implementation of the page allocator, 
    // it changes its behavior depending on the target platform.
    const pa = heap.page_allocator;

    // Get the allocator instance
    var allocator = pa.allocator();

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