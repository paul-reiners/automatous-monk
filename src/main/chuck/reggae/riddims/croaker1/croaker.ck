// Croaker riddim

// by Paul Reiners, September 2019
// First define some global durations
// BPM = 156
1.54 :: second => dur whole; // (1) Defines whole, half, and quarter note durations.
whole / 2 => dur half;
whole / 4 => dur quarter;
whole / 8 => dur eighth;

// Kick drum function
fun void kick() {         // (2) Function to play kick drum.
    SndBuf kick => dac;
    me.dir()+"/audio/kick_01.wav" => kick.read;
    // only play every whole note
    while (true) {
        half => now;
        0 => kick.pos;
        quarter => now;
        quarter => now;
    }
}

// Snare drum function
fun void snare() {        // (3) Function to play snare drum.
    SndBuf snare => dac;
    me.dir()+"/audio/snare_01.wav" => snare.read;
    // play with half note tempo
    while (true) {
        half => now;
        0 => snare.pos;
        quarter => now;
        quarter => now;
    }
}

// Hi hat drum function
fun void hihat() {        // (4) Function to play hi-hat.
    SndBuf hihat => dac;
    me.dir()+"/audio/hihat_01.wav" => hihat.read;
    0.2 => hihat.gain;
    // play every quarter note
    while (true) {
        quarter => now;
        0 => hihat.pos;
    }
}

// Bass function
fun void bass() {        // (4) Function to play hi-hat.
    // sound chain (mandolin for bass)
    Mandolin bass => NRev r => dac;     // (1) Mandolin bass player through reverb.
    
    // parameter setup 
    0.1 => r.mix; 
    0.0 => bass.stringDamping; // (2) Makes strings ring a long time. 
    0.02 => bass.stringDetune; // (3) Gives it a really big bass-sized body.
    0.05 => bass.bodySize;
    .5 => bass.gain;
    
    // G major scale data         // (4) Scale array for bass line.
    [43,45,47,48,50,52,54,55] @=> int scale[]; 
    4 => int walkPos;          // (5) Pointer for position within scale.
    [43, 43, 43, 47, 50, 
     48, 48, 48, 42,
     43, 43, 43, 47, 50, 
     48, 48, 0, 42] @=> int line[];
    [quarter, quarter, eighth, eighth, quarter,
     quarter, quarter, quarter, quarter,
     quarter, quarter, eighth, eighth, quarter,
     quarter, quarter, quarter, quarter] @=> dur durs[];

    // play every quarter note
    0 => int i;
    while (true) {
        line[i] => int midiNote;
        Std.mtof(midiNote-12) => bass.freq;    // (10) Sets pitch from scale note.
        Math.random2f(0.05,0.5) => bass.pluckPos;    // (11) Random plucking position.
        if (midiNote != 0) {
            1 => bass.noteOn;
        }
        durs[i] => dur noteDur;
        0.75 * noteDur => now;
        if (midiNote != 0) {
            1 => bass.noteOff;
        }
        0.25 * noteDur => now;
        (i + 1) % line.cap() => i;
    }
}

// Main program to spork our individual drum functions
// start off with kick drum for two measures
spork ~ kick();         // (5) Sporking kick function starts it playing
2*whole => now;

// then add in hi hat after two measures
spork ~ hihat();        // (6) Sporks hi-hat after a time
2*whole => now;

// add snare
spork ~ snare();        // (7) Sporks snare 

// add bass
spork ~ bass();

// let it run for eight more measures
8*whole => now;         // (8) Lets it all run for eight more measures
