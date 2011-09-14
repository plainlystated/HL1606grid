/*
 * Snake - Abstraction of lights on HL1606 LED strips
 * Copyright (c) 2011, Patrick Schless
 */

#include "Snake.h"

Snake::Snake(Grid *g) {
  grid = g;
  size = 3;

  pixels[0] = allocatePixel(0, 0);
  pixels[1] = allocatePixel(0, 1);
  pixels[2] = allocatePixel(0, 2);

  // pixels[0] = Pixel(0, 0);
  // pixels[1] = Pixel(0, 1);
  // pixels[2] = Pixel(0, 2);

}

Pixel* Snake::allocatePixel(uint8_t row, uint8_t col) {
  Pixel *p = (Pixel *)malloc(sizeof(Pixel));
  p->init(row, col);
  return p;
}

bool Snake::move(uint8_t direction) {
  uint8_t nextPosition[2];
  uint8_t nextPositionColor;

  switch (direction) {
    case 0:
      nextPosition[0] = (pixels[0]->row + 1) % grid->rows;
      break;
    case 1:
      nextPosition[1] = (pixels[0]->col + 1) % grid->cols;
      break;
    case 2:
      nextPosition[0] = (pixels[0]->row + grid->rows - 1) % grid->rows;
      break;
    case 3:
      nextPosition[1] = (pixels[0]->col + grid->cols - 1 ) % grid->cols;
      break;
  }

  switch (direction) {
    case 0:
    case 2:
      nextPosition[1] = pixels[0]->col;
      break;
    case 1:
    case 3:
      nextPosition[0] = pixels[0]->row;
      break;
  }
  nextPositionColor = grid->getLEDcolor(nextPosition[0], nextPosition[1]);

  switch (nextPositionColor) {
    case RED:
      return false;
      break;
    case GREEN:
      growTo(nextPosition[0], nextPosition[1]);
      break;
    default:
      moveTo(nextPosition[0], nextPosition[1]);
      break;
  }
  return true;
}

void Snake::moveTo(uint8_t row, uint8_t col) {
  uint8_t oldTailPosition[] = { pixels[size - 1]->row, pixels[size - 1]->col };
  promoteBody();
  pixels[0]->row = row;
  pixels[0]->col = col;
  grid->setLEDcolor(oldTailPosition[0], oldTailPosition[1], BLACK);
}

void Snake::growTo(uint8_t row, uint8_t col) {
  Serial.println("GROWING");
  Serial.println("BEFORE:");
  for (uint8_t snakeLED=0; snakeLED<=size; snakeLED++) {
    Serial.print("(");
    Serial.print(pixels[snakeLED]->row, 10);
    Serial.print(",");
    Serial.print(pixels[snakeLED]->col, 10);
    Serial.println(")");
  }
  for (uint8_t i=0; i<size; i++) {
    //pixels[size-i]->copy(pixels[size-i-1]);
    pixels[size-i] = pixels[size-i-1];
    // pixels[size-i]->row = pixels[size-i-1]->row;
    // pixels[size-i]->col = pixels[size-i-1]->col;
    // pixels[size-i]->color = pixels[size-i-1]->color;
  }
  pixels[0] = allocatePixel(row, col);
  size++;
  Serial.println("AFTER:");
  for (uint8_t snakeLED=0; snakeLED<size; snakeLED++) {
    Serial.print("(");
    Serial.print(pixels[snakeLED]->row, 10);
    Serial.print(",");
    Serial.print(pixels[snakeLED]->col, 10);
    Serial.println(")");
  }
}

void Snake::promoteBody() {
  for (uint8_t i=0; i<size-1; i++) {
    pixels[size-i-1]->copy(pixels[size-i-2]);
  }
}

bool Snake::moveUp() {
  return move(0);
}

bool Snake::moveDown() {
  return move(2);
}

bool Snake::moveRight() {
  return move(1);
}

bool Snake::moveLeft() {
  return move(3);
}
