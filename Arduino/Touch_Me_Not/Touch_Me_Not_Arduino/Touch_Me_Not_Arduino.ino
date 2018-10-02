/////////////////////////////////////////////////////////////////////////////////
//Connect Arduino to Processing
//This program connects to the Arduino inputs to Processing
//Idea: when I get close to a thorn, the screen turns red (indicating blood)
//Using an ultrasonic sensor to judget the proximity to the thorn on the screen
/////////////////////////////////////////////////////////////////////////////////

//Assign pins connections from the ultrasonic sensor to the Arduino. 
// The value of distance would be picked up by Processing
  // echoPin will get the distance value
const int trigPin = 9;
const int echoPin = 10;

// Defining the variables which store the value of duration and distance
long duration;
  //The distance variable is the value we would customize in Processing. 
int distance;


void setup() {
  
    //Serial.begin is the standard way to send anything to a serial monitor
  Serial.begin(9600);

  //For the ultrasonic sensor, the echoPin is the input and the trigPin is the output
  pinMode (trigPin, OUTPUT);
  pinMode (echoPin, INPUT);
  
}

void loop() {

  // Setting up trigPin reset and giving it time to get ready
  ////////////////////////////////////////////
  //Clear the stored values in trigPin
  digitalWrite (trigPin, LOW);
  delayMicroseconds (2);
  // Set trigPin HIGH for 10 microseconds
  digitalWrite (trigPin, HIGH);
  delayMicroseconds (10);
  digitalWrite (trigPin, LOW);
  ////////////////////////////////////////////

  // Start reading the value from the echoPin to calculate the distance
  ////////////////////////////////////////////
  duration = pulseIn (echoPin, HIGH);
  //Calculate the distance
  distance = duration * 0.034/2;
  ////////////////////////////////////////////
  
  // VERIFICATION: Remove this code after you start giving inputs to Processing
    // The serial function conflicts when used twice
    //Serial.print("Distance: ");
    //Serial.println(distance);

  // Conecting Arduino to Processing
    // The value of distance will be sent through Serial inputs to Processing
  Serial.write(distance);
    //The value of distance coming from the ultrasonic sensor will mostly range between 1 and 35
    // So, if you want to use a higher value, use map function in Processing
}
