package by.bntu.fitr.poisit.varabei.javatask.task02.controller;
import  by.bntu.fitr.poisit.varabei.javatask.task02.model.Logic;
import java.util.Scanner;


public class Start{

public static void main(String args[]){
	Scanner in = new Scanner(System.in);
	int num;
	while(true){
		System.out.printf("***Checking for a perfect number***\nInput your number:");
		num=in.nextInt();

		if(Logic.numCheck(num)){
			System.out.printf("You number is Perfect number!\n\n");}

		else{
			System.out.printf("You number is NOT Perfect number!\n\n");}
		if( num==666 ) break;
		}
	}
}