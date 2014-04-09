
#include <SPI.h>
#include <boards.h>
#include <ble_shield.h>
#include <services.h> 

const int fowardPin = 3;
const int backwardPin = 5;
const int leftPin = 10;
const int rightPin = 6;

unsigned char buf[16] = {0};
unsigned char len = 0;

void setup() 
{
  ble_begin();
  Serial.begin(57600);
  
  pinMode(fowardPin, OUTPUT);
  pinMode(backwardPin, OUTPUT);
  pinMode(leftPin, OUTPUT);  
  pinMode(rightPin, OUTPUT);
}

void loop()
{
  while ( ble_available() ) {
    byte left = ble_read();
    byte right = ble_read();
    byte forward = ble_read();
    byte back = ble_read();
    
    analogWrite(fowardPin, forward);
    analogWrite(backwardPin, back);
    analogWrite(leftPin, left);
    analogWrite(rightPin, right);
  }
  
  ble_do_events();
}
