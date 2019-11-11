// Author: Paul Reiners
// Implementation of the Shepard tone scale.
// See [illustration](GEBShepardToneScale.jpeg) from _Gödel, Escher, Bach_, by Douglas R. Hofstadter.

12 => int HALF_STEPS_IN_OCTAVE;
4 => int VOICE_COUNT;

SinOsc chord[VOICE_COUNT];

float gain[VOICE_COUNT];
36 => int c1;

for (0 => int i; i < VOICE_COUNT; i++) {
    chord[i] => dac;
}

float gains[HALF_STEPS_IN_OCTAVE];
0.5 => float MAX_GAIN;
for (0 => int i; i < HALF_STEPS_IN_OCTAVE; i++) {
    ((i + 1.0) / HALF_STEPS_IN_OCTAVE) => float fraction;
    Math.sin(fraction * Math.PI / 2.0) * MAX_GAIN => gains[i];
    <<< "gain:", i, gains[i] >>>;
}
while (true) {
    for (0 => int i; i < HALF_STEPS_IN_OCTAVE; i++) {
        for (0 => int j; j < VOICE_COUNT; j++) {
            0 => chord[j].gain;
        }
        
        0.25 * second => now;
        <<< "\nnote:", i >>>; 
        for (0 => int j; j < VOICE_COUNT; j++) {
            <<< "\tvoice", j >>>; 
            c1 + i + HALF_STEPS_IN_OCTAVE * j => int pitch;
            <<< "\t\tpitch:", pitch >>>;
            Std.mtof(pitch) => float freq;
            <<< "\t\tfreq:", freq >>>;
            freq => chord[j].freq;
            0 => int gainIndex;
            0.0 => float gain;
            if (j < 2) {
                i => gainIndex;
            } else {
                HALF_STEPS_IN_OCTAVE - 1 - i => gainIndex;
            }
            gains[gainIndex] => gain;
            if (j == 0 || j == 3) {
                gain / 2.0 => gain;
            }
            
            <<< "\t\tgainIndex:", gainIndex >>>;
            gain => chord[j].gain;
            <<< "\t\tgain:", gain >>>;
        }
        
        2 * second => now;        
    }
}
