// Croaker riddim

// by Paul Reiners, September 2019
// First define some global durations
// BPM = 156
BPM tempo;
tempo.tempo(156.0);

tempo.wholeNote => dur whole;

// start bass          // (3) ...then adds in the walking bass line...
Machine.add(me.dir() + "/bassVerse.ck") => int bassID;
2*whole => now;

8.0 * tempo.quarterNote => now;
Machine.remove(bassID);
