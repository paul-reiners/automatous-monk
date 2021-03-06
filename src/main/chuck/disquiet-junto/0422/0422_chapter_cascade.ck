// Author: Paul Reiners
// February 2020

SndBuf accelerationSound => Pan2 accPan => dac;
SndBuf decelerationSound => Pan2 decPan => dac;

-1.0 => float accPanPos;
 1.0 => float decPanPos;

me.dir() => string path;    

// Sample rate: 48 kHz
"/accNorm.aif" => string accelerationFilename; 
48000 => int accSamplesPerSecond;

// Sample rate: 32 kHz
"/decNorm.aif" => string decelerationFileName; 
32000 => int decSamplesPerSecond;

path+accelerationFilename => accelerationFilename;  
path+decelerationFileName => decelerationFileName;  

accelerationFilename => accelerationSound.read;
0.5 => float gain;   
gain => accelerationSound.gain;

decelerationFileName => decelerationSound.read;   
gain => decelerationSound.gain;

decelerationSound.samples() => int decSamples;
accelerationSound.samples() => int accSamples;

0 => int accPos;
0 => int decPos;

1.0 => float factor;

while (factor >= 0.0001) {
    factor * 1000::ms => dur noteLen;
    accPanPos => accPan.pan;
    decPanPos => decPan.pan;
    
    accPos => accelerationSound.pos;
    decSamples => decelerationSound.pos;      
    noteLen => now;
    accPos + Std.ftoi(Math.round(factor * accSamplesPerSecond)) => accPos;
    
    decPos => decelerationSound.pos;
    accSamples => accelerationSound.pos;      
    noteLen => now;
    decPos + Std.ftoi(Math.round(factor * decSamplesPerSecond)) => decPos;
    
    factor * 0.9 => factor;
    (accPanPos + 0.0) / 2.0 => accPanPos; 
    (decPanPos + 0.0) / 2.0 => decPanPos;
    gain * 0.9 => gain; 
    gain => accelerationSound.gain;
    gain => decelerationSound.gain;
}