/*
 * Pixel - Abstraction of lights on HL1606 LED strips
 * Copyright (c) 2011, Patrick Schless
 */

#include "Pixel.h"

Pixel::Pixel() {
  init(0, 0);
}

Pixel::Pixel(uint8_t r, uint8_t c) {
  init(r,c);
}

void Pixel::init(uint8_t r, uint8_t c) {
  color = BLACK;
  row = r;
  col = c;
}

void Pixel::copy(Pixel *p) {
  color = p->color;
  row = p->row;
  col = p->col;
}
