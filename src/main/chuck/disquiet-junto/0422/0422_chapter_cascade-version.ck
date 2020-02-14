// Author: Paul Reiners
// February 2020

SndBuf accelerationSound => Pan2 accPan => dac;
SndBuf decelerationSound => Pan2 decPan => dac;

-1.0 => float accPanPos;
 1.0 => float decPanPos;

me.dir() => string path;    

// Sample rate: 48 kHz
"/0422VersionTipitinaVanilla.aif" => string accelerationFilename; 
44100 => int accSamplesPerSecond;

// Sample rate: 32 kHz
"/0422VersionTipitinaOrange.aif" => string decelerationFileName; 
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

accPanPos => accPan.pan;
decPanPos => decPan.pan;
while (factor >= 0.0001) {
    factor * 10000::ms => dur noteLen;
    
    accPos => accelerationSound.pos;
    decSamples => decelerationSound.pos;      
    noteLen => now;
    accPos + Std.ftoi(Math.round(factor * accSamplesPerSecond)) => accPos;
    
    decSamples => decelerationSound.pos;      
    accSamples => accelerationSound.pos;
    noteLen => now;      
    
    decPos => decelerationSound.pos;
    accSamples => accelerationSound.pos;      
    noteLen => now;
    decPos + Std.ftoi(Math.round(factor * decSamplesPerSecond)) => decPos;
    
    factor * 0.5 => factor;
    gain * 0.5 => gain; 
    gain => accelerationSound.gain;
    gain => decelerationSound.gain;
    
    decSamples => decelerationSound.pos;      
    accSamples => accelerationSound.pos;
    noteLen => now;      
}
