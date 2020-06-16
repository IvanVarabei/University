package lambda;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

//функциональный интерфейс
interface Expression {
	boolean isEqual(int n);
}

//класс, в котором определены методы
class ExpressionHelper {
	static boolean isEven(int n) {return n % 2 == 0;}
	static boolean isPositive(int n) {return n > 0;}
	static void print(int n) {System.out.println("-"+n);}
}

public class LambdaTest {
	public static void main(String[] args) {
		Integer[] nums = { -5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5 };
		List<Integer> l =new ArrayList<Integer>();
		l= Arrays.asList(nums);
		l.forEach(ExpressionHelper::print);
		/*System.out.println(sum(nums, ExpressionHelper::isEven));
		Expression expr = ExpressionHelper::isPositive;
		System.out.println(sum(nums, expr));*/
	}

	private static int sum(int[] numbers, Expression func) {
		int result = 0;
		for (int i : numbers) {
			if (func.isEqual(i))
				result += i;
		}
		return result;
	}
}