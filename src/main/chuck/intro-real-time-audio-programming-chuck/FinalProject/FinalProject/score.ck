// by Paul Reiners, December 2019
// First define some global durations
// BPM = 156

<<< "Starting score.ck" >>>;

BPM t; // Define t Object of Class BPM // (5) Tests your BPM object by making one
t.tempo(156); // set tempo in BPM  // (6) Sets tempo of new BPM object

ElementaryCA elementaryCA;
[0, 0, 0, 1, 1, 1, 1, 0] @=> elementaryCA.ruleset;

[0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0] @=> int gen0[];
<<< gen0[0], gen0[1], gen0[2], gen0[3], gen0[4], gen0[5], gen0[6], gen0[7], gen0[8], gen0[9], gen0[10], gen0[11] >>>;

Bass bass;
CAMoog mog;
Drums drums;

for (0 => int i; i < 1024; i++) {
    if (i % 2 == 0) {
        mog.playNote(gen0);
    }
    
    if (i % 4 == 0) {
        bass.playNote(gen0);
    }
    
    drums.playBeat(gen0);
    
    t.eighthNote => now;

    elementaryCA.getNextGeneration(gen0) @=> int gen1[];
    <<< gen1[0], gen1[1], gen1[2], gen1[3], gen1[4], gen1[5], gen1[6], gen1[7], gen1[8], gen1[9], gen1[10], gen1[11] >>>;
    gen1 @=> gen0;
}

<<< "Ending score.ck" >>>;
