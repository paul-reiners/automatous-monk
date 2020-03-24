public class CAMoog {
    // sound chain (mandolin for bass)
    Mandolin bass => dac;     // (1) Mandolin bass player

    // parameter setup 
    0.0 => bass.stringDamping; // (2) Makes strings ring a long time. 
    0.02 => bass.stringDetune; // (3) Gives it a really big bass-sized body.
    0.05 => bass.bodySize;
    
    fun void playNote(int ca[], int beatNumber) {
    // One drop
        if (beatNumber % 4 != 0) {
            ca[0] + 2 * ca[1] + 4 * ca[2] + 8 * ca[3] + 3 * 12 => int bassNote;
            Std.mtof(bassNote) => bass.freq;
            1 => bass.noteOn; 
            1.0 => bass.gain;
        }
        else {
            0.0 => bass.gain; 
        }
    }
}
