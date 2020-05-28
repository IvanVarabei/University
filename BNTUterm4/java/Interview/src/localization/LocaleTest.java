package localization;

import java.util.*;
import java.text.*;

public class LocaleTest {

	public static void main(String ...fdsg) {
		Locale locale = new Locale("en", "US");
		Locale locale1 = Locale.getDefault();
		Locale locale3 = Locale.CANADA;
		Locale[] locales = Locale.getAvailableLocales();
		for(Locale l : locales) {
			System.out.println(NumberFormat.getCurrencyInstance(l).format(1));
			System.out.println(DateFormat.getDateInstance(DateFormat.FULL, l).format(new Date()));
		}
		
	}

}
