package lab5.model;

public class Revers {
	final static int FIRST_EXP=10;
	final static int SECOND_EXP=100;
	final static int THERD_EXP=1000;
	final static int NIL=0;
 public static int doRev(int n) {
	 int res=NIL;
	 res+=n/THERD_EXP;
	 n%=THERD_EXP;
	 
	 res+=(n/SECOND_EXP)*FIRST_EXP;
	 n%=SECOND_EXP;
	 
	 res+=(n/FIRST_EXP)*SECOND_EXP;
	 n%=FIRST_EXP;
	 
	 res+=n*THERD_EXP;
	 return res;
 }
}
