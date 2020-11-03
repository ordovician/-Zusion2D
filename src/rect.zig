usingnamespace @import("types.zig");
usingnamespace @import("point.zig");
usingnamespace @import("vec2d.zig");

const Rect = struct {
    x: real = 0,
    y: real = 0,
    width: real,
    height: real,

    pub fn inside(r: Rect, p: Point) bool {
        return r.x <= p.x and r.x + r.width >= p.x;
    }

    pub fn intersectRect(r1: Rect, r2: Rect) bool {
        const v = r2.center().sub(r2.center()).abs();
        const h1 = r1.halfSize();
        const h2 = r2.halfSize();

        return v.dx <= h1.dx + h2.dx and
            v.dy <= h1.dy + h2.dy;
    }

    pub fn center(r: Rect) Point {
        return point(
            r.x + r.width / 2,
            r.y + r.height / 2,
        );
    }

    pub fn halfSize(r: Rect) Vec2D {
        return vec2D(r.width / 2, r.height / 2);
    }

    const Self = @This();

    pub fn format(
        r: Self,
        comptime fmt: []const u8,
        options: std.fmt.FormatOptions,
        writer: anytype,
    ) !void {
        try writer.print("Rect({d}, {d}, {d}, {d})", .{ r.x, r.y, r.width, r.height });
    }
};

pub fn rect(x: real, y: real, width: real, height: real) Rect {
    return Rect{ .x = x, .y = y, .width = width, .height = height };
}

test "Rect intersections" {
    const r1 = rect(1, 1, 3, 3);
    const r2 = rect(2, 2, 1, 1);
    const r3 = rect(2, 3, 3, 3);
    const r4 = rect(5, 5, 1, 1);

    expect(r1.intersectRect(r2));
    expect(r1.intersectRect(r3));
    expect(r1.intersectRect(r4));
}
