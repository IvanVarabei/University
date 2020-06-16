package algorithms;

import java.util.Arrays;

public class QuickSort {

	public static void main(String... dfgsf) {
		int ms[] = { 3, 6, 1, 0, 9};
		simpleQuickSort(ms, 0, ms.length - 1);
		System.out.println(Arrays.toString(ms));
	}
	

	public static void simpleQuickSort(int [] ms, int low, int high) {
		int mid = (low+high)/2;
		int i = low, j = high;
		while(i<=j) {
			while(ms[i]<ms[mid]) {
				i++;
			}
			while(ms[j]>ms[mid]) {
				j--;
			}
			if(i<=j) {
				int t = ms[i];
				ms[i++] = ms[j];
				ms[j--] = t;
			}			
		}
		if(i<high)
			simpleQuickSort(ms,i,high);
		if(j>low)
			simpleQuickSort(ms,low,j);
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public static void quickSort(int[] array, int low, int high) {
		for (int ii = low; ii <= high; ii++) {
			System.out.print(array[ii] + " ");
		}
		System.out.println();
		if (array.length == 0) {
			System.out.println("array.length == 0");
			return;
		}
		if (low >= high) {
			System.out.println("low >= high");
			return;// завершить выполнение если уже нечего делить
		}
		int middle = (high + low) / 2;
		int opora = array[middle];
		int i = low, j = high;
		while (i <= j) {
			while (array[i] < opora) {
				i++;
			}
			while (array[j] > opora) {
				j--;
			}
			if (i <= j) {
				int temp = array[i];
				array[i] = array[j];
				array[j] = temp;
				i++;
				j--;
				System.out.println(Arrays.toString(array));
			}
		}
		if (low < j)
			quickSort(array, low, j);
		if (high > i)
			quickSort(array, i, high);
	}
}
