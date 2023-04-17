import processing.net.*;
import controlP5.*;

ControlP5 cp5;
Client myClient;
int dist;
int data;
int prevData = 0;
int velocity = 0;
int prevVel;
Slider slider1;
Println console;

void setup() {
 
  //Sets the size of the background
  size(1000, 500);
  
  //makes an object of the client
  myClient = new Client(this, "192.168.4.1", 5200);
 
  cp5 = new ControlP5(this);
  
  //Creates a start and stop button
  cp5.addButton("Start")
  .setValue(0)
  .setPosition(250, 150)
  .setSize(100,100);
  
  cp5.addButton("Stop")
  .setValue(0)
  .setPosition(550,150)
  .setSize(100,100);
  
  slider1 = 
    cp5.addSlider("buggyVel")
    .setPosition(250,300)
    .setRange(0,90)
    .setSize(400,30);
 
  
  data = 0;
}

void draw() {
  
  //Checking for nearby objects
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

  //Getting velocity of buggy
  velocity = myClient.read();
  
  if((prevVel != velocity) && (velocity >= 0)){
    print("Velocity: ");
    print(velocity);
    println("cm/s");
    prevVel = velocity;
  }
  
  slider1.setValue(prevVel);
  
  
  //removes all the previous data stored there
  myClient.clear(); 
}

//mouseClicked event to perform an activity when the buttons are clicked
//myClient.write sends message to the server
//Messages are also printed to inform user of which button has been clicked
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
