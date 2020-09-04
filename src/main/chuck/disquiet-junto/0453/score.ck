// by Paul Reiners, December 2020

<<< "Starting score.ck" >>>;

BPM t; // Define t Object of Class BPM // (5) Tests your BPM object by making one
t.tempo(40); 

ElementaryCA elementaryCA;
[0, 0, 0, 1, 1, 1, 1, 0] @=> elementaryCA.ruleset;

[0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0] @=> int gen0[];

Bass bass;
CAMoog mog;
Drums drums;
Prime p;

for (1 => int i; i < 1024; i++) {
    if (p.isPrime(i) == 1) {
        mog.playNote();
        bass.playNote();
    } else {
        mog.noteOff();
        bass.noteOff();
    }
    
    drums.playBeat(gen0);
    
    t.quarterNote => now;

    elementaryCA.getNextGeneration(gen0) @=> int gen1[];
    gen1 @=> gen0;
}

<<< "Ending score.ck" >>>;
