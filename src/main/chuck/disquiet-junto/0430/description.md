https://soundcloud.com/paul-reiners-1/solitary-ensembles-x-2-disquiet0430

# Credits

* Drums by NorthWoods (Charlie Kramer)
    * [ChucK code](https://github.com/charliekramer/ChucK/blob/master/Drum%20probs%20x%20sporks.ck) 
    * [Audio rendering](https://soundcloud.com/north_woods/disquiet0429-solitary)

Since Charlie wrote his submission in ChucK, I thought it would be fun to build on it with [my own ChucK code](https://github.com/paul-reiners/automatous-monk/tree/master/src/main/chuck/disquiet-junto/0430).  I wanted to add a bass part.  I decided to use a cellular automaton to generate a sequence of MIDI notes for this bass part, although I ended up not keeping it in the bass register.  I used [1-D cellular automaton 30](https://mathworld.wolfram.com/ElementaryCellularAutomaton.html).  For better or worse, the results are definitely atonal.

# Code

Here is the main ChucK code I wrote:

## ElementaryCK.ck

    public class ElementaryCA {
        int ruleset[8];
        
        fun int rules(int a, int b, int c) {
            7 - (4 * a + 2 * b + c) => int index;
            
            return ruleset[index];
        }
        
        fun int[] getNextGeneration(int currentGeneration[]) {
            currentGeneration.cap() => int width;
            int nextGeneration[currentGeneration.cap()];
            for (0 => int i; i < width; i++) {
                currentGeneration[((i - 1) + width) % width] => int a;
                currentGeneration[i] => int b;
                currentGeneration[(i + 1) % width] => int c;
                
                rules(a, b, c) => nextGeneration[i];
            }
            
            return nextGeneration;
        }
    }

## bass.ck

    public class CAMoog {
        Moog bass => NRev nRev => dac.right;
        .05 => nRev.mix;

        40 => int eBassString;
        
        fun void playNote(int ca[], int beatNumber, int numStepsPerBar) {
            beatNumber / (4.0 * numStepsPerBar) => float maxParamOffset;
            0.5 - maxParamOffset => float minParam;
            0.5 + maxParamOffset => float maxParam;
            // ding!
            Math.random2f(minParam, maxParam) => bass.filterQ;
            Math.random2f(minParam, maxParam) => bass.filterSweepRate;
            Math.random2f(minParam, maxParam) => bass.lfoDepth;
        
            // One drop
            if (beatNumber != 0 && beatNumber != 1) {
                if (beatNumber % 2 == 0 || beatNumber == 5 || beatNumber == 13) {
                    0 => int midiNote;
                    for (4 => int i; i < 8; i++) {
                        ca[i] + 2 * midiNote => midiNote;
                    }
                    <<< "note:", midiNote >>>;
                    midiNote + eBassString => int bassNote;
                    Std.mtof(bassNote) => bass.freq;
                    1 => bass.noteOn;
                    1.0 => bass.gain;
                }
            } else {
                0.0 => bass.gain; 
            }
        }
        
        fun void silence() {
            0.0 => bass.gain; 
        }
    }    }

@NorthWoods
