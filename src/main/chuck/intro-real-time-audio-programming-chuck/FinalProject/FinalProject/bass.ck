public class Bass {
    // sound chain (mandolin for bass)
    Mandolin bass => NRev r => dac;     // (1) Mandolin bass player through reverb.

    // parameter setup 
    0.1 => r.mix; 
    0.0 => bass.stringDamping; // (2) Makes strings ring a long time. 
    0.02 => bass.stringDetune; // (3) Gives it a really big bass-sized body.
    0.05 => bass.bodySize;
    .5 => bass.gain;

    fun void playNote(int ca[]) {
        ca[6] + 2 * ca[5] + 4 * ca[7] + 8 * ca[4] + 16 * ca[8] + 32 * ca[2] => int bassNote;
        Std.mtof(bassNote) => bass.freq;
        1 => bass.noteOn; 
    }
}
