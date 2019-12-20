package by.bntu.fitr.poisit.varabei.javatasks.task03.model;

public class Logic {

	final static int DEFAULT = 0;
	final static int ONE_POINT = 1;
	final static int TEN_EXP_ONE = 10;

//UTILS
	
	public static int seekFirstNilPos(int[] array) {
		int pos = 0;
		for (int i = 0; i < array.length; i++) {
			if (array[i] == 0) {
				pos=i;
				break;
			}
		}
		return pos;
	}
	
	public static int seekLastNilPos(int[] array) {
		int pos = 0;
		for (int i = array.length-ONE_POINT; i >=0; i--) {
			if (array[i] == 0) {
				pos=i;
				break;
			}
		}
		return pos;
	}

	public static int seekAmountNoNilsBetween(int[] array) {
		int first = seekFirstNilPos(array),last=seekLastNilPos(array),counter=0;
		for (int i = first+1; i < last; i++) {
			if (array[i] != 0) {
				counter++;
			}
		}
		return counter;
	}
	
	public static int MultiplicateBetween(int[] array) {
		int first = seekFirstNilPos(array),last=seekLastNilPos(array),counter=1;
		for (int i = first+1; i < last; i++) {
				counter*=array[i];		
		}
		return counter;
	}
	
}
