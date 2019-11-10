// Author: Paul Reiners
// Implementation of the 
// [Shepard tone](https://en.wikipedia.org/wiki/Shepard_tone).

12 => int HALF_STEPS_IN_OCTAVE;
4 => int VOICE_COUNT;

SinOsc chord[VOICE_COUNT];

float gain[VOICE_COUNT];
36 => int c1;

for (0 => int i; i < VOICE_COUNT; i++) {
    chord[i] => dac;
}

float gains[HALF_STEPS_IN_OCTAVE];
for (0 => int i; i < HALF_STEPS_IN_OCTAVE; i++) {
    i => float iFloat;
    (iFloat / HALF_STEPS_IN_OCTAVE) * 0.5 => gains[i];
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
            if (j < 2) {
                i => gainIndex;
                <<< "\t\tgainIndex:", gainIndex >>>;
                gains[gainIndex] => float gain;
                if (j == 0) {
                    if (i == 0) {
                        0.0 => gain;
                    } else {
                        gain / 2.0 => gain;
                    }
                    gain => chord[j].gain;
                }
            } else {
                HALF_STEPS_IN_OCTAVE - 1 - i => gainIndex;
                <<< "\t\tgainIndex:", gainIndex >>>;
                gains[gainIndex] => float gain;
                if (j == 3) {
                    gain / 2.0 => gain;
                }
                gain => chord[j].gain;
            }
        }
        
        2 * second => now;        
    }
}
