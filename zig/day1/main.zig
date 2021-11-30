const std = @import("std");
const print = std.debug.print;
const data = @embedFile("input.data");

pub fn main() !void {
    try part1();
    try part2();
}

fn part1() !void {
    var lines = std.mem.split(u8, data, "\n");
    var depth: u16 = 0;
    var lastDepth: u16 = 0;
    var increases: u16 = 0;
    var i: u16 = 0;
    while (lines.next()) |line| {
        if (line.len > 0) {
            depth = try std.fmt.parseUnsigned(u16, line, 0);
            //print("{s}", .{line});
            if (i > 0 and depth > lastDepth) {
                //print(" +", .{});
                increases = increases + 1;
            }
            lastDepth = depth;
            //print("\n", .{});
            i = i + 1;
        }
    }
    print("There were {d} increases on the first set\n", .{increases});
}

fn part2() !void {
    var lines = std.mem.split(u8, data, "\n");
    var increases: u16 = 0;
    // lets see if we can do this in 1 pass so as not to make
    // lots of allocations
    var a: u16 = 0;
    var b: u16 = 0;
    var c: u16 = 0;
    var first: u16 = 0;
    var second: u16 = 0;
    var l = lines.next().?;
    a = try std.fmt.parseUnsigned(u16, l, 0);
    l = lines.next().?;
    b = try std.fmt.parseUnsigned(u16, l, 0);
    l = lines.next().?;
    c = try std.fmt.parseUnsigned(u16, l, 0);
    first = a + b + c;
    a = b;
    b = c;
    while (lines.next()) |line| {
        if (line.len > 0) {
            c = try std.fmt.parseUnsigned(u16, line, 0);
            //print("{s}", .{line});
            second = a + b + c;
            if (second > first) {
                //print(" +", .{});
                increases = increases + 1;
            }
            first = second;
            a = b;
            b = c;
            //print("\n", .{});
        }
    }
    print("There were {d} increases on the second set\n", .{increases});
}
