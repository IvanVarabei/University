package by.bntu.fitr.varabei.javalabs.lab10.controller;

/*
javac -d bin -sourcepath src src\by\bntu\fitr\poisit\varabei\javatasks\task03\controller\Mananger.java
java by.bntu.fitr.poisit.varabei.javatasks.task03.controller.Mananger

*/
import java.util.Arrays;
import by.bntu.fitr.varabei.javalabs.lab10.model.*;
//import by.bntu.fitr.varabei.javalabs.lab10.model.Logic;
import static by.bntu.fitr.varabei.javalabs.lab10.view.Input.*;
import static by.bntu.fitr.varabei.javalabs.lab10.view.Output.*;

public abstract class Mananger {
	static public void main(String uoi[]) {
		int jj=3,yy=5;
			exhibit("2*2="+ ++jj*8);
		lable: while (true) {
			switch (readInt("M1enu lab10\nChoose number of perform \n" + "1 - Manualy initialization\n"
					+ "2 - Random initialization\n")) {
			case 1:
				int a = readInt("Enter number of elements : ");
				double[] array = new double[a];
				for (int i = 0; i < array.length; i++) {
					array[i] = readD("Enter item : ");
				}
				exhibit("Your array : " + Arrays.toString(array));
				exhibit("Multiplication of negative elements before max : " + Logic.muliplicateNegBefre(array));
				exhibit("Summ positive elements before max : " + Logic.sumPosBefre(array));
				break;
			case 2:
				a = readInt("Enter number of elements : ");
				int max = readInt("Enter max gap : ");
				array = new double[a];
				ArrayInitializer.rndDouble(array, max);
				exhibit("Your array : " + Arrays.toString(array));
				exhibit("Multiplication of negative elements before max : " + Logic.muliplicateNegBefre(array));
				exhibit("Summ positive elements before max : " + Logic.sumPosBefre(array));
				break;
			default:
				break lable;
			}
		}

	}
}