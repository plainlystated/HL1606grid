/*
 * Snake - Abstraction of lights on HL1606 LED strips
 * Copyright (c) 2011, Patrick Schless
 */

#ifndef snake_h
#define snake_h

#include "Grid.h"
#include "Pixel.h"

class Snake {
  public:
    Snake(Grid *g);
    Grid *grid;
    Pixel *pixels[64];
    bool move(uint8_t direction);
    void moveTo(uint8_t row, uint8_t col);
    void growTo(uint8_t row, uint8_t col);
    bool moveUp();
    bool moveDown();
    bool moveRight();
    bool moveLeft();
    uint8_t size;

  private:
    void promoteBody();
    Pixel* allocatePixel(uint8_t row, uint8_t col);
};

#endif
