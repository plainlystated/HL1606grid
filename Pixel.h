/*
 * Pixel - Abstraction of lights on HL1606 LED strips
 * Copyright (c) 2011, Patrick Schless
 */

#ifndef pixel_h
#define pixel_h

#include <inttypes.h>
#include "HL1606strip.h"

class Pixel {
  public:
    Pixel();
    Pixel(uint8_t row, uint8_t col);

    void init(uint8_t row, uint8_t col);
    void copy(Pixel *p);
    uint8_t color;
    uint8_t row, col;
    uint8_t marker;
};

#endif
