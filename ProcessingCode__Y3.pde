import processing.net.*;
import controlP5.*;

ControlP5 cp5;
Client myClient;
int dist;
int data = 0;
int prevData = 0;
int buggyVel=0;
Slider slider1;
Println console;

void setup() {
 
  //Sets the size of the background
  size(1000, 500);
  
  //makes an object of the client
  myClient = new Client(this, "192.168.4.1", 5200);
 
  cp5 = new ControlP5(this);
  
  //Creates two buttons and sets their value, size and position
  cp5.addButton("Start")
  .setValue(0)
  .setPosition(250, 150)
  .setSize(100,100);
  
  cp5.addButton("Stop")
  .setValue(0)
  .setPosition(550,150)
  .setSize(100,100);
  
  slider1 = cp5.addSlider("buggyVel").setPosition(250,300).setRange(0,225)
     .setSize(400,30);
  //Making a velocity slider

  
   /*cp5.addSlider("buggyVel")
     .setPosition(250,300)
     .setSize(400,30)
     .setRange(0,225)
     .setValue(buggyVel);
  
   
   /*  cp5.addTextfield("Buggy's Velocity")
    .setPosition(250, 300)
    .setSize(400, 40)
    .setFocus(true)
    .setColor(color(255, 0, 0));
  */
  
  data = 0;
  buggyVel = 0;
}
int i = 0;


void draw() {
  
  dist = myClient.read();
  
  if((prevData != dist) && (dist == 10 || dist == 30)){
    
   data = dist;
   
   if(dist == 10){
    println("Obstacle detected");
   }
   
   else if(dist == 30){
    println("No obstacle detected");
   }
  }
  
  prevData = data;
  
  //removes all the previous data stored there
  myClient.clear(); 
}

//mouseClicked event to perform an activity when the buttons are clicked
//myClient.write sends message to the server
//Print messages to inform user of which button has been clicked
void mouseClicked(){

   if(mouseX > 200 & mouseX < 300 && mouseY > 150 && mouseY<250){
     myClient.write('y');   
     println("Start Button Pressed");
   }
   
   if(mouseX > 500 & mouseX < 600 && mouseY > 150 && mouseY<250){
     myClient.write('n');    
     println("Stop Button Pressed");
   }
}
