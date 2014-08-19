

public class Problem44 {
	public static long getPentagonal(long i) {
		return i * (3 * i - 1) / 2;
	}
	
	public static boolean isPentagonal(long num) {
		double res = (1 + Math.sqrt(1 + 24 * num)) / 6.0;
		return res == (long)res;
	}
	
	public static void main(String[] args) {
		boolean isFound = false;
		long i = 2;

		long start = System.currentTimeMillis();
		while (!isFound) {
			long Pi = getPentagonal(i);
			long j = i - 1;
			
			while (j > 0) {
				long Pj = getPentagonal(j);
				if (isPentagonal(Pi - Pj) && isPentagonal(Pi + Pj)) {
					System.out.println("D = " + (Pi - Pj));
					isFound = true;
					break;
				}
				
				j--;
			}
			
			i++;
		}
		
		System.out.println("Time taken: " + (System.currentTimeMillis() - start) + " ms");
	}
}
