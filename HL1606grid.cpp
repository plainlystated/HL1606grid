/*
 * HL1606grid - Abstraction of lights on HL1606 LED strips
 * Copyright (c) 2011, Patrick Schless
 */

#include "HL1606grid.h"

HL1606grid::HL1606grid(HL1606strip *s) {
  rows = 8;
  cols = 8;
  strip = s;
}

void HL1606grid::fill(uint8_t color) {
  for (uint8_t i=0; i<rows; i++) {
    for (uint8_t j=0; j<cols; j++) {
      pixels[i][j].color = color;
    }
  }
}

void HL1606grid::setLEDcolor(uint8_t row, uint8_t col, uint8_t color) {
  pixels[row][col].color = color;
}

uint8_t HL1606grid::getLEDcolor(uint8_t row, uint8_t col) {
  return pixels[row][col].color;
}

void HL1606grid::writeGrid() {
  uint8_t colPosition;

  for (uint8_t i=0; i<rows; i++) {
    for (uint8_t j=0; j<cols; j++) {
      if (j % 2 == 0) {
        colPosition = i;
      } else {
        colPosition = 8-i-1;
      }
      strip->setLEDcolor(j*8 + colPosition, pixels[i][j].color);
    }
  }
  strip->writeStrip();
}

void HL1606grid::clear() {
  fill(BLACK);
}
