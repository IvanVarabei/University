package localization;

import java.util.Locale;
import java.util.ResourceBundle;

public class Gotr {

	public static void main(String ...dfg) {
		ResourceBundle bundleDefault = ResourceBundle.getBundle("resources");
		ResourceBundle bundle1 = ResourceBundle.getBundle("resources", new Locale("en","US"));
		System.out.println(bundleDefault.getString("someValue"));
	}

}
