const std = @import("std");
const expect = std.testing.expect;

const real = f32;

const Vec2D = struct {
    dx: real = 0,
    dy: real = 0,

    const Self = @This();

    fn add(u: Vec2D, v: Vec2D) Vec2D {
        return vec2D(u.dx + v.dx, u.dy + v.dy);
    }

    fn eq(u: Vec2D, v: Vec2D) bool {
        return u.dx == v.dx and u.dy == v.dy;
    }

    pub fn format(
        p: Self,
        comptime fmt: []const u8,
        options: std.fmt.FormatOptions,
        writer: anytype,
    ) !void {
        try writer.print("Vec2D({d}, {d})", .{ p.dx, p.dy });
    }
};

fn vec2D(x: real, y: real) Vec2D {
    return Vec2D{ .dx = x, .dy = y };
}

const stdout = &std.io.getStdOut().outStream();

test "Adding Vec2D" {
    var u = vec2D(3, 4);
    var v = vec2D(1, -1);

    var w = u.add(v);
    const expected = vec2D(4, 3);

    expect(w.eq(expected));
}
