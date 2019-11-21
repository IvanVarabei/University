package lab5.model;

public class Revers {
 public static int doRev(int n) {
	 int res=0;
	 res+=n/1000;
	 n%=1000;
	 
	 res+=(n/100)*10;
	 n%=100;
	 
	 res+=(n/10)*100;
	 n%=10;
	 
	 res+=n*1000;
	
	 return res;
 }
}
