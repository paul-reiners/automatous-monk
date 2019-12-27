// by Paul Reiners, September 2019
// First define some global durations
// BPM = 156

<<< "Starting score.ck" >>>;

BPM t; // Define t Object of Class BPM // (5) Tests your BPM object by making one
t.tempo(156); // set tempo in BPM  // (6) Sets tempo of new BPM object

// start drums         // (2) ...then adds hi-hat percussion...
me.dir() + "/drums.ck" => string drumsPath;
Machine.add(drumsPath ) => int drumsID;
4 * 4 * t.quarterNote => now;
Machine.remove(drumsID);

<<< "Ending score.ck" >>>;
