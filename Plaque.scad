
DEFAULT_SIZE = [20, 10, 1]; // Height value includes frame height
DEFAULT_FRAME_SIZE = [2, 2, 0.5];

DEFAULT_RIVET_RADIUS = 0.3;
DEFAULT_RIVET_HEIGHT = 0.2;
DEFAULT_RIVET_SIDES = 6;
DEFAULT_NUM_X_RIVETS = 9;
DEFAULT_NUM_Y_RIVETS = 5;

module Rivet(rivetRadius, rivetHeight, rivetSides)
{
    cylinder(r = rivetRadius, h = rivetHeight, $fn = rivetSides);
}

module Plaque(
    size = DEFAULT_SIZE,
    frameSize = DEFAULT_FRAME_SIZE,
    rivetRadius = DEFAULT_RIVET_RADIUS,
    rivetHeight = DEFAULT_RIVET_HEIGHT,
    rivetSides =  DEFAULT_RIVET_SIDES,
    numXRivets = DEFAULT_NUM_X_RIVETS,
    numYRivets = DEFAULT_NUM_Y_RIVETS)
{
    translate([0, 0, size[2] / 2])
    difference()
    {
        // Main body
        cube(size, center = true);

        // Frame
        translate([0, 0, frameSize[2]/2])
        cube(size - frameSize, center = true);
    }

    // Rivets - X
    y = size[1] / 2 - frameSize[1] / 4;
    translate([-size[0] / 2 + frameSize[0] / 4, 0, size[2]])
    for (x = [0 : numXRivets - 1])
    {
        xPos = x / (numXRivets - 1) * (size[0] - frameSize[0] / 2);
        translate([xPos,  y, 0]) Rivet(rivetRadius, rivetHeight, rivetSides);
        translate([xPos, -y, 0]) Rivet(rivetRadius, rivetHeight, rivetSides);
    }

    // Rivets - Y
    x = size[0] / 2 - frameSize[0] / 4;
    translate([0, -size[1] / 2 + frameSize[1] / 4, size[2]])
    for (y = [0 : numYRivets - 1])
    {
        yPos = y / (numYRivets - 1) * (size[1] - frameSize[1] / 2);
        translate([ x, yPos, 0]) Rivet(rivetRadius, rivetHeight, rivetSides);
        translate([-x, yPos, 0]) Rivet(rivetRadius, rivetHeight, rivetSides);
    }
}

Plaque();
