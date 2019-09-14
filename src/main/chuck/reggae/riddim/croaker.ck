// Listing 5.14 Drum machine using patterns stored in arrays

1.0 => float BEAT_TIME;

// sound chain: two drums
SndBuf kick => dac;  // (1) SndBufs for kick and snare drum sounds
SndBuf2 sidestick => dac;
SndBuf2 hiHat => dac;
SndBuf2 crash => dac;
SndBuf2 tom3 => dac;
SndBuf2 tom2 => dac;
SndBuf2 tom1 => dac;

// Sound Network
SinOsc chord[3];               // (1) Three oscillators for a chord

// (2) load the sound files for our kick and snare drums
me.dir() + "/audio/kick_01.wav" => kick.read;
me.dir() + "/audio/Side-Stick.wav" => sidestick.read;
me.dir() + "/audio/Closed-Hi-Hat-1.wav" => hiHat.read;
me.dir() + "/audio/Crash-Cymbal-1.wav" => crash.read;
me.dir() + "/audio/Electronic-Tom-3.wav" => tom3.read;
me.dir() + "/audio/Electronic-Tom-2.wav" => tom2.read;
me.dir() + "/audio/Electronic-Tom-1.wav" => tom1.read;

// (3) set their pointers to end, to make no sound
kick.samples() => kick.pos;
sidestick.samples() => sidestick.pos;
hiHat.samples() => hiHat.pos;
// drum patterns as logical variables, // (4) Arrays to hold logical values, play=1/not play=0
[0,0,1,0] @=> int kickPattern1[];
[0,0,1,0] @=> int sidestickPattern1[];
[1,1,1,1] @=> int hiHatPattern1[];

0 => tom1.pos;
2.0 * BEAT_TIME / 3.0 => float tripleQuarter;
tripleQuarter::second => now;

0 => tom2.pos;
tripleQuarter::second => now;

0 => tom1.pos;
tripleQuarter::second => now;

0 => kick.pos;
BEAT_TIME::second => now;

0 => crash.pos;
0 => tom3.pos;
BEAT_TIME::second => now;

fun void playChord(int root, string quality)
{
    // set root of chord
    Std.mtof(root) => chord[0].freq;        // (4) Root of chord.

    // set fifth of chord
    Std.mtof(root+7) => chord[2].freq;      // (5) Fifth of chord.

    // third sets quality, major or minor
    if (quality == "major")
    {
        Std.mtof(root+4) => chord[1].freq;  // (6) Major chord.
    }
    else if (quality == "minor") {
        Std.mtof(root+3) => chord[1].freq;  // (7) Minor chord.
    }
    else
    {
        <<< "You must specify major or minor!!" >>>;
    }
}

for (0 => int i; i < chord.cap(); i++) {    
    // connect each element of our array to dac
    chord[i] => dac;           // (2) Connects them all to the dac...
}

// function to play pattern arrays
fun void playSection(int kickA[], int sidestickA[], int hiHatA[], float beattime)
{  // (5) playSection function, arrayarguments control patterns
    for (0 => int j; j < 2; j++) {
        for (0 => int i; i < kickA.cap(); i++) {
            if (kickA[i])
            {
                0 => kick.pos;
            }
            if (sidestickA[i])
            {
                0 => sidestick.pos;
            }
            if (hiHatA[i])
            {
                0 => hiHat.pos;
            }
            
            if (j == 0) {
                if (i % 2 == 1) {
                    for (0 => int i; i < chord.cap(); i++) {
                        // adjust gain so we don't overload
                        0.125/chord.cap() => chord[i].gain; // (3) ...and sets their gains so you don't overload.
                    }
                    playChord(67, "major");      // (3) Plays a G major chord  
                } 
            } else {
                if (i % 2 == 1) {
                    for (0 => int i; i < chord.cap(); i++) {
                        // adjust gain so we don't overload
                        0.125/chord.cap() => chord[i].gain; // (3) ...and sets their gains so you don't overload.
                    }
                    playChord(60, "major");      // (2) Plays a C major chord
                } 
            }
             
            beattime::second => now;
            for (0 => int i; i < chord.cap(); i++) {
                0 => chord[i].gain; 
            }
        }
    }
}

/*
*/
    

// Main program, infinite loop
while (true)    // (6) Infinite test loop
{               // (7) Call playSection with different patterns
    playSection(kickPattern1,sidestickPattern1, hiHatPattern1,BEAT_TIME);
}
