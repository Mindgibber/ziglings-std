// In Zig allocations are handled natively different than in most languages,
// as you can see allocators have to be specifically chosen for each allocation.

// Once such allocator would be the General Purpose Allocator, which is a 'safe' allocator,
// and can prevent double-free, use-after-free and can also detect leaks.


// This General Purpose Allocator can also be configured with the following parameters of the config struct below:
// pub const Config = struct {
//     stack_trace_frames: usize = default_stack_trace_frames,
//     enable_memory_limit: bool = false,
//     safety: bool = std.debug.runtime_safety,
//     thread_safe: bool = !builtin.single_threaded,
//     MutexType: ?type = null,
//     never_unmap: bool = false,
//     retain_metadata: bool = false,
//     verbose_log: bool = false,
// };

const std = @import("std");
const heap = std.heap;

const SomeImportantHeapObject = struct {
    a: i128,
    b: u128,
};

pub fn main() !void {
    // First create an object of the General Purpose Allocator
    const gpa = heap.GeneralPurposeAllocator(.{}){};

    // Get the allocator instance
    var allocator = gpa.allocator();

    // Allocate our important heap object
    var heap_object = allocator.create(SomeImportantHeapObject);

    // Defer the free call for the heap object
    defer allocator.destroy();

    // Derefence the heap object and initialize the struct
    heap_object.* = .{
        .a = 1,
        .b = 2,
    };
}