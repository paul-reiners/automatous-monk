<<< "Paul Reiners" >>>;
<<< "Starting initialize.ck" >>>;

me.dir() + "/BPM.ck" => string bpmPath;
Machine.add(bpmPath);

me.dir() + "/ElementaryCA.ck" => string elementaryCAPath;
Machine.add(elementaryCAPath);  

me.dir() + "/bass.ck" => string bassPath;
Machine.add(bassPath);  

me.dir() + "/score.ck" => string scorePath;
Machine.add(scorePath);  

<<< "Ending initialize.ck" >>>;
