package by.bntu.fitr.poisit.varabei.javatasks.task03.controller;

/*
javac -d bin -sourcepath src src\by\bntu\fitr\poisit\varabei\javatasks\task03\controller\Mananger.java
java by.bntu.fitr.poisit.varabei.javatasks.task03.controller.Mananger
*/
import java.util.Arrays;
import static by.bntu.fitr.poisit.varabei.javatasks.task03.view.Input.*;
import static by.bntu.fitr.poisit.varabei.javatasks.task03.view.Output.*;
import java.io.IOException;
import by.bntu.fitr.poisit.varabei.javatasks.task03.model.*;

public class Mananger {
	static public void main(String uoi[]) throws IOException {
		
		lable: while (true) {
			switch (readInt("Menu task3\nChoose number of perform \n" + "1 - Manualy initialization\n"
					+ "2 - Random initialization\n")) {
			case 1:
				int a = readInt("Enter number of elements : ");
			
				int[] array= new int[a];
				for(int i=0 ; i<array.length;i++) {
					array[i]=readInt("Enter item : ");
				}
				exhibit("Your array : " + Arrays.toString(array));
				exhibit("Amount of no nil items between : " + Logic.seekAmountNoNilsBetween(array));
				exhibit("Multiplication between : " + Logic.MultiplicateBetween(array));
				break;
			case 2:
				a = readInt("Enter number of elements : ");
				int max=readInt("Enter max gap : ");
				array= new int[a];
				ArrayInitializer.rndInit(array, max);
				exhibit("Your array : " + Arrays.toString(array));
				exhibit("Amount of no nil items between : " + Logic.seekAmountNoNilsBetween(array));
				exhibit("Multiplication between : " + Logic.MultiplicateBetween(array));
				break;
			default:
				break lable;
			}
		}

	}
}
