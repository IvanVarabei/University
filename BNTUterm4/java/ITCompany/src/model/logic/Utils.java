package model.logic;

import java.util.Arrays;
import java.util.List;
import java.util.Random;
import java.util.Scanner;

import model.entity.Developer;
import model.entity.Employee;
import model.entity.groups.ITCompany;
import model.entity.groups.ProjectTeam;

import static model.logic.Utils.rand;
import static model.logic.Utils.search;

import java.io.IOException;

public class Utils {

	private static Scanner in = new Scanner(System.in);
	
	
	
	public static int searchProjectTeamByName(ITCompany comp,String name) {
		int res = Integer.MAX_VALUE;
		for (int i = 0; i < comp.getTeams().size(); i++) {
			if (comp.getTeams().get(i).getName().equals(name)) {
				res = i;
			}
		}
		return res;
	}

	public static Employee searchById(ITCompany comp, int elem) {
		Employee res = null;
		for (int i = 0; i < comp.getTeams().size(); i++) {
			if (search(comp.getTeams().get(i).getMember(), elem) != null) {
				res = search(comp.getTeams().get(i).getMember(), elem);
				break;
			}
		}
		return res;
	}

	static long pow(long a, long b) {
		long res = 1;
		for (long i = 1; i <= b; i++) {
			res *= a;
		}
		return res;
	}

	public final static int searchIndexByValue(int[] ms, int value) {
		int result = Integer.MAX_VALUE;
		for (int i = 0; i < ms.length; i++) {
			if (ms[i] == value) {
				result = i;
			}
		}
		return result;
	}

	public final static Employee search(Storable<Employee> ms, int elem) {
		Employee res = null;
		for (int i = 0; i < ms.size(); i++) {
			if (ms.get(i).getId() == elem) {
				res = ms.get(i);
			}
		}
		return res;
	}

	
	
	

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
	
	public final static double readD(String str) {
		System.out.print(str);
		boolean flag = false;
		while (!flag) {
			if (!in.hasNextDouble()) {
				System.out.println("Try again: ");
				in.nextLine();
			} else {
				flag = true;
			}
		}
		return in.nextDouble();
	}

	public final static double readChar(String str) throws IOException {
		System.out.printf("\n" + str);
		return (char) System.in.read();
	}

	public final static String readStr(String str) {
		System.out.print(str);
		return in.next();
	}

	

	
	public final static void sortAge(Storable<Employee> ms) {
		for (int i = 0; i < ms.size(); i++) {
			for (int j = ms.size() - 1; j > i; j--) {
				if (ms.get(j).getAge() > ms.get(j - 1).getAge()) {
					Employee c = ms.get(j);
					ms.set(j, ms.get(j - 1));
					ms.set(j - 1, c);
				}
			}
		}
	}

	public final static void sortCost(Storable<Employee> ms) {
		for (int i = 0; i < ms.size(); i++) {
			for (int j = ms.size() - 1; j > i; j--) {
				if (ms.get(j).getCost() > ms.get(j - 1).getCost()) {
					Employee c = ms.get(j);
					ms.set(j, ms.get(j - 1));
					ms.set(j - 1, c);
				}
			}
		}
	}

	public static void sortName(Storable<Employee> ms) {
		for (int i = 0; i < ms.size(); i++) {
			for (int j = ms.size() - 1; j > i; j--) {
				if (ms.get(j).getName().compareTo(ms.get(j - 1).getName()) > 0) {
					Employee c = ms.get(j);
					ms.set(j, ms.get(j - 1));
					ms.set(j - 1, c);
				}
			}
		}
	}

	
	
	
	
	public final static int rand(int from, int to) {
		Random rnd = new Random();
		return from + rnd.nextInt(to - from + 1);
	}


	public static int[] addElem(int[] devs, int elem) {
		int[] newMs = Arrays.copyOf(devs, devs.length + 1);
		newMs[newMs.length - 1] = elem;
		return newMs;
	}

	public static int[] delElem(int[] ms, int index) {
		int[] result = new int[ms.length - 1];
		System.arraycopy(ms, 0, result, 0, index);
		System.arraycopy(ms, index + 1, result, index, ms.length - index - 1);
		return result;
	}

}
