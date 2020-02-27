package references;

public class Passing {
	/*public static void main(String fg[]) {
		// procMs();
		// procObject();
		procPrimitive();
	}*/

	// MASSIVE PROC STARTS
	public static void procMs() {
		int[] ms = new int[2];
		ms[0] = 7;
		System.out.println(ms[0]);
		changeMs(ms);
		System.out.println(ms[0]);
	}

	public static void changeMs(int... ms) {
		int newMs[] = { 3, 4 };
		ms[0] = 8;
		// ms = newMs;
	}
	// MASSIVE PROC ENDS

	// PRIMITIVE PROCESSING STARTS
	public static void procPrimitive() {
		int n = 10;
		System.out.println("n=" + n);
		// pass by value, value is 10
		// ОЕПЕДЮВЮ ОН ГМЮВЕМХЧ, ГМЮВЕМХЕЛ ЪБКЪЕРЯЪ КХРЕПЮК 10
		change_n(n);// we pass coppy of object
		System.out.println("n=" + n);
	}

	public static void change_n(int n) {
		n = 5;
	}
	// PRIMITIVE PROCESSING ENDS

	// OBJECT PROCESSING START
	public static void procObject() {
		Box b = new Box();
		b.print(b);

		changeBox(b);
		b.print(b);

		Box.changeBox1(b);
		b.print(b);

		b.changeBox2(b);
		b.print(b);

		b.changeBox1(b);
		b.print(b);

		b.changeBox3();
		b.print(b);

		renewBox(b);
		b.print(b);
	}
	//янгдюеряъ мнбюъ яяшкнвмюъ оепелеммюъ, 
	//йнрнпюъ яндепфхр рс фе яяшкйс
	//(гмювемхе оепедюбюелнеи яяшкнвмни оепелемни)
	public static void changeBox(Box b) {
		b.x = 7;
	}

	public static Box renewBox(Box b) {
		//б лернд оепедюкюяэ яяшкйю мю назейр
		//щрю яяшкйю гюохяюкюяэ б яяшкнвмсч оепелеммсч
		//янгдюбьсчяъ б лернде
		b = new Box(100);
		//опнхгнькн гюрхпюмхе яяшкйх мю оепбнмювюкэмши назейр
		//осрел опхябнемхъ дпсцни яяшкйх мю дпсцни назейр
		return b;
	}
	// OBJECT PROCESSING ENDS

}

class Box {
	int x;

	public Box() {
		x = 0;
	}

	public Box(int m) {
		x = m;
	}

	public void print(Box box) {
		System.out.println("Box x=" + box.x);
	}

	public static void changeBox1(Box b) {
		b.x = 1;
	}

	public void changeBox2(Box b) {
		// b.x = 2;
		this.x = 2;
	}

	public void changeBox3() {
		x = 3;
	}
}