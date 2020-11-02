const real = f32;

const Point = struct {
    x: real = 0,
    y: real = 0,

    const Self = @This();

    pub fn format(
        p: Self,
        comptime fmt: []const u8,
        options: std.fmt.FormatOptions,
        writer: anytype,
    ) !void {
        try writer.print("Point({d}, {d})", .{ p.x, p.y });
    }
};
