<<< "Paul Reiners" >>>;

me.dir() + "/BPM.ck" => string bpmPath;
Machine.add(bpmPath);

me.dir() + "/ElementaryCA.ck" => string elementaryCAPath;
Machine.add(elementaryCAPath);  

me.dir() + "/bass.ck" => string bassPath;
Machine.add(bassPath);  

me.dir() + "/Score.ck" => string scorePath;
Machine.add(scorePath);

Score score;  
score.playScore();
