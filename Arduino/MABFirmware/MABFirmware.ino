
#include <SPI.h>
#include <boards.h>
#include <ble_shield.h>
#include <services.h> 

const int fowardPin = 7;
const int backwardPin = 6;
const int leftPin = 5;
const int rightPin = 4;

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
//  while ( ble_available() )
//    Serial.write(ble_read());
//
//  while ( Serial.available() )
//  {
//    unsigned char c = Serial.read();    
//    if (c != 0x0A)
//    {
//      if (len < 16)
//        buf[len++] = c;
//    }
//    else
//    {
//      buf[len++] = 0x0A;
//      
//      for (int i = 0; i < len; i++)
//        ble_write(buf[i]);
//      len = 0;
//    }
//  }
  
  ble_do_events();
}
