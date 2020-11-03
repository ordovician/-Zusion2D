pub const std = @import("std");
pub const expect = std.testing.expect;
pub const math = std.math;
// const meta = std.meta; // Gives eql(any, any)

pub const real = f32;
pub const epsilon = math.f32_epsilon;

pub const inf = std.math.inf(real);
pub const negative_inf = -std.math.inf(real);
pub const nan = std.math.nan(real);
