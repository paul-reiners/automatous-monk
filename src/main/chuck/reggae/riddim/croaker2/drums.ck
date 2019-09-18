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
    me.dir(-1)+"/audio/kick_01.wav" => kick.read;
    .5 => kick.gain;
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
    me.dir(-1)+"/audio/snare_01.wav" => snare.read;
    .5 => snare.gain;
    while (true) {
        half => now;
        0 => snare.pos;
        quarter => now;
        quarter => now;
    }
}

// Hi hat drum function
fun void hihat() {        // (4) Function to play hi-hat.
    SndBuf hihat => dac;                      // (1) Hi-hat sound for percussion.
    me.dir(-1) + "/audio/hihat_01.wav" => hihat.read;  // (2) Reads the wave file.
    0.2 => hihat.gain;
    while (true) {
        quarter => now;
        0 => hihat.pos;
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
