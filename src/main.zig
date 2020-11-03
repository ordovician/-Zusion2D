const std = @import("std");
usingnamespace @import("vec2d.zig");

pub fn main() anyerror!void {
    const stdout = &std.io.getStdOut().outStream();

    std.log.info("All your codebase are belong to us.", .{});

    const v = vec2D(2, 3);
    try stdout.print("v: {}\n", .{v});
}
