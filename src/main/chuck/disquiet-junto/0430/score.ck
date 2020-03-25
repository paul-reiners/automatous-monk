// by Paul Reiners, December 2019
// First define some global durations
// BPM = 156

<<< "Starting score.ck" >>>;

16 => int NUM_STEPS_PER_BAR;
NUM_STEPS_PER_BAR * NUM_STEPS_PER_BAR => int numSteps;
NUM_STEPS_PER_BAR => int introOutroNumSteps;

BPM t; // Define t Object of Class BPM // (5) Tests your BPM object by making one
72 => int bpm;
t.tempo(bpm); // set tempo in BPM  // (6) Sets tempo of new BPM object

ElementaryCA elementaryCA;
[0, 0, 0, 1, 1, 1, 1, 0] @=> elementaryCA.ruleset;

[0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0] @=> int gen0[];
<<< gen0[0], gen0[1], gen0[2], gen0[3], gen0[4], gen0[5], gen0[6], gen0[7], gen0[8], gen0[9], gen0[10], gen0[11] >>>;

CAMoog mog;

me.dir() + "/DrumProbsXSporks.ck" => string drumsPath;
Machine.add(drumsPath) => int drumJob;  

// Record a short piece of music, roughly two to three minutes in length
now => time t1; 
for (0 => int i; i < introOutroNumSteps; i++) {
    t.quarterNote => now;
}
for (0 => int i; i < numSteps; i++) {
    i % NUM_STEPS_PER_BAR => int beat;
    mog.playNote(gen0, beat, NUM_STEPS_PER_BAR);
    
    t.eighthNote => now;

    elementaryCA.getNextGeneration(gen0) @=> int gen1[];
    <<< "generation", i >>>;
    <<< gen1[0], gen1[1], gen1[2], gen1[3], gen1[4], gen1[5], gen1[6], gen1[7], gen1[8], gen1[9], gen1[10], gen1[11] >>>;
    gen1 @=> gen0;
}
mog.silence();
for (0 => int i; i < introOutroNumSteps; i++) {
    t.quarterNote => now;
}
Machine.remove(drumJob);
now => time t2;
t2 - t1 => dur span;
<<<"total">>>;
<<<span / 60 / 1000>>>;

<<< "Ending score.ck" >>>;
