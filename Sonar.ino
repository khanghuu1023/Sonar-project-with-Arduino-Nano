#include<Servo.h>
Servo servo;
int servoPin=4;
int delayTime=30;
int servoAngle;
//ultraSonic
int trigPin=2;
int echoPin=3;
float airSpeed=0.0343;
float duration, distance;
int buzzerPin=7;
void setup() {
  // put your setup code here, to run once:
pinMode(servoPin,OUTPUT);
servo.attach(servoPin);
pinMode(trigPin,OUTPUT);
pinMode(echoPin,INPUT);
pinMode(buzzerPin,OUTPUT);
Serial.begin(9600);
}

void loop() {
for (servoAngle=0; servoAngle<180; servoAngle=servoAngle+1){
  ultrasonic();
  if(distance<40){
    buzzer();
    //ultrasonic();
  }
  Serial.print(servoAngle);
  Serial.print(",");
  Serial.print(distance);
  Serial.println(";");
  servo.write(servoAngle);
  delay(delayTime);
}
for (servoAngle=180; servoAngle>0; servoAngle=servoAngle-1){
  ultrasonic();
  if(distance<40){
    buzzer();
    }
  Serial.print(servoAngle);
  Serial.print(",");
  Serial.print(distance);
  Serial.println(";");
  servo.write(servoAngle);
  delay(delayTime);
}
}
void ultrasonic(){
  //send out waves for time measurement
digitalWrite(trigPin,LOW);
delayMicroseconds(2);
digitalWrite(trigPin,HIGH);
delayMicroseconds(10);
digitalWrite(trigPin,LOW);
duration=pulseIn(echoPin,HIGH);
distance=airSpeed*(duration/2.);
}
void buzzer(){
  tone(buzzerPin,800,400);
  delay(50); 
}
