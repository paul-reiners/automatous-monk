public class CAMoog {
    Moog bass => dac.right;     
    
    40 => int eBassString;
    
    fun void playNote(int ca[], int beatNumber) {
        // One drop
        beatNumber % 8 => int eighthNoteCount;
        if (eighthNoteCount != 0 && eighthNoteCount != 1) {
            if (eighthNoteCount % 2 == 0 || eighthNoteCount == 5) {
                ca[4] + 2 * ca[5] + 4 * ca[6] + 8 * ca[7] + eBassString => int bassNote;
                Std.mtof(bassNote) => bass.freq;
                1 => bass.noteOn;
                1.0 => bass.gain;
            }
        }
        else {
            0.0 => bass.gain; 
        }
    }
    
    fun void silence() {
        0.0 => bass.gain; 
    }
}
