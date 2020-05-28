package strings;

import java.util.Scanner;
/*
 * звоним только в рабочие время не болие 5 гудков
 * не болие двух звонков в день
 * 24 часа ответ на емаэл
 * 
 */

public class Correction {
	
	static Scanner in = new Scanner(System.in);

	public static void main(String ...ew) {
		System.out.println("enter string : ");
		String str = in.nextLine();
		System.out.println(correct(str));
	} 
	
	public static String correct(String str) {
		char ms[] = str.toCharArray();
		for(int i =0; i< ms.length; i++) {
			if(ms[i] == '*') {
				ms = delElem(ms,i--);
			}
			else if(ms[i] == 'A') {
				ms = insert(ms,i++);
			}
		}
		return new String(ms);
	}
	public static char[] delElem(char[] ms, int index) {
		char[] result = new char[ms.length - 1];
		System.arraycopy(ms, 0, result, 0, index);
		System.arraycopy(ms, index + 1, result, index, ms.length - index - 1);
		return result;
	}
	
	public static char[] insert(char[] ms, int index) {
		char[] result = new char[ms.length + 1];
		System.arraycopy(ms, 0, result, 0, index+1);
		System.arraycopy(ms, index , result, index+1, ms.length - index);
		return result;
	}

}
