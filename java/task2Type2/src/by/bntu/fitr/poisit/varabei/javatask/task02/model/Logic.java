package by.bntu.fitr.poisit.varabei.javatask.task02.model;

public class Logic{

	public static int stepen(int a,int b){
		int result = b;
		for(int i=1 ; i < a ; i++){
			result *= b;}
		return result;}

	public static int summa(int a,int n){
		int addition = 0;
		int d = n;
		int b = a % 10;
		while(a >= 1){
			addition += stepen( d , b );
			a /= 10;
			b = a % 10;}
		return addition;}

	public static String numCheck( int n ){
 		int e = stepen( n , 10 );
		String str = " ";
		for(int i = stepen( n-1 , 10 ); i <= e ; i++){
			if( summa(i,n) == i){
				str += i;
				str += "  ";}
			} 
		return str + "\n";}
}