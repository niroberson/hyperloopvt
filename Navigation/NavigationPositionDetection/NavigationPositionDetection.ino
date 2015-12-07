#include "printf.h"

#define LED 13
volatile byte state = LOW;

unsigned long currentTime = 0;
unsigned long oldTime = 0;
unsigned long deltaT = 0;
unsigned long oldDeltaT = 0;

bool firstInterrupt = true;
bool wait = false;
byte thousandFeetStrips = 0;
unsigned int distanceTraveled = 0;
unsigned int distanceRemaining = 5280;


void setup() {
  Serial.begin(9600);
  printf_begin();
  printf("Pod Position Sensing\n");
  pinMode(LED, OUTPUT);
  attachInterrupt(0, toggle, RISING);
}

void loop() { 
  digitalWrite(LED, state); 
  printf("distanceTraveled: %u, distanceRemaining: %u\n\r", distanceTraveled, distanceRemaining);
}

void toggle() { 
  if(firstInterrupt)
    firstInterrupt = false;
    
  else if(!wait)
  {
    Serial.println("interrupt!");
    currentTime = millis();
    deltaT = currentTime - oldTime;
    
    if(oldDeltaT >= (100*deltaT)) 
    {
      state = !state;
      distanceRemaining = 1000;
      wait = true;
    }
    else
    {
      distanceTraveled = distanceTraveled + 100;
      distanceRemaining = distanceRemaining - 100;
    }
    oldTime = currentTime;
    oldDeltaT = deltaT;
  }
  else if(wait)
  {
    thousandFeetStrips++;
    if(thousandFeetStrips == 2)
      wait = false;
  }
  //state = !state; 
}
