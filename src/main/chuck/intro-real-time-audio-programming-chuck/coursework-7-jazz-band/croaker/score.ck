// Croaker riddim

// by Paul Reiners, September 2019
// First define some global durations
// BPM = 156
4 * 1::minute / 156.0 => dur whole;

// start piano         // (1) Starts off with piano chords...
Machine.add(me.dir() + "/piano.ck") => int pianoID;
2*whole => now;

// start drums         // (2) ...then adds hi-hat percussion...
me.dir() + "/drums.ck" => string drumsPath;
Machine.add(drumsPath ) => int drumsID;
2*whole => now;

// start bass          // (3) ...then adds in the walking bass line...
Machine.add(me.dir() + "/bass.ck") => int bassID;
2*whole => now;

// remove drums
Machine.remove(drumsID); // (5) Cuts the percussion for a bit...
2*whole => now;

// add drums back in
Machine.add(drumsPath) => drumsID;   // (6) ...then adds it back in
// let it run for eight more measures
8*whole => now;         // (8) Lets it all run for eight more measures

// bring out the instruments, gradually
Machine.remove(pianoID);     // (6) Pulls out instruments one at a time

2.0 * whole => now;
Machine.remove(bassID);

2.0 * whole => now;
Machine.remove(drumsID);
