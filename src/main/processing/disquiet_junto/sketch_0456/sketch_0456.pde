/**
 * Disquiet Junto 456 - Line Up
 * Painting by Agnes Martin
 * 
 * More on this 456th weekly Disquiet Junto project, Line Up (The Assignment: Interpret a painting by Agnes Martin as if it were a graphic score), at:
 *   https://disquiet.com/0456/
 * More on the Disquiet Junto at:
 *   https://disquiet.com/junto/
 * Subscribe to project announcements here:
 *   https://tinyletter.com/disquiet-junto/
 * Project discussion takes place on llllllll.co:
 *   https://llllllll.co/t/disquiet-junto-project-0456-line-up/
 * There’s also a Disquiet Junto Slack. Send your email address to twitter.com/disquiet for Slack inclusion.
 */

import processing.sound.*;

SinOsc[] sineWaves; // Array of sines
float[] sineFreq; // Array of frequencies
int numSines = 5; // Number of oscillators to use

PImage img; 

float[][] matrix = { { 1, 1, 1 },
                     { 1, 1, 1 },
                     { 1, 1, 1 } }; 

void setup() {  
  size(640, 640);
  background(255);
  img = loadImage("agnes_640_640.jpg");  // Load the image into the program  

  sineWaves = new SinOsc[numSines]; // Initialize the oscillators
  sineFreq = new float[numSines]; // Initialize array for Frequencies

  for (int i = 0; i < numSines; i++) {
    // Calculate the amplitude for each oscillator
    float sineVolume = (1.0 / numSines) / (i + 1);
    // Create the oscillators
    sineWaves[i] = new SinOsc(this);
    // Start Oscillators
    sineWaves[i].play();
    // Set the amplitudes for all oscillators
    sineWaves[i].amp(sineVolume);
  }
}

void draw() {
  loadPixels();
  image(img, 0, 0);
  //Map blue hue from 0 to 1
  float blueAtPixel = blue(pixels[mouseX + mouseY * width]) / 255.0;
  //Map blue at the mouseY coordinate logarithmically to 150 - 1150 to create a base frequency range
  float frequency = pow(1000, blueAtPixel) + 150;
  //Use blue in convolution of neighborhood of mouse mapped from -0.5 to 0.5 as a detune argument
  int matrixsize = 3;
  float blue = convolution(mouseX, mouseY, matrix, matrixsize, img);
  float detune = map(blue, 0, 255, -0.5, 0.5);

  for (int i = 0; i < numSines; i++) { 
    sineFreq[i] = frequency * (i + 1 * detune);
    // Set the frequencies for all oscillators
    sineWaves[i].freq(sineFreq[i]);
  }
}

float convolution(int x, int y, float[][] matrix, int matrixsize, PImage img)
{
  float btotal = 0.0;
  int offset = matrixsize / 2;
  for (int i = 0; i < matrixsize; i++){
    for (int j= 0; j < matrixsize; j++){
      // What pixel are we testing
      int xloc = x+i-offset;
      int yloc = y+j-offset;
      int loc = xloc + img.width*yloc;
      // Make sure we haven't walked off our image, we could do better here
      loc = constrain(loc,0,img.pixels.length-1);
      // Calculate the convolution
      btotal += (blue(img.pixels[loc]) * matrix[i][j]);
    }
  }
  // Make sure RGB is within range
  btotal = constrain(btotal, 0, 255);
  // Return the resulting blue hue
  return btotal;
}
    
