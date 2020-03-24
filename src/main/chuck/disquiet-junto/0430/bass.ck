public class CAMoog {
    Moog bass => dac.right;
    
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