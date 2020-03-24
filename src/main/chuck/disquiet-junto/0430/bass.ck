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
    
        // One drop
        beatNumber % 8 => int eighthNoteCount;
        if (eighthNoteCount != 0 && eighthNoteCount != 1) {
            if (eighthNoteCount % 2 == 0 || eighthNoteCount == 5) {
                ca[4] + 2 * ca[5] + 4 * ca[6] + 8 * ca[7] + eBassString => int bassNote;
                Std.mtof(bassNote) => bass.freq;
                0.8 => bass.noteOn;
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
