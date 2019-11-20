package lab3.controller;
import lab3.logic.*;
import lab3.view.*;
import lab3.utils.*;
class Manager {

	static void task0() {
		double radian1 = Input.read("Enter amount in radians :"), degree1 = Input.read("Enter amount in degrees :"),
				radian2 = Angel.toRads(degree1), degree2 = Angel.toDegree(radian1);
		Output.exhibit("%f degrees = %f radians", degree1, radian2);
		Output.exhibit("%f radians = %f degrees", radian1, degree2);

	}

	static void task1() {
		double grams = Input.read("Enter mass in grams : "), kilos = MassConverter.gramsToKillos(grams),
				kintals = MassConverter.gramsToKintals(grams), tons = MassConverter.gramsToTons(grams);
		Output.exhibit("%f grams = %f kilos", grams, kilos);
		Output.exhibit("%f grams = %f kintals", grams, kintals);
		Output.exhibit("%f grams = %f tons", grams, tons);
	}

	static void task2() {
		double amount_byte = Input.read("Enter amount of bytes : "), kb = ValueConverter.btToKb(amount_byte),
				mb = ValueConverter.btToMb(amount_byte), gb = ValueConverter.btToGb(amount_byte),
				tb = ValueConverter.btToTb(amount_byte);
		Output.exhibit("%f bytes = %f Kb", amount_byte, kb);
		Output.exhibit("%f bytes = %f Mb", amount_byte, mb);
		Output.exhibit("%f bytes = %f Gb", amount_byte, gb);
		Output.exhibit("%f bytes = %f Tb", amount_byte, tb);

	}

	static void task3() {
		double centimetrs = Input.read("Enter distance in cetimetrs : "),
				metr = DementionConverter.smToMetr(centimetrs), km = DementionConverter.smToKm(centimetrs);
		Output.exhibit("%f cantimetrs = %f metrs", centimetrs, metr);
		Output.exhibit("%f centimetrs = %f Km", centimetrs, km);
	}

	static void task4() {
		double a = Input.read("Enter a : "), b = Input.read("Enter b : ");
		NumberProcessor instance = new NumberProcessor(a, b);
		Output.exhibit("a = %f\nb = %f", instance.a, instance.b);
		instance.change();
		Output.exhibit("After changeing:\na = %f\nb = %f", instance.a, instance.b);
	}

	static void task5() {
		double x = Input.read("Poke mass of lollipops : "), a = Input.read("Poke cost of lollipops : "),
				y = Input.read("Poke mass of marmalade : "), b = Input.read("Poke cost of marmalade : "),
				lollipops_cost=Cost.prising(x, a), marmalade_cost=Cost.prising(y, b), result;
		if (lollipops_cost > marmalade_cost) {
			result=Cost.attitude(lollipops_cost , marmalade_cost);
			Output.exhibit("lollipops costly than marmalade in %f points", result);
		} else {
			result=Cost.attitude(marmalade_cost,lollipops_cost);
			Output.exhibit("lollipops tatty than marmalade in %f points", result);
		}
	}

}
