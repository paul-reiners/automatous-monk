// Croaker riddim

// by Paul Reiners, September 2019
// First define some global durations
BPM tempo;

    SndBuf kick => dac;
    me.dir(-1)+"/audio/kick_01.wav" => kick.read;
    .5 => kick.gain;

    SndBuf snare => dac;
    me.dir(-1)+"/audio/snare_01.wav" => snare.read;
    .5 => snare.gain;
    
    SndBuf hihat => dac;                      // (1) Hi-hat sound for percussion.
    me.dir(-1) + "/audio/hihat_01.wav" => hihat.read;  // (2) Reads the wave file.
    0.2 => hihat.gain;
    
    tempo.quarterNote => dur quarter;
    
    while (true) {
        // beat 1
        0 => hihat.pos;
        quarter => now;
        
        // beat 2
        0 => hihat.pos;
        quarter => now;
        
        // beat 3
        0 => hihat.pos;
        0 => kick.pos;
        0 => snare.pos;
        quarter => now;
        
        // beat 4
        0 => hihat.pos;
        quarter => now;
    }
