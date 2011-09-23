/*
 * Demo code for an HL1606grid
 *
 * Copyright Patrick Schless, 2011
 */

#include <HL1606grid.h>
#include <HL1606strip.h>

// use -any- 3 pins!
#define STRIP_D 4
#define STRIP_C 3
#define STRIP_L 2

HL1606strip strip = HL1606strip(STRIP_D, STRIP_L, STRIP_C, 64);
HL1606grid grid = HL1606grid(&strip);

void setup(void) {
 randomSeed(analogRead(0));
}

void loop() {
  patterns(1000);
  blocksAcross(50);
  snake(3, 20);
}

void patterns(int duration) {
  for (uint8_t row=0; row<grid.rows; row++) {
    if (row % 3 == 0) {
      for (uint8_t col=0; col<grid.cols; col++) {
        grid.setLEDcolor(row, col, RED);
      }
    }
  }
  grid.writeGrid();
  delay(duration);
  grid.clear();

  for (uint8_t col=0; col<grid.cols; col++) {
    if (col % 2 == 0) {
      for (uint8_t row=0; row<grid.rows; row++) {
        grid.setLEDcolor(row, col, RED);
      }
    }
  }
  grid.writeGrid();
  delay(duration);
  grid.clear();

  for (uint8_t i=0; i<grid.rows; i++) {
    grid.setLEDcolor(i, i, RED);
    grid.setLEDcolor(grid.cols-i-1, i, RED);
  }
  grid.writeGrid();
  delay(duration);
}

void blocksAcross(uint8_t duration) {
  bool direction = 0;
  uint8_t rowCount = 8;
  uint8_t colCount = 8;

  for (uint8_t row=0; row<rowCount; row++) {
    for (uint8_t col=0; col<colCount; col++) {
      grid.clear();
      if (direction) {
        grid.setLEDcolor(row % rowCount, col, RED);
      } else {
        grid.setLEDcolor(row % rowCount, colCount-col-1, RED);
      }
      grid.writeGrid();
      delay(duration);
    }
    direction = !direction;
  }
}

void snake(uint8_t blockSize, uint8_t duration) {
  uint8_t color;
  uint8_t colors[] = {WHITE, RED, YELLOW, GREEN, TEAL, BLUE, VIOLET};

  while (true) {
    color = colors[random(7)];
    for (uint8_t blockPosition=0; blockPosition < strip.numLEDs(); blockPosition++) {
      for (uint8_t i=0; i<strip.numLEDs(); i++) {
        if (i == blockPosition) {
          for (uint8_t j=0; j<blockSize; j++) {
            strip.setLEDcolor((i + j) % strip.numLEDs(), color);
          }
          i += blockSize;
        } else {
          strip.setLEDcolor(i, BLACK);
        }
      }
      strip.writeStrip();
      delay(duration);
    }
  }
}
