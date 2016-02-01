/*
 Demo:
 Controlling both motor speed and servo position with 2 potentiometers

 inputs: 
  - Motor potentiometer pin A0
  - Servo potentiometer pin A1
  - IR detector (Tachometer)

 outputs:
  - Servo pin 9
  - Motor pin 6
*/

#include <Servo.h>

Servo servo;  // create servo object to control a servo
Servo motor;  // create servo object to control motor

int servoPot = A0;  // analog pin used to connect the servo control pot
int motorPot = A1;  // analog pin used to connect the motor control pot
int servoVal;      // variable to read the value from the analog pin
int motorVal;      // variable to read the value from the analog pin
int velocity;      // variable that relates potentiometer location to velocity
bool topSpeed = false;
int pos = 0;

enum operatingState {INTERACTIVE_DEMO, TRAJECTORY_DEMO, STOP, RAMP};
operatingState opState = INTERACTIVE_DEMO;

void setup() {

  Serial.begin(115200);
  Serial.println("Hyperloop Demo");
  
  servo.attach(9);  // attaches the servo on pin 9 to the servo object
  delay(1000);
  
  motor.attach(6);  // attaches motor on pin 6 to servo object
  delay(1000);

  if(opState == INTERACTIVE_DEMO) Serial.println("Interactive Demo");
  else if(opState == TRAJECTORY_DEMO) Serial.println("Trajectory Demo");

  Serial.println("Press button to begin.");
  while(!Serial.available())
  {
  }
  Serial.println("Starting Demo");
}

void loop() {

  switch (opState) 
  {
    case RAMP:

      Serial.println("Press button to begin.");
      while(!Serial.available())
      {
      }
      Serial.println("Starting motor ramp.");
      for(pos = 0; pos < 120; pos++)
      {
        motor.write(pos);
        delay(40);
      }
      Serial.print("Done Ramping");
      opState = INTERACTIVE_DEMO;
      
    break;
    
    case INTERACTIVE_DEMO: 
      //Serial.println("Debug: Interactive_Demo");
      
      //servoVal = analogRead(servoPot);                 // reads the value of the potentiometer (value between 0 and 1023)
      //servoVal = map(servoVal, 0, 1023, 0, 180);       // scale it to use it with the servo (value between 0 and 180)
      //servo.write(servoVal);                           // sets the servo position according to the scaled value
      //delay(15);                                       // waits for the servo to get there

      motorVal = analogRead(motorPot);
      motorVal = map(motorVal, 0, 1023, 0, 180);
      motor.write(motorVal);
      delay(15);
    
    break;
      
    case TRAJECTORY_DEMO:
      
      if(!topSpeed)
      {
        for(int i = 90; i < 180; i++)
        {
          motor.write(i);
          delay(15); 
        }
        topSpeed = true;
      }
      else
      {
        delay(5000); // Let motor run at top speed 5 seconds

        // Begin braking:
        // turn motor off
        motor.write(90);

        // Slide brakes in:
        for(int i = 0; i < 180; i++)
        {
          servo.write(i);
          delay(15);
        }

        opState = STOP; // End demo
      }
      
    break;

    case STOP:

      // Do nothing;
    break;
      
    default: 
      // if nothing else matches, do the default
      // default is optional
    break;
  }
}

