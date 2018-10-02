/////////////////////////////////////////////////////////////////////////////////
//Connect Arduino to Processing
//This program connects to the Arduino inputs to Processing
//Idea: when I get close to a thorn, the screen turns red (indicating blood)
//Using an ultrasonic sensor to judget the proximity to the thorn on the screen
// Concept: everything works in Processing. Just take the distance input from Arduino
/////////////////////////////////////////////////////////////////////////////////

//This command starts looking for all the serial inputs to the computer
import processing.serial.*;

//Create a serial variable for storing the values received from serial inputs
Serial myPort;

//Creating variables for yPosition
// This variable will store the value of distance from Arduino
int yPos = 0;

// Adding an image of thorns as the background for Processing sketch
// Creating a variable
PImage img1;
PImage img2;

void setup () {

  size (800, 600);

  // List all the serial ports
  println(Serial.list());

  //Change the number below to match your port number of Arduino
  String portName = Serial.list()[2];
  myPort = new Serial(this, portName, 9600);

  // Load the image into the variable
  img1 = loadImage ("img1.png");
  img2 = loadImage ("img2.png");
}

void draw () {

  // Add the background color here and change it when the hand reaches the thorn
  background(#FAF5DC);

  // Put the background image in Processing at the desired location
  image (img1, 0, 100);

  // The background changes to red when you touch the cactus
  if (yPos < 6 ) {
    background(255, 0, 0);
    image (img1, 0, 100);
    // display the thorns again
  }

  /////////////////////////////////////////////////////////////
  // Setting the hand closer to the thorns
  /////////////////////////////////////////////////////////////

  if (yPos > 30) {
    image (img2, 350, 0);
  } else {
    // Put the hand image in Processing at the center of the screen
    // The y position of this image will configure the logic fo the code
    image (img2, 350, (45-yPos)*2);
  }

  // Verify the distance of yPos from the ultrasonic sensor on the Serial Monitor
  println (yPos);
}



//Create a serial event for Arduino's data to come to Processing
void serialEvent (Serial myPort) {
  int inByte = myPort.read();
  // .read function reads all information coming from serial
  //println(inByte);
  //Display whatever you are receiving from the serial

  //Take the serial inputs and adjust the yPos
  //So, whenever the potentiometer gives a different serial value, the line length changes
  yPos = inByte;
}
