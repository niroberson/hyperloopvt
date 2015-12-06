#define LED 13
volatile byte state = LOW;
unsigned long currentTime = 0;
unsigned long oldTime = 0;
unsigned long deltaT = 0;
unsigned long oldDeltaT = 0;
bool firstInterrupt = true;

void setup() {
  Serial.begin(9600);
  pinMode(LED, OUTPUT);
  attachInterrupt(0, toggle, RISING);
}

void loop() { 
  digitalWrite(LED, state); 
}

void toggle() { 
  if(firstInterrupt)
  {
   firstInterrupt = false;
  }
  else
  {
    Serial.println("interrupt!");
    currentTime = millis();
    deltaT = currentTime - oldTime;
  //Serial.print("Current Time: ");
  //Serial.print(currentTime);
  //Serial.print("   Old Time: ");
  //Serial.print(oldTime);
  //Serial.print("   deltaT: ");
  //Serial.println(deltaT);

    if(oldDeltaT >= (100*deltaT)) state = !state;
    oldTime = currentTime;
    oldDeltaT = deltaT;
  }
  //state = !state; 
}
