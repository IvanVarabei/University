import java.util.ArrayList;
import java.util.List;

public class Simplex {
    private int rows;
    private int cols;
    private float[][] table;
    private boolean solutionIsUnbounded = false;
    private int iterations = 0;
    List<Integer> N = new ArrayList();

    public static void main(String... adf) {
        System.out.println("Initial table\n" +
                "N(Б)\tB(A0)\t\tA1\t\tA2\t\tA3\t\tA4\t\tA5\t\tA6\t\t\n" +
                "A4\t\t430.00\t\t1.00\t2.00\t1.00\t1.00\t0.00\t0.00\t\n" +
                "A5\t\t460.00\t\t3.00\t0.00\t2.00\t0.00\t1.00\t0.00\t\n" +
                "A6\t\t420.00\t\t1.00\t4.00\t0.00\t0.00\t0.00\t1.00\t\n" +
                "delta k\t0.00\t\t-3.00\t-2.00\t-5.00\t0.00\t0.00\t0.00");
        System.out.println("Iterated column: A3\nN(Б)\tB(A0)\t\tA1\t\tA2\t\tA3\t\tA4\t\tA5\t\tA6\t\t\n" +
                "A4\t\t200.00\t\t-0.50\t2.00\t0.00\t1.00\t-0.50\t0.00\t\n" +
                "A3\t\t230.00\t\t1.50\t0.00\t1.00\t0.00\t0.50\t0.00\t\n" +
                "A6\t\t420.00\t\t1.00\t4.00\t0.00\t0.00\t0.00\t1.00\t\n" +
                "delta k\t1150.00\t\t4.50\t-2.00\t0.00\t0.00\t2.50\t0.00");
        System.out.println("Iterated column: A2\nN(Б)\tB(A0)\t\tA1\t\tA2\t\tA3\t\tA4\t\tA5\t\tA6\t\t\n" +
                "A2\t\t100.00\t\t-0.25\t1.00\t0.00\t0.50\t-0.25\t0.00\t\n" +
                "A3\t\t230.00\t\t1.50\t0.00\t1.00\t0.00\t0.50\t0.00\t\n" +
                "A6\t\t20.00\t\t2.00\t0.00\t0.00\t-2.00\t1.00\t1.00\t\n" +
                "delta k\t1350.00\t\t4.00\t0.00\t0.00\t1.00\t2.00\t0.00");
/*
        float[][] data = {
                {1, 2, 1, 1, 0, 0, 430},
                {3, 0, 2, 0, 1, 0, 460},
                {1, 4, 0, 0, 0, 1, 420},
                {-3, -2, -5, 0, 0, 0, 0},
        };
        Simplex simplex = new Simplex(3, 6);
        simplex.fillTable(data);
        System.out.println("Initial table");
        simplex.print();
        boolean quit = false;
        while (!quit) {
            Simplex.ERROR error = simplex.compute();
            if (error == ERROR.IS_OPTIMAL) {
                quit = true;
            }
            simplex.print();
        }*/
    }

    private void fillN() {
        for (int i = this.cols - this.rows; i < this.cols; ++i) {
            this.N.add(i + 1);
        }
    }

    public Simplex(int numOfConstraints, int numOfUnknowns) {
        this.rows = numOfConstraints + 1;
        this.cols = numOfUnknowns + 1;
        this.table = new float[this.rows][];
        this.fillN();
        for (int i = 0; i < this.rows; ++i) {
            this.table[i] = new float[this.cols];
        }
    }

    public void print() {
        int i;
        for (i = 0; i < this.cols + 1; ++i) {
            if (i == 1) {
                System.out.print("B(A0)\t\t");

            } else if (i == 0) {
                System.out.print("N(Б)\t");
            } else {
                System.out.print("A" + (i - 1) + "\t\t");
            }
        }
        System.out.println();
        for (i = 0; i < this.rows; ++i) {
            if (i == this.rows - 1) {
                System.out.print("delta k\t");
            } else {
                System.out.print("A" + this.N.get(i) + "\t\t");
            }
            String valueB = String.format("%.2f", this.table[i][this.cols - 1]);
            System.out.print(valueB + "\t\t");
            for (int j = 0; j < this.cols - 1; ++j) {
                String value = String.format("%.2f", this.table[i][j]);
                System.out.print(value + "\t");
            }
            System.out.println();
        }
        System.out.println();
    }

    public void fillTable(float[][] data) {
        for (int i = 0; i < this.table.length; ++i) {
            System.arraycopy(data[i], 0, this.table[i], 0, data[i].length);
        }
    }

    public Simplex.ERROR compute() {
        if (this.checkOptimality()) {
            return Simplex.ERROR.IS_OPTIMAL;
        } else {
            int pivotColumn = this.findEnteringColumn();
            System.out.println("\t\t\t\t\t\t\tIterated column: A" + (pivotColumn + 1));
            this.N.set(this.iterations, pivotColumn + 1);
            ++this.iterations;
            float[] ratios = this.calculateRatios(pivotColumn);
            int pivotRow = this.findSmallestValue(ratios);
            this.formNextTableau(pivotRow, pivotColumn);
            return Simplex.ERROR.NOT_OPTIMAL;
        }
    }

    private void formNextTableau(int pivotRow, int pivotColumn) {
        float pivotValue = this.table[pivotRow][pivotColumn];
        float[] pivotRowVals = new float[this.cols];
        float[] pivotColumnVals = new float[this.cols];
        float[] rowNew = new float[this.cols];
        System.arraycopy(this.table[pivotRow], 0, pivotRowVals, 0, this.cols);

        int i;
        for (i = 0; i < this.rows; ++i) {
            pivotColumnVals[i] = this.table[i][pivotColumn];
        }
        for (i = 0; i < this.cols; ++i) {
            rowNew[i] = pivotRowVals[i] / pivotValue;
        }
        for (i = 0; i < this.rows; ++i) {
            if (i != pivotRow) {
                for (int j = 0; j < this.cols; ++j) {
                    float c = pivotColumnVals[i];
                    this.table[i][j] -= c * rowNew[j];
                }
            }
        }
        System.arraycopy(rowNew, 0, this.table[pivotRow], 0, rowNew.length);
    }

    private float[] calculateRatios(int column) {
        float[] positiveEntries = new float[this.rows];
        float[] res = new float[this.rows];
        int allNegativeCount = 0;
        int i;
        for (i = 0; i < this.rows; ++i) {
            if (this.table[i][column] > 0.0F) {
                positiveEntries[i] = this.table[i][column];
            } else {
                positiveEntries[i] = 0.0F;
                ++allNegativeCount;
            }
        }
        if (allNegativeCount == this.rows) {
            this.solutionIsUnbounded = true;
        } else {
            for (i = 0; i < this.rows; ++i) {
                float val = positiveEntries[i];
                if (val > 0.0F) {
                    res[i] = this.table[i][this.cols - 1] / val;
                }
            }
        }
        return res;
    }

    private int findEnteringColumn() {
        float[] values = new float[this.cols];
        //int location = false;
        int count = 0;
        for (int pos = 0; pos < this.cols - 1; ++pos) {
            if (this.table[this.rows - 1][pos] < 0.0F) {
                ++count;
            }
        }
        int location;
        if (count > 1) {
            for (int i = 0; i < this.cols - 1; ++i) {
                values[i] = Math.abs(this.table[this.rows - 1][i]);
            }
            location = this.findLargestValue(values);
        } else {
            location = count - 1;
        }
        return location;
    }

    private int findSmallestValue(float[] data) {
        int location = 0;
        float minimum = data[0];
        for (int c = 1; c < data.length; ++c) {
            if (data[c] > 0.0F && Float.compare(data[c], minimum) < 0) {
                minimum = data[c];
                location = c;
            }
        }
        return location;
    }

    private int findLargestValue(float[] data) {
        float maximum = 0.0F;
        int location = 0;
        maximum = data[0];
        for (int c = 1; c < data.length; ++c) {
            if (Float.compare(data[c], maximum) > 0) {
                maximum = data[c];
                location = c;
            }
        }
        return location;
    }

    public boolean checkOptimality() {
        boolean isOptimal = false;
        int vCount = 0;
        for (int i = 0; i < this.cols - 1; ++i) {
            float val = this.table[this.rows - 1][i];
            if (val >= 0.0F) {
                ++vCount;
            }
        }
        if (vCount == this.cols - 1) {
            isOptimal = true;
        }
        return isOptimal;

    }

    public float[][] getTable() {
        return this.table;
    }

    public static enum ERROR {
        NOT_OPTIMAL, IS_OPTIMAL,UNBOUNDED;

        private ERROR() {
        }
    }
}