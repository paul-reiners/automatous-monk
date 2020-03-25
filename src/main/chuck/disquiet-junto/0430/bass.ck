public class CAMoog {
    Moog bass => NRev nRev => dac.right;
    .05 => nRev.mix;

    40 => int eBassString;
    
    fun void playNote(int ca[], int beatNumber) {
        beatNumber / 64.0 => float maxParamOffset;
        0.5 - maxParamOffset => float minParam;
        0.5 + maxParamOffset => float maxParam;
        // ding!
        Math.random2f(minParam, maxParam) => bass.filterQ;
        Math.random2f(minParam, maxParam) => bass.filterSweepRate;
        Math.random2f(minParam, maxParam) => bass.lfoDepth;
    
        beatNumber % 8 => int eighthNoteCount;
        // One drop
        if (eighthNoteCount != 0 && eighthNoteCount != 1) {
            if (eighthNoteCount % 2 == 0 || eighthNoteCount == 5) {
                0 => int midiNote;
                for (4 => int i; i < 8; i++) {
                    ca[i] + 2 * midiNote => midiNote;
                }
                <<< "note:", midiNote >>>;
                midiNote + eBassString => int bassNote;
                Std.mtof(bassNote) => bass.freq;
                1 => bass.noteOn;
                1.0 => bass.gain;
            }
        } else {
            0.0 => bass.gain; 
        }
    }
    
    fun void silence() {
        0.0 => bass.gain; 
    }
}
