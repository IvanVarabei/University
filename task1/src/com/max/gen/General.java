package com.max.gen;
import com.max.fn.Fun;
import java.util.Scanner;

public class General {

	
	  /*static boolean isEquilateralTriangle(double side1,double side2,double side3){
	  return side1 == side2 && side2 == side3; }*/
	 

	static boolean isSubsecuance(int num) {
		int first = num / 1000;
		int second = (num / 100) % 10;
		int therd = (num / 10) % 10;
		int fourth = num % 10;
		return first > second && second > therd && therd > fourth || first < second && second < therd && therd < fourth;
	}

	static void menu1() {
		Scanner in = new Scanner(System.in);
		System.out.printf("Ferst task\n");
		double a, b, c;
		System.out.printf("Enter a: ");
		a = in.nextDouble();
		System.out.printf("Enter b: ");
		b = in.nextDouble();
		System.out.printf("Enter c: ");
		c = in.nextDouble();
		System.out.println(Fun.isEquilateralTriangle(a, b, c));
	}

	static void menu2() {
		Scanner in = new Scanner(System.in);
		System.out.printf("Second task\n");
		int a, b, c;
		System.out.printf("Enter a: ");
		a = in.nextInt();
		System.out.println(isSubsecuance(a));
	}

	public static void main(String[] args) {
		menu1();
		menu2();
	}
}