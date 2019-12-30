public class CAMoog {
    Moog mog => Pan2 p => dac;
    PulseOsc osc => dac; 
    
    fun void playNote(int ca[]) {
        Math.sin(now / second) => p.pan;
        
        ca[6] + 2 * ca[5] + 4 * ca[7] + 8 * ca[4] + 16 * ca[8] + 32 * ca[2] + 64 * ca[9] => int mogNote;
        Std.mtof(mogNote) => mog.freq;
        1 => mog.noteOn; 
        
        Math.random2f(0.01, 0.5) => osc.width;
        ca[6] + 2 * ca[5] + 4 * ca[7] + 8 * ca[4] + 16 * ca[8] + 32 * ca[2] => int oscNote;
        Std.mtof(oscNote) => osc.freq;
        0.125 => osc.gain; 
    }
}