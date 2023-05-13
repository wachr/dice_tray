module ngon(num, r) {
  polygon([for (i=[0:num-1], a=i*360/num) [ r*cos(a), r*sin(a) ]]);
}

module labelled_dice_pocket(depth = 5, sides = 4, label = "1d6", radius = 100, text_height = 100) {
    translate([radius, 2 * radius]) linear_extrude(depth) {
        ngon(sides, radius);
        translate([0, - 1.2 * radius, 0])
            text(label, size = text_height, halign = "center", valign = "top");
    }
}

module pockets(size = 11, rows = 3) {
    labels = ["1d4", "1d6", "1d8", "1d10", "1d10", "1d12", "1d20", "1d20", "1d20"];
    sides = [3, 4, 4, 6, 6, 5, 6, 6, 6];
    for(slot = [0 : len(labels) - 1]) {
        horizontal_spacing = (slot % (len(labels) / rows)) * (1.5 * size);
        vertical_spacing = (floor(slot / rows) % rows) * (2 * size);
        translate([horizontal_spacing, vertical_spacing])
        labelled_dice_pocket(
            label = labels[slot],
            sides = sides[slot],
            radius = size / 2,
            text_height = 0.8 * size / 2);
    }
}

border_width = 2;
difference() {
    linear_extrude(4)
        square([3 * (1.5 * 11) + 2 * border_width, 3 * 2 * 11 + 2 * border_width], center = false);
    translate([border_width, border_width, 2]) pockets();
}
