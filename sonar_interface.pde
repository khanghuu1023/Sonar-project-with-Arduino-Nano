import processing.serial.*;
import java.awt.event.KeyEvent; 
import java.io.IOException;
Serial nanoPort;

PFont myFont;
int index=0;
int line_x=0;
int line_y=360;
int arc_w=1800;
int arc_l=1800;
float pixsDistance;

float objLocation;

String portData = "";
String dataClean="";

int distanceValue;
int angleValue;
String angleS = "";
String distanceS = "";

String objState="";
void setup(){
  size(1920,1080);//1920x1080:screen resolution
  smooth();
  nanoPort = new Serial(this, "COM6",9600);//setup serial comm with obj nanoPort
  nanoPort.bufferUntil(';');//keeps looking until it gets to ";" then move on to next data
  myFont=loadFont("FootlightMTLight-48.vlw");
  
}
void draw(){
  fill(83,246,14);
  textFont(myFont,100);
  noStroke();
  fill(0,6); 
  rect(0, 0, width, 1080);

 radarDrawing();
 lineDrawing();
 objectDection();
 textDrawing();
}

void serialEvent(Serial nanoPort)//do something before "."
{
  portData=nanoPort.readStringUntil(';');
  
  //assign portData with a string of data(ex portData=12,342->length=6)
  portData=portData.substring(0,portData.length()-1);
  dataClean=trim(portData);//get rid of all white spaces and solve the newline problem
  dataClean=dataClean.substring(0,dataClean.length()-1);
  
  //find the index position of ","     
  index=dataClean.indexOf(","); 
 
  //split the data into angleS and distanceS (both type String)
   angleS=dataClean.substring(0,index);
   distanceS=dataClean.substring(index+1,dataClean.length());
  
  //convert distanceS and angleS to int() and store them in distanceValue and angleValue for later use
  distanceValue=int(distanceS);
  angleValue=int(angleS);
}
  
 void radarDrawing(){
  pushMatrix();
  translate(960,960); // move all points from the default coord system 960pix right and 960pix down
  noFill();
  strokeWeight(2);
  stroke(95,250,31);
  
  //arc lines: arc(x,y,width,height,srtarting angle, eding angle)
  while (arc_w>450 && arc_l>450){
    arc(0,0,arc_w,arc_l,PI,TWO_PI);//here arc_w=arc_l=1800
    arc_w=arc_w-450;
    arc_l=arc_l-450;
 if (arc_w==450 && arc_l==450){
    arc(0,0,arc_w,arc_l,PI,TWO_PI);
   }
  }
  //reset the values to have while loop over and over again
  arc_w=1800;
  arc_l=1800;
  
  // draw the angle lines from 0 deg to 180 in 30deg intervals in CCW dir
  while (line_x<180 && line_y>180){
    line(0,0,930*cos(radians(line_x)),930*sin(radians(line_y)));//here line_x=line_y=0
    line_x=line_x+30;
    line_y=line_y-30;
    if (line_x==180 && line_y==180)
    {
          line(0,0,930*cos(radians(line_x)),930*sin(radians(line_y)));
    }
  }
  line_x=0;
  line_y=360;
  popMatrix();
}

void lineDrawing(){
//fill(0,5); //blurr affect of the moving line
pushMatrix();
//fill(0,5); //blurr affect of the moving line
translate(960,960);
strokeWeight(10);
stroke(25,255,60);
line(0,0,920*cos(radians(angleValue)),920*sin(radians(360-angleValue)));
popMatrix();
}

void objectDection(){
  pushMatrix();
  translate(960,960); // moves the starting coordinats to new location
  strokeWeight(10);
  stroke(255,10,10); // red color
  // limiting the range to 40 cms
  if(distanceValue<40){
    // draws the object according to the angle and the distance
objLocation=map(distanceValue,0,40,0,920);// appropriate scale for distance
fill(255,0,0);
ellipse(objLocation*cos(radians(angleValue)),objLocation*sin(radians(360-angleValue)),5,5);
}
  popMatrix();
}

void textDrawing(){
pushMatrix();
if (distanceValue>40){
  objState="Safe";
}else {
  objState="Danger";
}
textSize(35);
fill(0,0,0);
noStroke();
rect(0, 975, width, 1080);//draw a black rectangle below the radar as a place to display texts with no transparancy
fill(239,250,86);
text("Object: "+ objState,220,1020);
text("Angle: " +angleValue+char(176),1100,1020);
text("Distance: " +distanceValue+ "cm",1400,1020);

textSize(20);
text("10cm",1130,955);
text("20cm",1350,955);
text("30cm",1580,955);
text("40cm",1805,955);

text("30"+char(176),1770,490);
text("60"+char(176),1415,145);
text("90"+char(176),950,22);
text("120"+char(176),475,145);
text("150"+char(176),123,488);
popMatrix();
}
