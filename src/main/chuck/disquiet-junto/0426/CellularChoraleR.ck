me.dir() + "CellularChorus0_Coast_c85d9c.wav" => string filename;
if (me.args()) me.arg(0) => filename;

SndBuf buf2 => Pan2 p2 => dac;
filename => buf2.read;

fun void play(SndBuf buf, dur duration, Pan2 p, float offset) {
    while (true) {
        Math.sin(now / second + offset) => p.pan;
        0 => buf.pos;
        Math.random2f(.1,.75) => buf.gain;
        duration => now;
    }
}

spork ~ play(buf2, 11010::ms, p2, Math.PI / 2);

while (true)
    30::minute => now;
