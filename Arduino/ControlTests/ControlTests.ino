


const int fowardPin = 11;
const int backwardPin = 10;
const int leftPin = 9;
const int rightPin = 8;

void setup() {
  pinMode(fowardPin, OUTPUT);
  pinMode(backwardPin, OUTPUT);
  pinMode(rightPin, OUTPUT);
  pinMode(leftPin, OUTPUT);
}

void loop()
{
  digitalWrite(fowardPin, HIGH);
  delay(1000);
  digitalWrite(fowardPin,LOW);
  delay(1000);
  digitalWrite(backwardPin, HIGH);
  delay(1000);
  digitalWrite(backwardPin,LOW);
  delay(1000);
  digitalWrite(leftPin, HIGH);
  delay(1000);
  digitalWrite(leftPin,LOW);
  delay(1000);
  digitalWrite(rightPin, HIGH);
  delay(1000);
  digitalWrite(rightPin,LOW);
  
  delay(10000000);
}
