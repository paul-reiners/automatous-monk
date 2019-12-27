// Croaker riddim

// by Paul Reiners, September 2019
// First define some global durations
4 * 1::minute / 156.0 => dur whole;

// sound chain 
Rhodey piano[3];             // (1) three notes' worth of electric piano 

piano[0] => dac.left;        // (2) Connects them to left...
piano[1] => dac;             //     ...and center... 
piano[2] => dac.right;       // (3) ...and right dac channels.

// chord 2D array            // (4) Array to hold two chords of four notes each.
[[67,71,74],[67,72,76]] @=> int chordz[][]; 

whole / 4 => dur quarter;

// loop
while (true)                  // (5) Infinite loop
{
    // beat 1
    quarter => now;

    // beat 2
    // build first chord
    for( 0 => int i; i < 3; i++ )
    {                          // (6) Plays first chord...
        Std.mtof(chordz[0][i]) => piano[i].freq;
        Math.random2f(0.3,.7) => piano[i].noteOn;
    }
    quarter => now;
    
    // beat 3
    quarter => now;
    
    // beat 4
    // build first chord
    for( 0 => int i; i < 3; i++ )
    {                          // (6) Plays first chord...
        Std.mtof(chordz[0][i]) => piano[i].freq;
        Math.random2f(0.3,.7) => piano[i].noteOn;
    }
    quarter => now;
    
    // beat 1
    quarter => now;

    // beat 2
    // build second chord
    for( 0 => int i; i < 3; i++ )
    {                          // (7) ...then second chord
        Math.mtof(chordz[1][i]) => piano[i].freq;
        Math.random2f(0.3,.7) => piano[i].noteOn;
    }
    quarter => now;
    
    // beat 3
    quarter => now;
    
    // beat 4
    // build second chord
    for( 0 => int i; i < 3; i++ )
    {                          // (7) ...then second chord
        Math.mtof(chordz[1][i]) => piano[i].freq;
        Math.random2f(0.3,.7) => piano[i].noteOn;
    }
    quarter => now;
}
