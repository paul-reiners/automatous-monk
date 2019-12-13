// STK Unit Generator Exercise

<<< "Paul Reiners" >>>;

Moog mog => Pan2 p => Gain input => dac;
1.0 => input.gain;

SndBuf mySound => dac;
me.dir() + "/audio/cowbell_01.wav" => mySound.read;

Delay del[3];

input => del[0] => dac.left;
input => del[1] => dac;
input => del[2] => dac.right;

for (0 => int i; i < 3; i++) {
    del[i] => del[i];
    0.6 => del[i].gain;
    (0.8 + i * 0.3) :: second => del[i].max => del[i].delay;
}

// Example of Josef Matthias Hauer's tropes
[60, 62, 64, 66, 68, 70, 61, 63, 65, 67, 69, 71] @=> int hauersTropes[];

for (0 => int k; k < 2; k++) {
    for (0 => int j; j < 2; j++) {
        for (0 => int i; i < hauersTropes.cap(); i++)
        {
            int note;
            Math.random2f(-1.0, 1.0) => p.pan;
            if (j % 2 == 0) {
                hauersTropes[i] => note;
            } else {
                hauersTropes[hauersTropes.cap() - 1 - i] => note;
            }
            if (k % 2 == 1) {
                note + 12 => note;
            }
            if (i % 3 == 0) {
                0 => mySound.pos;
                play(note, 1.0);
            } else {
                play(note, 0.5);
            }
        }
    }
}

0.25 => mog.vibratoGain;
play(hauersTropes[hauersTropes.cap()-1], 2.0);

 fun void play(int note, float howLong)
{
    Std.mtof(note) => mog.freq;
    1 => mog.noteOn;
    (howLong - 0.05) :: second => now;
    1 => mog.noteOff;
    0.05 :: second => now;
}

