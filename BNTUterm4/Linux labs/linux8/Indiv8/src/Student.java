import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Scanner;

class Programm {
	public static void main(String[] f) {
		int n = 10;
		String line;
		Student ms[] = new Student[n];
		Student ms1[] = new Student[n];
		ms1 = Creator.createLot(n);
		List<String> strms = new ArrayList<>();
		while (true) {
			switch (Input.readInt(
					"1-create ms\n2-write ms to file\n3-read from file to ms\n4-show init ms\n" + 
			"5-show new ms\n6-edit file\n")) {
			case 1:
				ms = Creator.createLot(n);
				break;
			case 2:
				try {
					File file = new File("data.txt");
					if (!file.exists()) {
						file.createNewFile();
					}
					PrintWriter pw = new PrintWriter(file);
					for (int i = 0; i < ms.length; i++) {
						for (int j = 0; j < 2; j++) {
							switch (j) {
							case 0:
								pw.println(ms[i].getName());
								break;
							case 1:
								pw.println(ms[i].getMark());
								break;

							}
						}
					}
					pw.close();
				} catch (Exception e) {

				}
				break;
			case 3:
				try {
					File file = new File("data.txt");
					if (!file.exists()) {
						System.out.println("File is not exists!");
						break;
					}
					BufferedReader br = new BufferedReader(new FileReader("data.txt"));
					

					while ((line = br.readLine()) != null) {
						System.out.println(line);
						strms.add(line);

					}
					int j = 1;
					for (int i = 0; i< strms.size(); i++) {
						if (j % 2 != 0) {
							ms1[i].setName(strms.get(i));
						} else {
							ms1[i].setMark(Integer.parseInt(strms.get(i)));
						}
						j++;
					}
					br.close();
				} catch (Exception e) {
					System.err.println("Exception is thrown !");
				}
				break;
			case 4:
				for (Student s : ms) {
					System.out.println(s.toString());
				}
				break;
			case 5:
				for (Student s : ms1) {
					System.out.println(s.toString());
				}
				break;
			case 6:
				for(int i =0; i< ms1.length;i++) {
					if(ms1[i].getMark()>=7) {
						ms1[i].setName(ms1[i].getName().toUpperCase());
					}
				}
				try {
					File file = new File("data.txt");
					if (!file.exists()) {
						System.out.println("File is not existing");
					}
					PrintWriter pw = new PrintWriter(file);
					for (int i = 0; i < ms1.length; i++) {
						for (int j = 0; j < 2; j++) {
							switch (j) {
							case 0:
								pw.println(ms1[i].getName());
								break;
							case 1:
								pw.println(ms1[i].getMark());
								break;

							}
						}
					}
					pw.close();
				} catch (Exception e) {

				}
				break;
			default:
				return;
			}
		}
	}
}

class Creator {
	private final static String[] names = { "Valera", "Ivan", "Max", "Sasha", "Piter", "Boris", "Ignat" };

	public static Student createOne() {
		return new Student(names[rand(0, 6)], rand(1, 10));
	}

	public static Student[] createLot(int n) {
		Student ms[] = new Student[n];
		for (int i = 0; i < n; i++) {
			ms[i] = createOne();
		}
		return ms;
	}

	public final static int rand(int from, int to) {
		return from + (int) (Math.random() * (to + 1 - from));
	}
}

public class Student {
	private String name;
	private int mark;

	public Student(String name, int mark) {
		this.name = name;
		this.mark = mark;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getMark() {
		return mark;
	}

	public void setMark(int mark) {
		this.mark = mark;
	}

	@Override
	public int hashCode() {
		return Objects.hash(mark, name);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj) {
			return true;
		}
		if (obj == null) {
			return false;
		}
		if (getClass() != obj.getClass()) {
			return false;
		}
		Student other = (Student) obj;
		return mark == other.mark && Objects.equals(name, other.name);
	}

	@Override
	public String toString() {
		return "Student [name=" + name + ", mark=" + mark + "]\n";
	}

}

class Input {

	private static Scanner in = new Scanner(System.in);

	public final static int readInt(String str) {
		System.out.print(str);
		boolean flag = false;
		while (!flag) {
			if (!in.hasNextInt()) {
				System.out.println("Try again: ");
				in.nextLine();
			} else {
				flag = true;
			}
		}
		return in.nextInt();
	}
}
