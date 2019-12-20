package by.bntu.fitr.poisit.varabei.javatask.task02.controller;
import  by.bntu.fitr.poisit.varabei.javatask.task02.model.Logic;
import java.util.Scanner;

class Output { 
 public static void exhibit(String str) {
	 System.out.printf(str+"\n");}
 }

class Input {
	public static double read(String str) {
		System.out.printf("\n"+str+"\n");
		Scanner in = new Scanner(System.in);
		return in.nextDouble();
	}
}

public class Start{

public static void main(String args[]){
	Scanner in = new Scanner(System.in);
	int num;
	while(true){
		num=(int)Input.read("***Armstrong numbers***\nInput your number:");
		/*System.out.printf("***Armstrong numbers***\nInput your number:");
		num=in.nextInt();*/
			Output.exhibit(Logic.numCheck(num));
		}
	}
}

