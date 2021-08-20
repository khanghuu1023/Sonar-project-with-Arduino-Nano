# Sonar-project-with-Arduino-Nano
## Project summary:
An ultrasonic sensor HC-SR04, measuring distance away from objects, is attatched to a microservo SG90 which controls the motion of the sensor back and fort from 0->Pi.

When an object is detected by the ultrasonic sensor within the range of 40cm, a passive buzzer will go off.

All these components are monitored by an Arduino Nano.

The visual interface of the sonar are written in Processing, which is a graphical library using Java. This provides real time visual information about surrounding status, angle position of the servo and measured-distance from detected objects.

### Note(s):
The micro servo used in this project is not able to sweep an entire semi-circle due its poor mechanism. However, I still programmed it to perform the entire semi-circle from 0 to Pi.

[Project youtube link](https://www.youtube.com/watch?v=cBBOxbGwOKA)

