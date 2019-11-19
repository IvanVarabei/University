package by.bntu.fitr.poisit.varabei.javatask.task02.model;

public class Logic{
	public static boolean numCheck(int n){
 		int summ1=0;
		for (int i=1;i<n;i++){
   			 if(n%i==0){
				summ1+=i;
			  }
		}
 		if(n==summ1){
 			return true;
		}
 		else {
			return false;
		}
	}
}