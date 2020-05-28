package algorithms;

import java.util.ArrayList;

public class Merge {

	public static void main(String... hello) {
		ArrayList<Integer> a = new ArrayList<Integer>();
		ArrayList<Integer> b = new ArrayList<Integer>();
		a.add(1);
		a.add(3);
		a.add(5);
		
		b.add(2);
		b.add(6);
		b.add(8);
		
		new Merge().merge(a, b);
		a.forEach(f -> System.out.print(f + " "));
		System.out.println();
		b.forEach(f -> System.out.print(f + " "));
		System.out.println();

	}

	void merge(ArrayList<Integer> a, ArrayList<Integer> b) {
		int i = 0, j = 0, k = 0, left = a.size(), right = b.size();

		ArrayList<Integer> copy = new ArrayList<Integer>();
		for (int ii = 0; ii < a.size(); ii++) {
			copy.add(a.get(ii));
		}
		
		int t = a.size();
		for(int ii = 0; ii< t; ii++) {
			a.remove(0);
		}

		while (i < left && j < right) {
			if (copy.get(i) <= b.get(j)) {
				a.add(copy.get(i++));
			} else {
				a.add(b.get(j++));
			}
		}
		while (i < left) {
			a.add(copy.get(i++));
		}
		while (j < right) {
			a.add(b.get(j++));
		}
	}
}
