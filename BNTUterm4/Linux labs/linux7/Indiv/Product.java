import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Scanner;

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

public class Product {

	private int id = 3243;
	private String name = "Procassor";
	private String producer = "Intel";
	private int cost = 228;;
	private int amount = 200;

	public Product() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getProducer() {
		return producer;
	}

	public void setProducer(String producer) {
		this.producer = producer;
	}

	public int getCost() {
		return cost;
	}

	public void setCost(int cost) {
		this.cost = cost;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	@Override
	public String toString() {
		return "Product [id=" + id + ", name=" + name + ", producer=" + producer + ", cost=" + cost + ", amount="
				+ amount + "]";
	}

	public static void main(String[] ms) {
		String line;

		Product prMs[] = new Product[5];
		BufferedReader br = null;
		try {

			File resF = new File("data.txt");
			if (!resF.exists()) {
				resF.createNewFile();
			}
			PrintWriter pw = new PrintWriter(resF);
			br = new BufferedReader(new FileReader("data.txt"));
			while (true) {
				switch (Input.readInt("Enter :\n1 - input\n2 - read\n3 - to console")) {
				case 1:
					for (int i = 0; i < prMs.length; i++) {
						prMs[i] = new Product();
					}

					for (int i = 0; i < prMs.length; i++) {
						for (int j = 0; j < 6; j++) {
							switch (j) {
							case 0:
								pw.println("" + prMs[i].getId());
								break;
							case 1:
								pw.println(prMs[i].getName());
								break;
							case 2:
								pw.println(prMs[i].getProducer());
								break;
							case 3:
								pw.println("" + prMs[i].getCost());
								break;
							case 4:
								pw.println("" + prMs[i].getAmount());
								break;
							case 5:
								pw.println("");
								break;
							}
						}
					}
					break;
				case 2:
					int j = 0, i = 0;
					
					while ((line = br.readLine()) != null) {
						System.out.println(line);
						switch (j) {
						case 0:
							prMs[i].setId(Integer.parseInt(line));
							j++;
							break;
						case 1:
							prMs[i].setName(line);
							j++;
							break;
						case 2:
							prMs[i].setProducer(line);
							j++;
							break;
						case 3:
							prMs[i].setCost(Integer.parseInt(line));
							j++;
							break;
						case 4:
							prMs[i].setAmount(Integer.parseInt(line));
							j++;
							break;
						case 5:
							pw.println("");
							i++;
							j = 0;
							break;
						}
					}
					break;
				case 3: {
					for (int ii = 0; ii < prMs.length; ii++) {
						System.out.println(prMs[ii].toString());
					}
					break;
				}
				default:
					pw.close();
					br.close();
					return;
				}

			}

		} catch (

		IOException e) {

		} finally {
			
			
		}

	}

}
