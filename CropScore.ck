// Crop Score, by Paul Reiners, 2020
PulseOsc innerP => dac; 
PulseOsc outerP => dac; 

0.01 => float LOWER_WIDTH;
0.5 => float UPPER_WIDTH;

3 => int OUTER_CIRCLE_COUNT;
7 => int INNER_CIRCLE_RADIUS;

UPPER_WIDTH - LOWER_WIDTH => float widthRange;
84.0 => outerP.freq; 
100.0 => innerP.freq;
  
for (0 => int i; i <= OUTER_CIRCLE_COUNT; i++) {
    playOuterVoice(i);
}

for (OUTER_CIRCLE_COUNT => int i; i >= 0; i--) {
    playOuterVoice(i);
}

fun void playInnerVoice(int index) {
    LOWER_WIDTH + index * (widthRange / INNER_CIRCLE_RADIUS) => float innerWidth;
    innerWidth => innerP.width; 

    1 => innerP.gain;                        
    0.15 :: second => now;              
        
    0.0 => innerP.gain;                      
    0.1 :: second => now;              
}

fun void playOuterVoice(int index) {
    LOWER_WIDTH + index * (widthRange / OUTER_CIRCLE_COUNT) => float outerWidth;
    outerWidth => outerP.width; 
    
    1 => outerP.gain;                        
    for (0 => int j; j <= INNER_CIRCLE_RADIUS; j++) {
        playInnerVoice(j);              
    }
    for (INNER_CIRCLE_RADIUS => int j; j >= 0; j--) {
        playInnerVoice(j);              
    }
    0 => outerP.gain;
}
