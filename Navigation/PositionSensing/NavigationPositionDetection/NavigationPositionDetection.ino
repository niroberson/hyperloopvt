#include "printf.h"

//*******************//
// Unit Conversions
//******************//

// ft/s to m/s
#define FPS_MPS(ft) ft*0.3048

// m/s to mph
#define MPS_MPH(mps) mps*2.23694

#define LED 13

volatile byte state = LOW;

unsigned long t[2] = {0,0};
unsigned long deltaT[2] = {0,0};
unsigned long seconds = 0;

bool firstInterrupt = true;
bool wait = false;

bool thousandFeetFlag = false;
bool fivehundredFeetFlag = false;

bool countTenStrips = false;
bool countTwentyStrips = false;

bool startOfTube = true;
bool endOfTube = false;

bool error = false;

byte twentyStripsCounter = 0;
byte tenStripsCounter = 0;

unsigned int distanceTraveled = 0;

//Approximately 1 mile
unsigned int distanceRemaining = 5280; 

int xVelocity[2] = {0,0};
int milesPerHour = 0;

void setup() {
  Serial.begin(9600);
  printf_begin();
  printf("Pod Position Sensing\n");
  pinMode(LED, OUTPUT);
  attachInterrupt(0, tapeInt, RISING);
}

void loop() { 
  digitalWrite(LED, state); 
  printf("distanceTraveled: %u, distanceRemaining: %u\n\r", distanceTraveled, distanceRemaining);
}

void tapeInt() { 

  // Not actually part of algorithm.
  // Used to ignore false start of Digilent 
  // Function Generator over MATLAB
  if(firstInterrupt)
  {
    firstInterrupt = false;
    // Pod detects initial acceleration, takes time
    t[0] = millis();
  }
    
   // 1 = now, 0 = past
  else if(!wait)
  {
    Serial.println("interrupt!");
    t[1] = millis() - t[0];   // Realtime, how many milliseconds it took
    deltaT[1] = t[1] - t[0];
    
    if(deltaT[0] >= (100*deltaT[1])) 
    {
      state = !state;
      // If thousand feet detected previously,
      // then we have 500 feet left
      if(thousandFeetFlag)
      {
        distanceRemaining = 500;
        fivehundredFeetFlag = true;
        countTenStrips = true;
      }
      else
      {
        distanceRemaining = 1000;
        thousandFeetFlag = true;
        countTwentyStrips = true;
      }
      wait = true;
    }
    else
    {
      distanceTraveled = distanceTraveled + 100;
      distanceRemaining = distanceRemaining - 100;

      // Calculate Velocity
      seconds = t[1]/1000; // (s)
      xVelocity[1] = (200 +(xVelocity[0]*seconds))/seconds; //(ft/s)
      xVelocity[1] = FPS_MPS(xVelocity[1]); // (m/s)
      milesPerHour = MPS_MPH(xVelocity[1]); // (mph)

      // Previous now equal to current
      t[0] = t[1];
      deltaT[0] = deltaT[1];
    }
  }
  
  else if(wait)
  {
    if(countTwentyStrips)
    {  
      twentyStripsCounter++;
      if(twentyStripsCounter == 20)
      {
        wait = false;
        countTwentyStrips = false;
      }
    }
    else if(countTenStrips)
    {
      tenStripsCounter++;
      if(tenStripsCounter == 10)
      {
        wait = false;
        countTenStrips = false;
        endOfTube = true;
      }
    }
    // We are in here for the wrong reason
    else
      error = true; 
  }
  //state = !state; 
}
