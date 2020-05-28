package algorithms;

public class BinarySearch {

	public static void main(String ...sfdg) {
		int [] ms = {1,2,3,4,5,6,7,8,9};
		System.out.println(binarySearch(ms,-91));
	}
	
	static int binarySearch(int [] ms, int n) {
		int l = 0, r = ms.length-1,m = -1;
		while(l<=r) {
			m = (l+r)/2;
			if(ms[m]==n) {
				return m;
			}
			if(ms[m]<n) {
				l = m+1;
			}
			else {
				r=m-1;
			}
		}
		return -1;
	}

}
