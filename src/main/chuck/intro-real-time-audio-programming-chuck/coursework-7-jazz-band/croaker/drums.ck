// Croaker riddim

// by Paul Reiners, September 2019
// First define some global durations
// BPM = 156
4 * 1::minute / 156.0 => dur whole;

    SndBuf kick => dac;
    me.dir(-1)+"/audio/kick_01.wav" => kick.read;
    .5 => kick.gain;

    SndBuf snare => NRev rev => dac;
    me.dir(-1)+"/audio/snare_01.wav" => snare.read;
    .5 => snare.gain;
    0.05 => rev.mix;
    
    SndBuf hihat => dac;                      // (1) Hi-hat sound for percussion.
    me.dir(-1) + "/audio/hihat_01.wav" => hihat.read;  // (2) Reads the wave file.
    0.2 => hihat.gain;
    
    whole / 4 => dur quarter;
    
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
