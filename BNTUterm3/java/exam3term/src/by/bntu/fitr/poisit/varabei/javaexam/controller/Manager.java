package by.bntu.fitr.poisit.varabei.javaexam.controller;

/*
javac -d bin -sourcepath src src\by\bntu\fitr\poisit\varabei\javaexam\controller\Manager.java
"C:\Program Files\Java\jdk1.8.0_221\bin\javac.exe" -d bin -sourcepath src src\by\bntu\fitr\poisit\varabei\javaexam\controller\Manager.java
java by.bntu.fitr.poisit.varabei.javaexam.controller.Manager
"C:\Program Files\Java\jdk1.8.0_221\bin\java" by.bntu.fitr.poisit.varabei.javaexam.controller.Manager
*/
import java.io.IOException;
import java.util.Arrays;
import by.bntu.fitr.poisit.varabei.javaexam.model.*;
import static by.bntu.fitr.poisit.varabei.javaexam.view.Output.*;//
import static by.bntu.fitr.poisit.varabei.javaexam.view.Input.*;

public class Manager {
	public static void main(String[] args) throws IOException {
		 while (true) {
			switch (readInt("Enter nuber of task : ")) {
			case 1:
				int[] ms = new int[7];
				ms = Logic.decay(3242341);
				exhibit("" + Arrays.toString(ms));
				Logic.bubbleSorter(ms);
				exhibit("" + Arrays.toString(ms));
				break;
			case 2:
				exhibit("" + Logic.assembly(1, 2, 3, 4, 5));
				break;
			case 3:
				exhibit("" + Logic.doubleEquals(43, 43));
				exhibit("" + Logic.perfectCheck(69));
				break;
			default:
				return;
			}
		}

	}
}
