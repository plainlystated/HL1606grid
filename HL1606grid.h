/*
 * Grid - Abstraction of 2 dimentional pixels on HL1606 LED strips
 * Copyright (c) 2011, Patrick Schless
 */

#ifndef grid_h
#define grid_h

#include "WProgram.h"
#include "Pixel.h";
#include "HL1606strip.h";

class HL1606grid {
  public:
    HL1606grid(HL1606strip *strip);
    Pixel pixels[8][8];
    HL1606strip *strip;
    uint8_t rows;
    uint8_t cols;

    void fill(uint8_t color);
    void writeGrid();
    void setLEDcolor(uint8_t row, uint8_t col, uint8_t color);
    uint8_t getLEDcolor(uint8_t row, uint8_t col);
    void clear();
};

#endif
