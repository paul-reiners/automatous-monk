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
