import processing.net.*;
import controlP5.*;

ControlP5 cp5;
Client myClient;
char objectInfo;
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
  .setPosition(200, 150)
  .setSize(100,100);
  
  cp5.addButton("Stop")
  .setValue(0)
  .setPosition(500,150)
  .setSize(100,100);
}



void draw() {
  delay(1000);
  
  if (myClient.active()){
  //read information from the server and print message 
  //if an obstacle is detected nearby
  objectInfo = myClient.readChar();
    if(objectInfo == 'o'){
      println("Object detected around 10cm");
    }
   }
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
