public class Drums {
    SndBuf kick => dac;
    me.dir(-1)+"/audio/kick_01.wav" => kick.read;
    .5 => kick.gain;

    SndBuf snare => NRev rev => dac;
    me.dir(-1)+"/audio/snare_01.wav" => snare.read;
    .5 => snare.gain;
    0.05 => rev.mix;
    
    SndBuf hihat => dac;                      // (1) Hi-hat sound for percussion.
    me.dir(-1) + "/audio/hihat_01.wav" => hihat.read;  // (2) Reads the wave file.
    0.2 => hihat.gain;

    SndBuf clap => dac;                      
    me.dir(-1) + "/audio/clap_01.wav" => clap.read; 
    
    6 => int kickIndex;
    5 => int snareIndex;
    7 => int hihatIndex;
    4 => int clapIndex;
    
    fun void playBeat(int ca[]) {
        0 => kick.pos;
        ca[kickIndex] => kick.gain;
    
        0 => snare.pos;
        ca[snareIndex] => snare.gain;
    
        0 => hihat.pos;
        ca[hihatIndex] => hihat.gain;
    
        0 => clap.pos;
        ca[clapIndex] => clap.gain;
    }
}
