class TriangNode {
    private Long number;
    public boolean covered;

    TriangNode(Long number) {
        this.number = number;
        covered = false;
    }

    public Long getNumber() {
        return number;
    }

    public void setNumber(Long number) {
        this.number = number;
    }
}

class Triangular {
    private int depth;
    private int items;
    private TriangNode triang[];

    Triangular(String numbers[]) {
        items = numbers.length;
        triang = new TriangNode[items];
        depth = 0;
            
        for (int i = 0, j = 0, k = 1; i < items; i++) {
            triang[i] = new TriangNode(new Long(numbers[i]));
            if (i == j) {
                depth++;
                j += ++k;
            }
        }
    }

    public int getItems() {
        return this.items;
    }

    public int getDepth() {
        return this.depth;
    }

    public long countMaxSum(int idx, int level) {        
        if (level == depth) {
            return triang[idx].getNumber();
        }            
        if (!triang[idx].covered) {
            long left_sum, right_sum;
            left_sum = countMaxSum(idx + level, level + 1);
            right_sum = countMaxSum(idx + level + 1, level + 1);
            if (left_sum > right_sum) {
                triang[idx].setNumber(left_sum + triang[idx].getNumber());
            }
            else {
                triang[idx].setNumber(right_sum + triang[idx].getNumber());
            }

            triang[idx].covered = true;
        }

        return triang[idx].getNumber();
    }
}

class problem17 {
    public static void main(String args[]) {
        Triangular t = new Triangular(args);

        System.out.println("Triangular with depth "
                           + t.getDepth() + " and number of items = "
                           + t.getItems() + " has MAX SUM = "
                           + t.countMaxSum(0, 1));
    }
}