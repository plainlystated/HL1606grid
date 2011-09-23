# HL1606grid - Addressable matrix of LEDs

A library to control a matrix built out of HL1606-based LED strips. You set individual LED colors in the grid, then write them all out at once.

To see it in action (or get more detailed info), check out [the blog about it](http://www.plainlystated.com/2011/09/addressable-led-grid/).

This library doesn't have any PWM support, it's just for primary colors.

## Dependencies

Depends on [adafruit's HL1606strip library](https://github.com/adafruit/HL1606-LED-Strip) (must be installed separately, in libraries/).

## To download

Click DOWNLOADS in the top right (or clone).

## To install

1. Make sure you have a "libraries" directory in your arduino directory

2. Extract (or clone) the library to libraries/HL1606grid/

3. Restart your Arduino IDE

## Example Code

The library comes with example code. To run it, go to (in the Arduino IDE):

1. File

2. Examples

3. HL1606grid

4. HL1606gridDemo

(Then compile and run)

## Troubleshooting

* If you don't have HL1606strip under examples, then you didn't install the required dependency correctly.

* If you don't have HL1606grid under examples, then you didn't install this library correctly.
