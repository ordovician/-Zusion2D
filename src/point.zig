usingnamespace @import("types.zig");
usingnamespace @import("vec2d.zig");

pub const Point = struct {
    x: real = 0,
    y: real = 0,

    pub fn add(p: Point, v: Vec2D) Point {
        return point(p.x + v.dx, p.y + v.dy);
    }

    pub fn sub(p: Point, q: Point) Vec2D {
        return vec2D(p.x - q.x, p.y - q.y);
    }

    pub fn eq(p: Point, q: Point) bool {
        return math.approxEq(real, p.x, q.x, epsilon) and
            math.approxEq(real, p.y, q.y, epsilon);
    }

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

pub fn point(x: real, y: real) Point {
    return Point{ .x = x, .y = y };
}

test "Adding Point" {
    const p = point(5, 4);
    const v = vec2D(3, 1);

    expect(p.add(v).eq(point(8, 5)));
}

test "Subtracting Point" {
    const p = point(5, 4);
    const q = point(3, 1);

    expect(p.sub(q).eq(vec2D(2, 3)));
}
