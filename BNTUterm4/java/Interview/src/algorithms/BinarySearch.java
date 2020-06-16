package algorithms;

public class BinarySearch {

	public static void main(String... sfdg) {
		int[] ms = { 1, 2, 3, 4, 5, 6, 7, 8, 9 };
		System.out.println(binary(ms, 4));
	}

	static int binary(int[] ms, int e) {
		int l = 0;
		int r = ms.length - 1;
		while (l <= r) {
			int mid = (l + r) / 2;
			if (ms[mid] == e) {
				return mid;
			}
			if (ms[mid] < e) {
				l = mid + 1;
			}
			if (ms[mid] > e) {
				r = mid - 1;
			}
		}
		return -1;
	}

}
