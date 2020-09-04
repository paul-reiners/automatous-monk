public class CAMoog {
    Moog mog => Pan2 p => dac;
    1.0 => mog.gain; 
    60 => int mogNote;
    
    fun void playNote() {
        Std.mtof(mogNote) => mog.freq;
        1 => mog.noteOn; 
    }
    
    fun void noteOff() {
        0 => mog.noteOn;
    }
}