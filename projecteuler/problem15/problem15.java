// Starting in the top left corner of a 2×2 grid, there are 6
// routes (without backtracking) to the bottom right corner.
// How many routes are there through a 20×20 grid?

enum NodeDirection {
    ND_DOWN(0), ND_RIGHT (1);
    private int direction;

    private NodeDirection(int direction) {
        this.direction = direction;
    }

    public int getDirection() {
        return this.direction;
    }
}

class GridNode {
    private int directions[] = null;
    private long pathes = -1;

    public GridNode() {
        directions = new int[2];
        directions[NodeDirection.ND_DOWN.getDirection()] = -1;
        directions[NodeDirection.ND_RIGHT.getDirection()] = -1;
    }

    public void setDirection(NodeDirection ndir, int node) {
        directions[ndir.getDirection()] = node;
    }

    public int right() {
        return this.directions[NodeDirection.ND_RIGHT.getDirection()];
    }

    public int down() {
        return this.directions[NodeDirection.ND_DOWN.getDirection()];
    }

    public boolean isCovered() {
        return (pathes >= 0);
    }

    public void setCoverage(long i) {
        pathes = i;
    }

    public long getCoverage() {
        return pathes;
    }
}

class Grid {
    private GridNode grid[] = null;
    private int dlength, dheigh;

    public Grid(int length, int heigh) {
        int i, j;        

        dlength = length + 1;
        dheigh = heigh + 1;
        grid = new GridNode[dlength * dheigh];        
        for (i = 0; i < dlength; i++) {            
            for (j = 0; j < dheigh; j++) {
                int ld = -1, dd = -1;
                int idx = i + dlength * j;

                if ((i + 1) < dlength) {
                    ld = idx + 1;
                }
                if ((j + 1) < dlength) {
                    dd = idx + dlength;
                }

                grid[idx] = new GridNode();
                grid[idx].setDirection(NodeDirection.ND_RIGHT, ld);
                grid[idx].setDirection(NodeDirection.ND_DOWN, dd);
            }
        }
    }

    public GridNode getNode(int x, int y) {
        return grid[x + y * dlength];
    }

    public long calcPathes(GridNode target) {
        if (getNode(0, 0).equals(target)) {
            return 0;
        }
        if (getNode(1, 0).equals(target)) {
            return 1;
        }
        if (getNode(0, 1).equals(target)) {
            return 1;
        }

        return calcPathesTo(getNode(0, 0), target);
    }

    public long calcPathesTo(GridNode cur, GridNode target) {
        int ri, di;
        long rp = 0, dp = 0;

        if (cur.equals(target)) {
            return 1;
        }

        ri = cur.right();
        if (ri > 0) {
            GridNode rn = grid[ri];
            if (rn.isCovered()) {
                rp = rn.getCoverage();
            }
            else {
                rp = calcPathesTo(rn, target);
                rn.setCoverage(rp);
            }
        }

        di = cur.down();
        if (di > 0) {
            GridNode dn = grid[di];

            if (dn.isCovered()) {
                dp = dn.getCoverage();
            }
            else {
                dp = calcPathesTo(dn, target);
                dn.setCoverage(dp);
            }
        }

        return rp + dp;
    }

    public void dumpGrid() {
        GridNode gn;

        for (int i = 0; i < dheigh; i++) {
            for (int j = 0; j < dlength; j++) {
                gn = getNode(j, i);
                System.out.printf("%d ", gn.getCoverage());
            }

            System.out.println();
        }
    }
}

class problem15 {
    public static void main(String args[]) {
        Grid grid = new Grid(20, 20);
        System.out.println("Pathes: " +
                           grid.calcPathes(grid.getNode(20, 20)));
        grid.dumpGrid();
    }
}
