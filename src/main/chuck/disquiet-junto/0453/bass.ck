public class Bass {
    // sound chain (mandolin for bass)
    Mandolin bass => dac;     // (1) Mandolin bass player through reverb.

    // parameter setup 
    0.0 => bass.stringDamping; // (2) Makes strings ring a long time. 
    0.02 => bass.stringDetune; // (3) Gives it a really big bass-sized body.
    0.05 => bass.bodySize;
    1.0 => bass.gain;
    48 => int bassNote;
    Std.mtof(bassNote) => bass.freq;

    fun void playNote() {
        1 => bass.noteOn; 
        1.0 => bass.gain;
    }
    
    fun void noteOff() {
        1 => bass.noteOff; 
        0.0 => bass.gain;
    }
}
