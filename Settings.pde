// ALL THESE PARAMETERS SHOULD BECOME ACCESIBLE VIA AN INTERFACE (WITH SLIDERS OR SOMEHTING):

// TODO: should become an interchangeable state
// - presets
// - accesseable with controllers

// TODO: could implement this in an VST essentially using the strength of JUCE to enable powerfull state and parameter modification.
//        ! automating in an DAW could be very cool !
//   Downside: JUCE drawing is less straightforward then Processing, but the exact same and even more should be possible to achieve there

// NOTE: default values are added in comments behind the parameters, to make sure the default state is remembered untill the system is improved 

final float BRANCH_ANGLE_OFFSET = 1.0f; // DEF: 1
final float BRANCHING_CHANCE = 3.0f / 100.0f; // DEF: 0.02 (2%)
final float BRANCH_MOVEMENT = 0.4f; // DEF: 0.2
final int BRANCH_COUNT = 5; // DEF: 3
final float WIDTH_EXPANSION = 1.0f; // DEF: 1.0f;
final float WIDTH_MULTIPLIER = 0.2f; // DEF: 1.0f;

final int BRANCH_COUNT_REDUCTION = 1; // DEF: 1
final int BRANCH_MAXIMUM_COUNT = 5000;

// final float ALPHA = 0.0f;

final float INIT_SPEED = 5.0f; // DEF: 5
final float MINSPEED = 0.1f; // DEF: 0.1
final float SPEED_MULTIPLIER = 1.0f; // DEF: 1
final float SPEED_INCREMENT = -0.04; // DEF: -0.1
final float SPEED_RANDOM_DEV = 0.05f; // DEF: 0.05

final int RANDOM_LIST_SEED = 22;
