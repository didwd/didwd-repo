// Design with Data
// Design Informatics
// University of Edinburgh

#include <Servo.h> 
#include <FileIO.h>
#include <Bridge.h>
 
Servo myservo;  // create servo object to control a servo 
                // a maximum of eight servo objects can be created 
 
int pos = 0;    // variable to store the servo position 
int brain = 0;
int feed = 0;
 
void setup() 
{ 
  Bridge.begin();
  Serial.begin(9600);
  myservo.attach(9);  // attaches the servo on pin 9 to the servo object 
  FileSystem.begin();
} 
 
 
void loop() 
{ 

   if (Serial.available() > 0) {
                // read the incoming byte:
                brain = Serial.read();

        }
        
     
   feed = map(brain, 0, 100, 0, 90);
   
   if (feed > pos){
     pos += 1;
     myservo.write(pos);
     delay(15);
   }
   
   if (feed < pos){
      pos -= 1;
      myservo.write(pos);
     delay(15); 
   }

}

