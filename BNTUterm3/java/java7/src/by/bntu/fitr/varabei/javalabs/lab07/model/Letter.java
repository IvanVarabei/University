package by.bntu.fitr.varabei.javalabs.lab07.model;

public class Letter {
	final static char VOWELS[] = { 'a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U' };
	final static String VOWEL = "VOWEL";
	final static String CONSONANT = "CONSONANT";
	final static String MISTAKE="error";
	final static int MAX_RANGE=122;
	final static int MIN_RANGE=65;
	final static int START=0;

	public static boolean search(char[] ms,char x) {
		for(int i=START;i<ms.length;i++) {
			if(ms[i]==x) {
				return true;
			}
		}
		return false;
	}
	
	public static String determineLetter(char character) {
		if ((int) character > MAX_RANGE || (int) character < MIN_RANGE) {
			return MISTAKE;
		}
		String res = "";
		if (search(VOWELS,character)) {
			res = VOWEL;
		} else {
			res = CONSONANT;
		}
		return res;
	}
}
