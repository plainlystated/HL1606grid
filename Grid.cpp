/*
 * Grid - Abstraction of lights on HL1606 LED strips
 * Copyright (c) 2011, Patrick Schless
 */

#include "Grid.h"

Grid::Grid(HL1606strip *s) {
  rows = 8;
  cols = 8;
  strip = s;
}

void Grid::fill(uint8_t color) {
  for (uint8_t i=0; i<rows; i++) {
    for (uint8_t j=0; j<cols; j++) {
      pixels[i][j].color = color;
    }
  }
}

void Grid::setLEDcolor(uint8_t row, uint8_t col, uint8_t color) {
  pixels[row][col].color = color;
}

uint8_t Grid::getLEDcolor(uint8_t row, uint8_t col) {
  return pixels[row][col].color;
}

void Grid::writeGrid() {
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

void Grid::clear() {
  fill(BLACK);
}
