public class Drums {
    SndBuf kick => dac;
    me.dir(-2)+"/audio/kick_01.wav" => kick.read;
    .5 => kick.gain;

    SndBuf snare => dac;
    me.dir(-2)+"/audio/snare_01.wav" => snare.read;
    .5 => snare.gain;
    
    SndBuf hihat => dac;                      
    me.dir(-2) + "/audio/hihat_01.wav" => hihat.read;  
    0.2 => hihat.gain;

    SndBuf clap => dac;                      
    me.dir(-2) + "/audio/clap_01.wav" => clap.read; 
    
    6 => int kickIndex;
    5 => int snareIndex;
    7 => int hihatIndex;
    4 => int clapIndex;
    
    fun void playBeat(int ca[]) {
        0 => kick.pos;
        1.0 => kick.gain;
    
        0 => snare.pos;
        ca[snareIndex] => snare.gain;
    
        0 => hihat.pos;
        ca[hihatIndex] => hihat.gain;
    
        0 => clap.pos;
        ca[clapIndex] => clap.gain;
    }
}
