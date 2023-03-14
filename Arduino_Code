#include <WiFiNINA.h>
char ssid[] = "TeamY3"; 
char pass[] = "#icecream"; 

WiFiServer server(5200);

const int RMOTOR_1 = 9; //S1
const int RMOTOR_2 = 10; //S3
const int LMOTOR_1 = 6; //S2
const int LMOTOR_2 = 5; //S4

//pins controlling the speed of the car
// the left and right are given the same pins as it makes sense for them to be moving at the same speed
// Can switch one to i.e., pin 17 which is close to it
//const int L_pwm = 16; 
//const int R_pwm = 17;

const int LEYE = A5;
const int REYE = A4;
const int US_TRIG = 2;
const int US_ECHO = 3;


volatile int distance; //travel time * speed of the echo / 2
volatile long duration; //used to read the travel time of the echo

int L_Sensor;
int R_Sensor;
char curr_state = 'n';

// setup loop will set the board up before we can run our main loop
void setup() 
{
  // put your setup code here, to run once:
  Serial.begin(9600);

  WiFi.beginAP(ssid, pass); 
  IPAddress ip = WiFi.localIP(); 
  Serial.print("IP Address:"); 
  Serial.println(ip);  //prints arduino's IP to connect the Processing client
  server.begin();

  //Ultrasonic Sensors
  pinMode(US_TRIG, OUTPUT);
  pinMode(US_ECHO, INPUT);

  pinMode(LMOTOR_1, OUTPUT); // here we're saying that the motors will be outputs, 
  pinMode(LMOTOR_2, OUTPUT); // ie. we're sending information (voltage) to them, not receiving any
  pinMode(RMOTOR_1, OUTPUT);
  pinMode(RMOTOR_2, OUTPUT);

  pinMode(LEYE, INPUT); // we are receiving information from the IR sensors, so they are inputs
  pinMode(REYE, INPUT);

  pinMode(LEYE, INPUT_PULLUP);  
  attachInterrupt(digitalPinToInterrupt(LEYE), state, CHANGE);
  pinMode(REYE, INPUT_PULLUP);  
  attachInterrupt(digitalPinToInterrupt(REYE), state, CHANGE);

}

void loop() {
  //Stores inputs from IR sensors in the variables
  L_Sensor = digitalRead(LEYE);
  R_Sensor = digitalRead(REYE);

  WiFiClient client = server.available(); 
  
  if (client.connected()) { 
    Serial.println("Client connected");
    
      //read request from controller
      curr_state = client.read();
  
      if(curr_state == 'y'){
        if(distance > 10){    
          Serial.println("Starting motor");
          forwards();   
        }
      }

      else if(curr_state == 'n'){
        Serial.println("Stopping motor");
        breaks();          
      }
  }

  if(curr_state != 'n'){

    state();
    check_distance();

    if(distance < 10 ){
      //inform controller of obstacle ahead.
      //breaks();
      client.write('o');
    }
  }
}
  
void state(){
  if((L_Sensor == 1) &&  (R_Sensor == 1)){//implies that the car has steered to the right
      //solution: steer it to the left
    forwards();   
  }
  //0 - detects black line, 1 - does not detect black line
  else if((L_Sensor == 1) && (R_Sensor == 0)){//implies that the car has steered to the right
    //solution: steer it to the left
    turnRight();   
  }
  else if((L_Sensor == 0) && (R_Sensor == 1)){//implies that the car has steered to the left
    //solution: steer it to the left  
    turnLeft(); 
  }
  else{
    forwards();
  }

}

//Checks for any obstacles around 10cm or less ahead
void check_distance(){
  
  digitalWrite(US_TRIG, LOW);
  delayMicroseconds(2);

  digitalWrite(US_TRIG, HIGH);
  delayMicroseconds(10);
  digitalWrite(US_TRIG, LOW);

  duration = pulseIn(US_ECHO, HIGH);
  int distance = duration/58;


  if(distance < 10){
    breaks(); 
    //Serial.println("Obstacle detected about 10cm away!");
  }

  delay(500);
}

//Motor functions for speed and direction
void forwards()
{
  analogWrite(LMOTOR_1, 107); // analogWrite allows us choose what voltage we send to the motor, instead of digitalWrite which is either full power or sero power
  analogWrite(LMOTOR_2, 0);
  analogWrite(RMOTOR_1, 117); // the right motor is slightly slower than the left one due to friction/wear/etc... so we give it a higher voltage than the left one (ie its been calibrated)
  analogWrite(RMOTOR_2, 0);
}

void reverse()
{
  analogWrite(LMOTOR_1, 0);
  analogWrite(LMOTOR_2, 107);
  analogWrite(RMOTOR_1, 0);
  analogWrite(RMOTOR_2, 117);
}

void breaks()
{
  analogWrite(LMOTOR_1, 0);
  analogWrite(LMOTOR_2, 0);
  analogWrite(RMOTOR_1, 0);
  analogWrite(RMOTOR_2, 0);
}

void turnRight()
{
  analogWrite(LMOTOR_1, 200);
  analogWrite(LMOTOR_2, 0);
  analogWrite(RMOTOR_1, 95);
  analogWrite(RMOTOR_2, 0);
}

void turnLeft()
{
  analogWrite(LMOTOR_1, 95);
  analogWrite(LMOTOR_2, 0);
  analogWrite(RMOTOR_1, 200);
  analogWrite(RMOTOR_2, 0);
}
