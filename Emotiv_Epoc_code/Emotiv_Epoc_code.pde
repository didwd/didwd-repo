// Based on the ProcessingEpocOsc1 example by Joshua Madara, available at http://hyperritual.com/blog/processing-epoc-osc/
// Adjusted by Dorothea Kalogianni and Zechao Alvin
// further developed by Michal Wasilewski
// 
// Developed at University of Edinburgh
// Design Informatics
// contact: mwasilewski@gmx.com
//
// this code will send data from Emotiv Epoc headset to a serial port (USB)
// 



import oscP5.*;
import netP5.*;
import processing.serial.*;

float excitement;
float meditation;
float boredom;
float frustration;

OscP5 oscP5;
Serial myPort;

void setup() {
  // connect on port 7400
  oscP5 = new OscP5(this, 7400);
  
  // Serial.list() - get a list of  usb ports
  // baudrate 9600
  myPort = new Serial(this, Serial.list()[1], 9600);
} 

void draw() {
  // int m = millis();
  // println(hour()+":"+minute()+":"+second() + "," + excitement + "," + meditation + "," + boredom + "," + frustration);
  println(byte(excitement*100));
  myPort.write(byte(excitement*100));
}

void oscEvent(OscMessage theOscMessage) {
  // Excitement
  // check if theOscMessage has an address pattern we are looking for
  if(theOscMessage.checkAddrPattern("/AFF/Excitement") == true) {
    // parse theOscMessage and extract the values from the OSC message arguments
    excitement = theOscMessage.get(0).floatValue();
    }
  
  // Meditation
  else if (theOscMessage.checkAddrPattern("/AFF/Meditation") == true) {
    meditation =theOscMessage.get(0).floatValue();
    }
  
  // Boredom
  if(theOscMessage.checkAddrPattern("/AFF/Engaged/Bored") == true) {
    boredom = theOscMessage.get(0).floatValue();
    }
  
  // Frustration
  else if (theOscMessage.checkAddrPattern("/AFF/Frustration") == true) {
    frustration = theOscMessage.get(0).floatValue();
    }
  

} 

void keyPressed() {
  println(Serial.list());
  exit(); // Stops the program
}
