#include <RotaryEncoder.h>

#define PIN_A 2
#define PIN_B 3
const int8_t ENCODER_TABLE[] = {0,-1,1,0,1,0,0,-1,-1,0,0,1,0,1,-1,0};
volatile bool StatePinA = 1;
volatile bool StatePinB = 1;

volatile uint8_t State = 0;
volatile long Count = 0;
int inByte=0;
int value = 0;

void setup() {
  Serial.begin(9600);
  establishContact();  //最初にシリアルを成立させるために動かす関数

  pinMode(PIN_A, INPUT_PULLUP);
  pinMode(PIN_B, INPUT_PULLUP);
 
  attachInterrupt(0, ChangePinAB, CHANGE);
  attachInterrupt(1, ChangePinAB, CHANGE);

}


void loop() {
  if (Serial.available() > 0) {  
   inByte = Serial.read();


   value = Count / 4;

   if(Count < 0){
     Count = 575;
   }else if(Count > 575){
     Count = 0;
   }
  
   delay(10);
   Serial.write(value);  // ここでProcessingにdistanceを送る
  }
}

void establishContact() {
  while (Serial.available() <= 0) {
    Serial.print('A');   // 大文字のAを送る
    delay(300);
  }
}

void ChangePinAB(){
  StatePinA = PIND & 0b00000100;
  StatePinB = PIND & 0b00001000;
  State = (State<<1) + StatePinA;
  State = (State<<1) + StatePinB;
  State = State & 0b00001111;
  Count += ENCODER_TABLE[State];
}
