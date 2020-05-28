package strings;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public class Addition {

	public static void main(String ...fd) {
		System.out.println(add());
	}

	public static String add() {
		int[] m1 = { 3, 9, 9 };
		int[] m2 = { 3, 9, 9 };
		int[] m3 = new int[m1.length];
		int buf = 0;

		for (int i = m1.length-1, j = 0; i >= 0; i--, j++) {
			m3[j] = m1[i] + m2[i] + buf;
			if (m3[j] >= 10) {
				buf = 1;
				m3[j] = m3[j] - 10;
			} else {
				buf = 0;
			}
		}
		
		return reverseToString(m3);
	}
	
	public static String reverseToString(int ... m3) {
		String result = "";
		for(int i=m3.length-1; i>=0; i--) {
			result+=m3[i];
		}
		return result;
	}

}
