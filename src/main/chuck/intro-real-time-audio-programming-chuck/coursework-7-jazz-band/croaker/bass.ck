// Croaker riddim

// by Paul Reiners, September 2019
// First define some global durations
// BPM = 156
4 * 1::minute / 156.0 => dur whole;

    // sound chain (mandolin for bass)
    Mandolin bass => Pan2 pan => NRev r => dac;     // (1) Mandolin bass player through reverb.
    
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
    
    whole / 4 => dur quarterNote;
    quarterNote / 2 => dur eighthNote;
    
    [quarterNote, quarterNote, eighthNote, eighthNote, quarterNote,
    quarterNote, quarterNote, quarterNote, quarterNote,
    quarterNote, quarterNote, eighthNote, eighthNote, quarterNote,
    quarterNote, quarterNote, quarterNote, quarterNote] @=> dur durs[];
    
    // play every quarter note
    0 => int i;
    while (true) {
        line[i] => int midiNote;
        Std.mtof(midiNote-12) => bass.freq;    // (10) Sets pitch from scale note.
        Math.random2f(0.05,0.5) => bass.pluckPos;    // (11) Random plucking position.
        Math.random2f(-1.0, 1.0) => pan.pan;
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
