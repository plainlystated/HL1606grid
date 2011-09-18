/*
Snake Attack!

Copyright Patrick Schless, 2011
*/


// HL1606strip is an adaptation of LEDstrip from  http://code.google.com/p/ledstrip/
#include <Snake.h>
#include <Grid.h>
#include <Pixel.h>
#include <HL1606strip.h>

// use -any- 3 pins!
#define STRIP_D 4
#define STRIP_C 3
#define STRIP_L 2
#define RIGHT_PADDLE 8
#define LEFT_PADDLE 9
#define NO_INPUT 0

// Pin S is not really used in this demo since it doesnt use the built in PWM fade
// The last argument is the number of LEDs in the strip. Each chip has 2 LEDs, and the number
// of chips/LEDs per meter varies so make sure to count them! if you have the wrong number
// the strip will act a little strangely, with the end pixels not showing up the way you like
HL1606strip strip = HL1606strip(STRIP_D, STRIP_L, STRIP_C, 64);
Grid grid = Grid(&strip);

uint8_t lastInputState;
uint8_t lastInputTime;

uint8_t blockPosition = 0;

void setup(void) {
  Serial.begin(9600);
  randomSeed(analogRead(0));
  pinMode(RIGHT_PADDLE, INPUT);
  digitalWrite(RIGHT_PADDLE, HIGH);

  pinMode(LEFT_PADDLE, INPUT);
  digitalWrite(LEFT_PADDLE, HIGH);

  lastInputState = NO_INPUT;
  lastInputTime = 0;
}

void loop() {
  snakeGrid();
  //blocksAcross();
  //snake(3, 20);
}

uint8_t getInput() {
  uint8_t input;
  if (digitalRead(RIGHT_PADDLE) == LOW) {
    input = RIGHT_PADDLE;
  } else if (digitalRead(LEFT_PADDLE) == LOW) {
    input = LEFT_PADDLE;
  } else {
    input = NO_INPUT;
  }

  if (input != lastInputState) {
    lastInputState = input;
    return input;
  } else {
    return NO_INPUT;
  }
}

void snakeGrid() {
  uint8_t row = 0;
  uint8_t direction = 0;
  uint8_t input;
  uint8_t duration = 100;

  Pixel *apples[3];
  uint8_t appleCount = 0;

  Snake snake = Snake(&grid);

  while (true) {
    input = getInput();
    if (input == RIGHT_PADDLE) direction = (direction + 1) % 4;
    if (input == LEFT_PADDLE) direction = (direction + 3) % 4;

    for (uint8_t snakeLED=0; snakeLED<snake.size; snakeLED++) {
      Serial.print("(");
      Serial.print(snake.pixels[snakeLED]->row, 10);
      Serial.print(",");
      Serial.print(snake.pixels[snakeLED]->col, 10);
      Serial.println(")");
      grid.setLEDcolor(snake.pixels[snakeLED]->row, snake.pixels[snakeLED]->col, RED);
    }

    if (appleCount < 3 && random(15) == 0) {
      uint8_t attempts = 0;
      while (attempts < 2) {
        uint8_t c = random(grid.cols);
        c = random(grid.cols);
        c = random(grid.cols);
Serial.print(random(grid.rows), 10);
Serial.print(random(grid.rows), 10);
Serial.print(random(grid.rows), 10);
Serial.print(random(grid.cols), 10);
Serial.print(random(grid.cols), 10);
Serial.print(random(grid.cols), 10);
Serial.print("(");
        uint8_t r = random(grid.rows);
Serial.print(r, 10);
Serial.print(",");
        r = random(grid.rows);
Serial.print(r, 10);
Serial.print(",");
        r = random(grid.rows);
Serial.print(r, 10);
Serial.print(random(grid.rows));
Serial.print(",");
Serial.print(random(grid.rows));
Serial.print(",");
Serial.print(random(grid.rows));
Serial.print(",");
Serial.print(random(grid.rows));
Serial.print(",");
Serial.print(r, 10);
Serial.print(",");
Serial.print(c, 10);
Serial.println(")");
        if (grid.getLEDcolor(r, c) == BLACK) {
          
          Serial.print("setRandomPixel ok @ [");
          apples[appleCount] = &Pixel(r, c);
          apples[appleCount]->marker = random(15) + 15;;
          appleCount++;
Serial.print(r, 10);
Serial.print(",");
Serial.print(c, 10);
Serial.print("] appleCount: ");
Serial.print(appleCount, 10);
Serial.println();
          break;
        } else {
          Serial.print("setRandomPixel collision @ [");
Serial.print(r, 10);
Serial.print(",");
Serial.print(c, 10);
Serial.println("]");
          attempts += 1;
        }
      }
    }

    for (uint8_t i=0; i<appleCount; i++) {
      if (apples[i]->marker > 0) {
        if (--(apples[i]->marker) == 0) {
          grid.setLEDcolor(apples[i]->row, apples[i]->col, BLACK);
          for (uint8_t j=i; j<appleCount; j++) {
            apples[j] = apples[j+1];
          }
          i--;
Serial.println("decrementing appleCount");
          appleCount--;
        } else {
          grid.setLEDcolor(apples[i]->row, apples[i]->col, GREEN);
        }
      }
    }

    grid.writeGrid();
    delay(duration);
    uint8_t movement = snake.move(direction);
    if (movement == 0) {
      grid.fill(BLUE);
      grid.writeGrid();
      delay(1000);
      for (uint8_t i=0; i<3; i++) {
        apples[i]->marker = 0;
      }
      appleCount = 0;
      grid.clear();
      snake = Snake(&grid);
      direction = 0;
      duration = 100;
    }

    if (movement == 1) {
      duration += 1;
      if (duration > 250) duration = 250;
    }

    row = (row + 1) % 8;
    Serial.println();
  }
}

/*void moveSnake(uint8_t* snake, uint8_t snakeSize) {*/
/*  for (uint8_t snakeLED=0; snakeLED<snakeSize-1; snakeLED++) {*/
/*    snake[snakeSize-snakeLED][0] = snake[snakeSize-snakeLED+1][0];*/
/*    snake[snakeSize-snakeLED][0] = snake[snakeSize-snakeLED+1][1];*/
/*  }*/
/*}*/

void blocksAcross() {
  uint8_t row = 0;
  bool direction = 0;

  while (true) {
    for (uint8_t col=0; col<3; col++) {
      grid.clear();
      if (direction) {
        grid.setLEDcolor(row, col, RED);
      } else {
        grid.setLEDcolor(row, 2-col, RED);
      }
      grid.writeGrid();
      delay(100);
    }
    direction = !direction;
    row = (row + 1) % 8;
  }
}

void snake(uint8_t blockSize, uint8_t duration) {
  uint8_t color;
  uint8_t colors[] = {WHITE, RED, YELLOW, GREEN, TEAL, BLUE, VIOLET};

  while (true) {
    color = colors[random(7)];
    for (uint8_t blockPosition=0; blockPosition < strip.numLEDs(); blockPosition++) {
      for (uint8_t i=0; i<strip.numLEDs(); i++) {
        /*Serial.print("i: ");*/
        /*Serial.println(i, 10);*/
        if (i == blockPosition) {
          for (uint8_t j=0; j<blockSize; j++) {
            /*Serial.println(" - red");*/
            strip.setLEDcolor((i + j) % strip.numLEDs(), color);
          }
          i += blockSize;
        } else {
            /*Serial.println(" - black");*/
          strip.setLEDcolor(i, BLACK);
        }
      }
      strip.writeStrip();
      duration += random(50) - 25;
      if (duration >= 100)
        duration = 100;
      delay(duration);
    }
  }
}
