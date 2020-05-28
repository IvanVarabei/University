package oop.exception;

class App {
    public static double sqr(double arg) {
        while (true); // ”дивительно, но  ќћѕ»Ћ»–”≈“—я!
    }
}
class App0 {
    public static double sqr(double arg) {
        throw new RuntimeException();
    }
}
class App1 {
    public static double sqr(double arg) {
        if (System.currentTimeMillis() % 2 == 0) {
            return arg * arg; // ну ладно, вот твой double
        } else {
            while (true);     // а тут "виснем" навсегда
        }
    }
}

class MyException extends Exception {

}

public class Expt {

	public static void main(String... s) throws MyException {
		Integer ui= null;
		Integer integ = ui;
		integ =5;
		try {
			foo();// if Exception is thrown, all bellow will be skipped
			System.out.println("A");
		}
		catch(Exception e) {
			System.out.println("B");
		}
		finally {
			System.out.println("C");
		}
	}
	

	private static void foo() throws MyException{
		try {
			System.out.println("A1");
			throw new MyException();
		}
		catch(Exception e) {
			System.out.println("B1");
			throw new MyException();
		}
		finally {
			System.out.println("C1");
		}
	}
	
}
