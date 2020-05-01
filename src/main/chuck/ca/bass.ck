public class CAMoog {
    Moog bass => NRev nRev => dac.right;
    .05 => nRev.mix;

    fun void playNote(int ca[], int beatNumber, int numStepsPerBar) {
        beatNumber / (4.0 * numStepsPerBar) => float maxParamOffset;
        0.5 - maxParamOffset => float minParam;
        0.5 + maxParamOffset => float maxParam;
        // ding!
        Math.random2f(minParam, maxParam) => bass.filterQ;
        Math.random2f(minParam, maxParam) => bass.filterSweepRate;
        Math.random2f(minParam, maxParam) => bass.lfoDepth;
    
        // One drop
        if (beatNumber != 0 && beatNumber != 1) {
            if (beatNumber % 2 == 0 || beatNumber == 5 || beatNumber == 13) {
                0 => int midiNote;
                for (1 => int i; i < 8; i++) {
                    ca[i] + 2 * midiNote => midiNote;
                }
                <<< "note:", midiNote >>>;
                Std.mtof(midiNote) => bass.freq;
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
