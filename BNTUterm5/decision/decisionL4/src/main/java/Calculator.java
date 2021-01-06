public class Calculator {
    public static void main(String[] args) {
        System.out.println(" Array:");
        int[][] table = {{3, 4, 6, 5},
                        {7, 6, 10, 8},
                        {8 ,5, 4, 7}};
        int rowAmount = table.length;
        int columnAmount = table[0].length;
        int[] minA;
        int[] minB;
        minA = searchA(table, rowAmount, columnAmount);
        minB = searchB(table, rowAmount, columnAmount);
        for (int i = 0; i < rowAmount; i++) {
            for (int j = 0; j < columnAmount; j++) {
                System.out.print(" " + table[i][j] + " ");
            }
            System.out.println();
        }
        System.out.println("The saddle point has coordinates: (" + (minA[1] + 1) + "," +
                (minB[1] + 1) + ") \nThe net price is: " + minA[0]);
    }

    public static int[] searchA(int[][] array, int rowAmount , int columnAmount) {
        int min = array[0][0];
        int[] arr = new int[columnAmount];
        int[] minCord = {0, 0};
        for (int i = 0; i < rowAmount; i++) {
            for (int j = 0; j < columnAmount; j++) {
                if (array[i][j] < min && j + 1 != 4) {
                    min = array[i][j];
                    arr[i] = min;
                }
                if (j + 1 == 4 && i + 1 != rowAmount) {
                    arr[i] = min;
                    min = array[i + 1][0];
                }
            }
        }
        for (int i = 0; i < columnAmount; i++) {
            if (arr[i] > min) {
                min = arr[i];
                minCord[0] = min;
                minCord[1] = i;
            }
        }
        return minCord;
    }

    public static int[] searchB(int[][] array, int rowAmount , int columnAmount) {
        int max = array[0][0];
        int[] arr = new int[columnAmount];
        int[] minCord = {0, 0};
        for (int j = 0; j < rowAmount; j++) {
            for (int i = 0; i < columnAmount; i++) {
                if (j != columnAmount && i != rowAmount && array[i][j] > max  ) {
                    max = array[i][j];
                    arr[j] = max;
                }
                if (i + 1 == 4 && j + 1 != columnAmount) {
                    arr[j] = max;
                    max = array[0][j + 1];
                } else if (i + 1 == columnAmount)
                    arr[j] = max;
            }
        }
        for (int i = 0; i < columnAmount; i++) {
            if (arr[i] < max) {
                max = arr[i];
                minCord[0] = max;
                minCord[1] = i;
            }
        }
        return minCord;
    }
}





/*
public class Lab {

    public static void main(String[] args) {
        System.out.println(" Array:\n");
        int table[][] = {{4, 9, 5, 3},
                        {7, 8, 6, 9},
                        {7, 4, 2, 6},
                        {8, 3, 4, 7}};
        int n = 4;
        int minA[] = {0, 0}, minB[] = {0, 0};
        minA = searchA(table, n);
        minB = searchB(table, n);
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                System.out.print(" " + table[i][j] + " ");
            }
            System.out.println("");
        }

        System.out.println("\n Седловая точка имеет координаты: (" + (minA[1] + 1) + "," +
                (minB[1] + 1) + ") \n Чистая цена равна: " + minA[0]);
    }

    public static int[] searchA(int[][] array, int n) {
        int min = array[0][0];
        int[] arr = {0, 0, 0, 0};
        int[] minCord = {0, 0};

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (array[i][j] < min && j + 1 != 4) {
                    min = array[i][j];
                    arr[i] = min;
                }
                if (j + 1 == 4 && i + 1 != 4) {
                    arr[i] = min;
                    min = array[i + 1][0];
                }

            }
        }

        for (int i = 0; i < n; i++) {
            if (arr[i] > min) {
                min = arr[i];
                //значение
                minCord[0] = min;
                //номер строки
                minCord[1] = i;
            }
        }

        return minCord;
    }

    public static int[] searchB(int[][] array, int n) {
        int max = array[0][0];
        int[] arr = {0, 0, 0, 0};
        int[] minCord = {0, 0};

        for (int j = 0; j < n; j++) {
            for (int i = 0; i < n; i++) {
                if (array[i][j] > max && j + 1 != 5) {
                    max = array[i][j];
                    arr[j] = max;
                }
                if (i + 1 == 4 && j + 1 != 4) {
                    arr[j] = max;
                    max = array[0][j + 1];
                } else if (i + 1 == 4 && j + 1 == 4)
                    arr[j] = max;

            }
        }

        for (int i = 0; i < n; i++) {
            if (arr[i] < max) {
                max = arr[i];
                minCord[0] = max;
                minCord[1] = i;
            }

        }

        return minCord;
    }
}

 */