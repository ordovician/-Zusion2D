usingnamespace @import("types.zig");

pub const Vec2D = struct {
    dx: real = 0,
    dy: real = 0,

    const Self = @This();

    pub fn add(u: Vec2D, v: Vec2D) Vec2D {
        return vec2D(u.dx + v.dx, u.dy + v.dy);
    }

    pub fn sub(u: Vec2D, v: Vec2D) Vec2D {
        return vec2D(u.dx - v.dx, u.dy - v.dy);
    }

    pub fn dot(u: Vec2D, v: Vec2D) real {
        return u.dx * v.dx + u.dy * v.dy;
    }

    pub fn cross(u: Vec2D, v: Vec2D) real {
        return u.dx * v.dy - u.dy * v.dx;
    }

    pub fn abs(u: Vec2D) Vec2D {
        return vec2D(math.absFloat(u.dx), math.absFloat(u.dy));
    }

    pub fn ang(u: Vec2D) real {
        return math.atan2(u.dy, u.dx);
    }

    pub fn mul(u: Vec2D, factor: real) Vec2D {
        return vec2D(u.dx * factor, u.dy * factor);
    }

    // Divides each component with each other
    pub fn div(v: Vec2D, u: Vec2D) vec2D {
        return vec2D(v.dx / u.dx, v.dy / u.dy);
    }

    pub fn neg(v: Vec2D) Vec2D {
        return vec2D(-v.dx, -v.dy);
    }

    pub fn len(u: Vec2D) real {
        return math.sqrt(sqrLen(u));
    }

    pub fn sqrLen(u: Vec2D) real {
        return (u.dx * u.dx) + (u.dy * u.dy);
    }

    pub fn unit(u: Vec2D) Vec2D {
        const length: real = vec2DLen(u);
        return vec2D(u.dx / length, u.dy / length);
    }

    pub fn normal(u: Vec2D) Vec2D {
        return vec2D(-u.dy, u.dx);
    }

    pub fn isMin(u: Vec2D, v: Vec2D) bool {
        return (u.dx < v.dx) or ((u.dx == v.dx) and (u.dy < v.dy));
    }

    pub fn isMax(p: Vec2D, q: Vec2D) bool {
        return (u.dx > v.dx) or ((u.dx == v.dx) and (u.dy > v.dy));
    }

    pub fn eq(u: Vec2D, v: Vec2D) bool {
        return math.approxEq(real, u.dx, v.dx, epsilon) and
            math.approxEq(real, u.dy, v.dy, epsilon);
    }

    pub fn notEq(u: Vec2D, v: Vec2D) bool {
        return (u.dx != v.dx) or (u.dy != v.dy);
    }

    pub fn isDef(v: Vec2D) bool {
        return !(math.isNan(v.dx) or math.isNan(v.dy));
    }

    pub fn format(
        v: Self,
        comptime fmt: []const u8,
        options: std.fmt.FormatOptions,
        writer: anytype,
    ) !void {
        try writer.print("Vec2D({d}, {d})", .{ v.dx, v.dy });
    }
};

pub fn vec2D(x: real, y: real) Vec2D {
    return Vec2D{ .dx = x, .dy = y };
}

const stdout = &std.io.getStdOut().outStream();

test "Adding Vec2D" {
    const u = vec2D(3, 4);
    const v = vec2D(1, -1);

    const w = u.add(v);
    const expected = vec2D(4, 3);

    expect(w.eq(expected));
}

test "Subtracting Vec2D" {
    const u = vec2D(1, 2);
    const v = vec2D(3, 4);

    expect(u.sub(v).eq(vec2D(-2, -2)));
}

test "Dot product Vec2D" {
    const u = vec2D(1.5, 2);
    const v = vec2D(3, 4);

    const res = 1.5 * 3.0 + 2.0 * 4.0;

    expect(u.dot(v) == res);
}

test "Scale Vec2D" {
    const f = 1.5;
    const u = vec2D(3, 4).mul(f);
    const v = vec2D(3 * f, 4 * f);

    expect(u.eq(v));
}
