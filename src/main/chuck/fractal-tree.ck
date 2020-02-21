/**
variables : 0, 1
constants: [, ]
axiom : 0
rules : (1 ? 11), (0 ? 1[0]0)

axiom:	0
1st recursion:	1[0]0
2nd recursion:	11[1[0]0]1[0]0
3rd recursion:	1111[11[1[0]0]1[0]0]11[1[0]0]1[0]0
*/

[0] @=> int axiom[];

fun int[] apply_rules(int tree[]) {
    get_next_gen_length(tree) => int next_gen_length;
    int next_gen[next_gen_length];
    0 => int j;
    for (0 => int i; i < tree.cap(); i++) {
        tree[i] => int symbol;
        if (symbol == 0) {
            1 => next_gen[j];
            -2 => next_gen[j + 1];
            0 => next_gen[j + 2];
            -1 => next_gen[j + 3];
            0 => next_gen[j + 4];
            j + 5 => j;
        } else if (symbol == 1) {
            1 => next_gen[j];
            1 => next_gen[j + 1];
            j + 2 => j;
        } else {
            symbol => next_gen[j];
            j + 1 => j;
        }
    }
    
    return next_gen;
}

fun int get_next_gen_length(int tree[]) {
    0 => int len;
    for (0 => int i; i < tree.cap(); i++) {
        tree[i] => int symbol;
        if (symbol == 0) {
            len + 5 => len;
        } else if (symbol == 1) {
            len + 2 => len;
        } else {
            len + 1 => len;
        }
    }
    
    return len;
}

fun void print_tree(int tree[], int gen) {
    <<< "gen:", gen >>>;
    for (0 => int i; i < tree.cap(); i++) {
        string symbol;
        if (tree[i] == 0) {
            "0" => symbol;
        } else if (tree[i] == 1) {
            "1" => symbol;
        } else if (tree[i] == -2) {
            "[" => symbol;
        } else {
            "]" => symbol;
        }
        <<< "     ", symbol >>>;
    }
}

fun void sound_notes(int tree[]) {
    60 => int note;
    .5 / tree.cap() => float gain;
    .5 => float param;
    for (0 => int i; i < tree.cap(); i++) {
        if (tree[i] == 0) {
            Moog moog => dac;
            note => Std.mtof => moog.freq;
            0.8 => moog.noteOn;
            gain => moog.volume;
            param => moog.filterQ;
            <<< "volume:", moog.volume() >>>;
            <<< "filterQ", moog.filterQ() >>>;
        } else if (tree[i] == 1) {
            Moog moog => dac;
            note + 12 => Std.mtof => moog.freq;
            0.8 => moog.noteOn;
            gain => moog.volume;
            param => moog.filterQ;
            <<< "volume:", moog.volume() >>>;
            <<< "filterQ", moog.filterQ() >>>;
        } else if (tree[i] == -2) {
            note - 1 => note;
            param / 2.0 => param;
        } else {
            note + 1 => note;
            (param + 1.0) / 2.0 => param;
        }
    }

    5::second => now;
}

print_tree(axiom, 0);
sound_notes(axiom);

apply_rules(axiom) @=> int tree[];
print_tree(tree, 1);
sound_notes(tree);

apply_rules(tree) @=> tree;
print_tree(tree, 2);
sound_notes(tree);

apply_rules(tree) @=> tree;
print_tree(tree, 3);
sound_notes(tree);
