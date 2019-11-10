// Author: Paul Reiners
// Implementation of the 
// [Shepard tone](https://en.wikipedia.org/wiki/Shepard_tone).

12 => int HALF_STEPS_IN_OCTAVE;

SinOsc chord[2];

float gain[2];
60 => int c4;
72 => int c5;
1 => int quiet;
quiet => gain[0];
127 => int loud;
loud => gain[1];

chord[0] => dac;
chord[1] => dac;

int chromaticScale[HALF_STEPS_IN_OCTAVE];
float gains[HALF_STEPS_IN_OCTAVE];
for (0 => int i; i < HALF_STEPS_IN_OCTAVE; i++) {
    c4 + i => chromaticScale[i];
    i => float iFloat;
     (iFloat / HALF_STEPS_IN_OCTAVE) * 0.5 => gains[i];
    <<< "gain:", i, gains[i] >>>;
}

while (true) {
    for (0 => int i; i < HALF_STEPS_IN_OCTAVE; i++) {
        <<< "\ni:", i >>>; 
        chromaticScale[i] => int lowPitch;
        lowPitch + 12 => int highPitch;
        Std.mtof(lowPitch) => float lowerFreq;
        <<< "\tlowerFreq:", lowerFreq >>>;
        lowerFreq => chord[0].freq;
        
        Std.mtof(highPitch) => float upperFreq;
        <<< "\tupperFreq:", upperFreq >>>;
        upperFreq => chord[1].freq;
        
        gains[i] => float lowerGain;
        <<< "\tlowerGain:", lowerGain >>>;
        lowerGain => chord[0].gain;
        
        gains[HALF_STEPS_IN_OCTAVE - 1 - i] => float upperGain;
        upperGain => chord[1].gain;
        <<< "\tupperGain:", upperGain >>>;
                
        2 * second => now;
        
        0 => chord[0].gain;
        0 => chord[1].gain;
        
        0.25 * second => now;
    }
}
