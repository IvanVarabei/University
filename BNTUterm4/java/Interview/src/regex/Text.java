package regex;

import java.util.regex.*;

public class Text {
	/*
	 * . any symbol
	 * [] any of those([a-c] [Ii]t. [0-9] [0-9].[0-9] [0-9]\\.[0-9])
	 * $
	 * ^ start ^F
	 * [^k] not k
	 * \\d any number
	 * \\D not a number
	 * \\s space
	 * \\S not a space
	 * \\w letter or number
	 *\\\\W not a letter, not a number
	 *\\b\\w{8}\\b edge of the word
	 *\\B not age of the word
	 *e{1,3} contains e from one to three times
	 * * from 0 to infinity
	 * + from 1 to infinity
	 * ? 0 or 1
	 * \\d{4}(\\s|-|\\.)\\d{4}(\\s|-|\\.)\\d{4}(\\s|-|\\.)\\d{4} card number
	 * ^\\S+@\\S+\\.\\S email check 
	 * "Егор Алла Александр"
	 * "А.+а" // жадный режим (Алла Алекса)
		"А.++а" // сверхжадный режим
		"А.+?а" // ленивый режим (Алла, Алекса)
		
	 */
	static void example() {
		System.out.println("frostbite \r comprehend");
		String text = "frostbite \r comprehend";
		String re ="^..";
		Pattern pattern = Pattern.compile(re);
		Matcher matcher = pattern.matcher(text);
		while(matcher.find()) {
			System.out.println(matcher.start() +" " + matcher.group());
		}
	}
	
	
	public static void main(String... fdgsgf) {
		example();
		//matcherTest();
		//System.out.println(Pattern.matches(" hello ", "hello"));
		//System.out.println(new String("375297324595").matches("(\\+)\\d{12}"));
		//mySplit("Britain,,,is,past the peak of.its coronavirus");

	}

	static void matcherTest() {
		String text = "Alumnus frostbite2 comprehend\n frostbite frostbitebad comprehend";
		Pattern pattern = Pattern.compile("frostbite(\\w*)");
		Matcher matcher = pattern.matcher(text);
		
		while(matcher.find()) {
			System.out.println("group()-" + matcher.group());
		}
		System.out.println("matches()-" + matcher.matches());
		System.out.println("replaced\n" + matcher.replaceAll("обмор"));
	}
	static void mySplit(String text) {// "\\s*(\\s|,|!|\\.)\\s*"
		String[] words = text.split("\\s*(\\s|,|!|\\.)\\s*");
		for (String s : words) {
			System.out.println(s);
		}
	}
}
