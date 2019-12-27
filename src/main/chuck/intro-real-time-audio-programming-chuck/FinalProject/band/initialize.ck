// Drum kit:

<<< "Paul Reiners" >>>;
<<< "Starting initialize.ck" >>>;

me.dir() + "/BPM.ck" => string bpmPath;
Machine.add(bpmPath);

me.dir() + "/score.ck" => string scorePath;

Machine.add(scorePath);  // (1) Adds score file for drums
<<< "Ending initialize.ck" >>>;
