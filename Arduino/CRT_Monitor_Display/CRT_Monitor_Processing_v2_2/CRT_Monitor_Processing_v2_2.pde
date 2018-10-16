//////////////////////////////////////////////////////////////////////////////////
////////////////// LEARN HOW A CRT MONITOR WORKS /////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
/////////////////////////// Version 2.2 //////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
// Logic
//The pixel should move from one end of the screen to the other (top to bottom)
// The pixel's movement (frame rate) and brightness should be adjustable
//////////////////////////////////////////////////////////////////////////////////


//Start looking for all the serial inputs to the computer
import processing.serial.*;


//////////////////////////////////////////////////////////////////////////////////
/////////////////////////// VARIABLE DECLARATION /////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

// Variable declaration for Serial Communication
//Create a serial variable for storing the values received from serial inputs
Serial myPort;
// Array to put all values received from serial comm
int[] serialInArray = new int[2];
// Making a count of bytes received from the serial
int serialCount = 0;
// First information received from the microcontroller (Arduino)
boolean firstContact = false;

//Variables to move the pixel
int x;
int y;

//Variables for pixel width
int xGap=20;
int yGap=20;
//For square pixels, xGap = yGap

//Variables to adjust the brightness and the frequency
int brightness = 255; // starting value
  //Take the value of brightness from the slider (Arduino serial connection)
int frequency = 1; // starting value
  //Take the value of frequency from the slidder (Arduino serial connection)


//////////////////////////////////////////////////////////////////////////////////
////////////////////////////// SETUP FUNCTION ////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

void setup () {

  //Window width
  size (1920, 1080);
    //The CRT TV Screen would be inside this screen size
    
  //Set the current pixel position
  x=0;
  y=0;
  
  // See the list of all serial ports
  println (Serial.list());
  
  //Change the number below to match your port number of Arduino
  String portName = Serial.list()[2];
  myPort = new Serial(this, portName, 9600);
  
}


//////////////////////////////////////////////////////////////////////////////////
/////////////////////////////// DRAW FUNCTION ////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

void draw () {


  //Keeping the background in draw function so that it doesn't create a trail
  background(0);

  //Adjust the brightness of the pixel
  fill(255, brightness);
  noStroke();
  //The brightness value would eventually take value from the slider

  //Rectangle position from the center
  rectMode(CENTER);

  // Call the function to generate pixels based on the frequency levels
  generatePixels();
  
  //Adjust the frequency of the motion
  x = x + frequency;
  //The movement because of the draw loop and constant increment in x
  //The frequency value would eventually come from the slider

  //Condition to move to next line from the start of the line
  if (x> (width-xGap)) {
    //Move to next line from the start of the line
    y+=yGap;
    x=0;
  }

  //Condition to restart drawing when the pixel reaches the bottom
  if (y > height) {
    y=0;
  }
}


//////////////////////////////////////////////////////////////////////////////////
/////////////////////// PIXEL GENERATION FUNCTION ////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
// Logic:
// Generate rect (pixels) based on the frequency slider
// On high frequency, the pixels should fill the screen (visually)

void generatePixels () {

  // SINGLE PIXEL
  if (frequency < 30) {
  //Making the pixel (rectangle)
  rect (x + (xGap/2), y + (yGap/2), xGap, yGap);
  }
  
  // PIXEL TRAIL
  if (frequency > 30 && frequency <= 120) {
  //Making a trail
  fill(255, (brightness-100));
  rect (x + (xGap/2), y + (yGap/2), xGap*4, yGap);
  //Making a second trail
  fill(255, (brightness-150));
  rect (x + (xGap/2), y + (yGap/2), xGap*10, yGap);
  }
  
  // PIXEL LINE
  if (frequency > 120 && frequency <= 150) {
    fill (255, brightness);
    rect (x + (xGap/2), y + (yGap/2), width, yGap);   
  }
  
  // PIXEL TWO LINES
  if (frequency > 150 && frequency <= 170) {
    fill (255, brightness);
    rect (x + (xGap/2), y + (yGap/2), width, yGap);
    rect (x + (xGap/2), y + (yGap/2) + 200, width, yGap);
  }
  
  // PIXEL MULTIPLE LINES
  if (frequency > 170 && frequency <= 200) {
    fill (255, brightness);
    rect (x + (xGap/2), y + (yGap/2), width, yGap + 50);
    rect (x + (xGap/2), y + (yGap/2) + 250, width, yGap + 50);
    rect (x + (xGap/2), y + (yGap/2) + 500, width, yGap + 50);
    rect (x + (xGap/2), y + (yGap/2) + 750, width, yGap + 50);
  }
  
  // HALF PAGE
  if (frequency > 200 && frequency <= 230) {
    fill (255, brightness);
    rect (x + (xGap/2), y + (yGap/2), width, height/2);
  }

  // FULL PAGE FLICKER
  if (frequency > 230 && frequency <= 255) {
    fill (255, brightness);
    rect (x + (xGap/2), y + (yGap/2), width, height);
  } 
}


//////////////////////////////////////////////////////////////////////////////////
///////////////////////////// SERIAL FUNCTION ////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
// Logic
// Create a serial event for Arduino's data to come in Processing
// The call the varialble "myPort" in the function and store that value
  // The stored values should be of 2 types: frequency and brightness and assigned to the respective variables

void serialEvent (Serial myPort) {

  int inByte = myPort.read();
    // Declare a variable that reads the value of Arduino coming through Serial
    // .read function reads the value that is coming to myPort 
      // Since myPort is a Serial variable, it will automatically store the Serial value
    
//LOGIC TO USE THE SERIAL INPUT
// if this is the first byte received, and it's an A, clear the serial buffer
// Also, note that you have had the first contact with the microcontroller
// Otherwise, add incoming bte to the array
  if (firstContact == false) {
    if (inByte == 'A') {
      myPort.clear(); // clear the serial port buffer
      firstContact = true; // you've had the first contact with the microcontroller
      myPort.write('A'); // ask for more
    }
  }
  else {
    // Add the latest byte from the serial port to the array:
    serialInArray [serialCount] = inByte;
    serialCount ++;
    // if there are 3 bytes:
    if (serialCount > 1) {
      frequency = serialInArray[0];
      brightness = serialInArray[1];
      // Print the value received for debugging purposes
      println ("Frequency: " + frequency + " & Brightness: " + brightness);
      // Send a capital A to request new sensor readings:
      myPort.write ('A');
      // Reset serialCount:
      serialCount = 0;  
    }
  }  
}





//Special thanks: Archit Kaushik for helping with the code
