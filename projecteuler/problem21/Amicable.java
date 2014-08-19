import java.lang.Math;
import java.util.ArrayList;

class Divisor {
    private Integer divisor;
    private Integer power;

    Divisor(Integer div, int pow) {
        this.divisor = div;
        this.power = pow;
    }

    public Integer getDivisor() {
        return this.divisor;
    }

    public int getPower() {
        return this.power;
    }
}

class Factorizator {
    private ArrayList<Integer> primes;

    Factorizator(Integer limit) {
        Integer num;
        int i;

        primes = new ArrayList<Integer>();
        primes.add(0, 2);
        for (num = 3, i = 1; num < (limit / 2); num += 2) {
            if (this.isPrime(num)) {
                primes.add(i++, num);
            }
        }
    }

    public boolean isPrime(int number) {
        int sroot = (int)Math.sqrt(number);
        int div = 1;

        while (++div <= sroot) {
            if (number % div == 0) {
                return false;
            }
        }

        return true;
    }

    public void dumpPrimes() {
        System.out.print("Primes: [ ");
        for (Integer i: this.primes) {
            System.out.print(" " + i);
        }

        System.out.println(" ]");
    }

    public ArrayList<Divisor> factorize(Integer number) {
        Integer div;
        int pow, i = 0, num_primes = this.primes.size();
        ArrayList<Divisor> factors = new ArrayList<Divisor>();

        div = this.primes.get(i);
        pow = 0;
        while (number > 0) {
            if (number % div == 0) {
                pow++;
                number /= div;
                continue;
            }
            if (pow > 0) {
                factors.add(new Divisor(div, pow));
            }
            if (++i >= num_primes) {
                break;
            }

            pow = 0;
            div = this.primes.get(i);
        }

        return factors;
    }
}

public class Amicable {
    public static final String PROGNAME = new Amicable().getClass().getName();

    public static void main(String[] args) {
        Factorizator fc;
        Integer limit, num, pair, sum = 0;

        if (args.length != 1) {
            showHelp();
        }

        limit = new Integer(args[0]);
        fc = new Factorizator(limit);
        System.out.println("Searching amicable pairs below " + limit + " ...");
        for (num = 10; num < limit; num++) {
            pair = sumDivisors(fc, num);
            if ((pair > num) && num.equals(sumDivisors(fc, pair))) {
                sum += (num + pair);
            }
        }

        System.out.println("Sum of all amicable numbres below " + limit +
                           " is " + sum);
    }

    public static void showHelp() {
        System.out.println("USAGE: " + PROGNAME + " <limit>");
        System.exit(0);
    }

    public static Integer sumDivisors(Factorizator fc, Integer num) {
        ArrayList<Divisor> divisors = fc.factorize(num);
        Integer sum = 1;

        for (Divisor div: divisors) {
            sum *= ((int)Math.pow(div.getDivisor(),
                                  div.getPower() + 1) - 1) /
                (div.getDivisor() - 1);
        }
        if (sum > 1) {
          sum -= num;
        }

        return sum;
    }
}