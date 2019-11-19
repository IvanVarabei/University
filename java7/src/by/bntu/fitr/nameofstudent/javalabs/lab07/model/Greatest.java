package by.bntu.fitr.nameofstudent.javalabs.lab07.model;

public class Greatest {
	final static int NIL=0;
	final static int FIGAR_ONE=1;
	public static boolean isEquals(int...arg) {
		for (int i = NIL; i < arg.length-FIGAR_ONE; i++) {
			if (arg[i]!=arg[i+FIGAR_ONE]) {
				return false;
			}
		}
		return true;
	}

	public static int seekMax(int... arg) {
		int max = arg[NIL];
		for (int i = NIL; i < arg.length; i++) {
			if (arg[i] > max) {
				max = arg[i];
			}
		}
		return max;
	}

	public static int seekMin(int... arg) {
		int max = arg[NIL];
		for (int i = NIL; i < arg.length; i++) {
			if (arg[i] < max) {
				max = arg[i];
			}
		}
		return max;
	}
}
