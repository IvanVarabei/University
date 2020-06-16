package patterns.structural.proxy;

class A<t,T>{
	T fun(T T) {
		return T;
	}
}


public class Client {

	public static void main(String ...s) {
		Image rm = new ProxyImage();
		rm.show();
		rm.show();
	}

}
