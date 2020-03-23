me.dir() + "CellularChorus0_Coast_c85d9c.wav" => string filename;
if (me.args()) me.arg(0) => filename;

SndBuf buf => Pan2 p1 => dac;
filename => buf.read;

fun void play(SndBuf buf, dur duration, Pan2 p, float offset) {
    while (true) {
        Math.sin(now / second + offset) => p.pan;
        0 => buf.pos;
        Math.random2f(.1,.75) => buf.gain;
        duration => now;
    }
}

spork ~ play(buf, 11000::ms, p1, 0.0);

while (true)
    30::minute => now;
