public class Prime {
    fun int isPrime(int n) {
        if (n < 2) {
            return 0;
        } else {
            Math.sqrt(n) $ int => int upper;
            2 => int i;
            while (i <= upper) {
                if (n % i == 0) {
                    return 0;
                }
                i++;
            }
            
            return 1;
        }
    }
}
