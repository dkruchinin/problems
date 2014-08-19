class Consts {
    public static final int YEAR_FROM = 1901;
    public static final int YEAR_TO = 2000;
    public static final int FIRST_WEEKDAY = 2;
}

class problem19 {
    public static void main(String args[]) {
        int month_days[] = {
            31, // January
            28, // February
            31, // March
            30, // April
            31, // May
            30, // June
            31, // July
            31, // August
            30, // September
            31, // October
            30, // November
            31, // December
        };

        // Weekday of the 01.01.<YEAR_FROM>
        int weekday = Consts.FIRST_WEEKDAY;
        int result = 0;

        for (int year = Consts.YEAR_FROM; year <= Consts.YEAR_TO; year++) {
            boolean isLeap = isLeapYear(year);

            if (!isLeap) {
                month_days[1] = 28;
            }
            else {
                month_days[1] = 29;
            }

            for (int days : month_days) {
                if (weekday % 7 == 0) {
                    result++;
                }

                /*
                 * If there are 31 days in month weekday of the next
                 * month will be differ from the weekday of current one
                 * on 3 positions.
                 * If month has 30 days - on 2 positions.
                 * If it's February and given year is not leap - on 0 positions.
                 * Otherwise(if year is leap and current month is February) - on one position
                 */
                if (days > 29) {
                    if (days % 2 == 0) {
                        weekday += 2;
                    }
                    else {
                        weekday += 3;
                    }
                }
                else if (isLeap) {
                    weekday++;
                }
            }
        }

        System.out.println("Result: " + result);
    }

    public static boolean isLeapYear(int year) {
        return (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0));
    }
}
