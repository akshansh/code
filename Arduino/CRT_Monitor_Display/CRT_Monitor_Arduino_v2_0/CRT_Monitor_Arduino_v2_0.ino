/////////////////////////////////////////////////////////////////////////////////
////////////////// LEARN HOW A CRT MONITOR WORKS ////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////// Version 2.0 /////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
// Logic
// 2 connections are done with the Arduino: slider 1, and slider 2
// Arduino is connected to Processing through Serial Communication.
  // So, interaction on these components shows results on the laptop running Processing
  // The idea is to make the slider buttons mimic the operation of a CRT Monitor (an old TV basically)
  // The button indicates start and the two sliders are for adjusting the brightness and frequency
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////////
///////////////////////// Declaring Variables ///////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
//Assign pins connections from the electronic components to the Arduino. 
int frequency = 0;
  // The value of slider 1 goes to the analog pin A0 of the Arduino 
int brightness = 0; 
  // The value of slider 2 goes to the analog pin A3 of the Arduino
int inByte = 0;
  // The serial byte variable going to Processing


/////////////////////////////////////////////////////////////////////////////////
////////////////////////// Setup Function ///////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
void setup() {
  
  //Serial.begin is the standard way to send anything to a serial monitor
  Serial.begin(9600);

  //Create a function that idenfies conection establishment and call it here
  establishContact();
    // Idea: send a byte to establish contact until the receiver responds 
}


/////////////////////////////////////////////////////////////////////////////////
/////////////////////////// Loop Function ///////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
void loop() {

  // The idea is to know whether we are getting a byte request from Arduino
  // When we get that request, read the slider values and write them in variables
  if (Serial.available() > 0) {
    // READ OPERATION
    inByte = Serial.read(); // get incoming byte
    frequency = analogRead(A0)/4;
      // When the reading starts, read the frequency
      // Divide by 4 to bring in the range 0-255
      // If you keep the value as is, change the settings in Processing and canvas size
    delay (10);
      // Add a delay of 10ms to let the ADC recover
    brightness = analogRead(1)/4;
      // Now, read the brightness value
      // analogRead(1) means the A1 connection on Arduino
      // Divide by 4 to bring in the range 0-255
      // If you keep the value as is, change the settings in Processing and canvas size

    // WRITE OPERATION
    // Write the values received above in the respective variables to make them usable
    Serial.write (frequency);
    Serial.write (brightness);
    }
}


/////////////////////////////////////////////////////////////////////////////////
//////////////////// Establish Contact Function /////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
void establishContact() {
  while (Serial.available () <= 0) {
    Serial.print('A'); // Send a capital A
    delay(300);
  }
}
