usingnamespace @import("types.zig");
usingnamespace @import("vec2d.zig");
usingnamespace @import("point.zig");

const Circle = struct {
    center: Point,
    radius: real,

    pub fn inside(c: Circle, p: Point) bool {
        return p.sub(c.center).len() < c.radius;
    }

    pub fn intersectCircle(c: Circle, k: Circle) bool {
        return c.center.sub(k.center).len() < c.radius + k.radius;
    }

    const Self = @This();

    pub fn format(
        circle: Self,
        comptime fmt: []const u8,
        options: std.fmt.FormatOptions,
        writer: anytype,
    ) !void {
        try writer.print("Circle({}, {d})", .{ circle.center, circle.radius });
    }
};

pub fn circle(center: Point, radius: real) Circle {
    return Circle{ .center = center, .radius = radius };
}

test "Circle intersections" {
    const c1 = circle(point(1, 1), 4);
    const c2 = circle(point(2, 1), 4);
    const c3 = circle(point(10, 1), 4);
    const c4 = circle(point(9, 1), 4);

    expect(c1.intersectCircle(c2));
    expect(!c1.intersectCircle(c3));
    expect(!c1.intersectCircle(c4));
}
