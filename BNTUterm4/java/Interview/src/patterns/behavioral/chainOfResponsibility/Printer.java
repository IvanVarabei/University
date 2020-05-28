package patterns.behavioral.chainOfResponsibility;

abstract public class Printer {

	public static void main(String ...g) {
		Printer p = new ConsolePrinter();
		p.setNext(new FilePrinter());
		p.setNext(new DbPrinter());
		p.print("Hello");
	}
	Printer next;
	public Printer() {
	}
	void setNext(Printer p) {
		if(next == null)
		next = p;
		else
			next.setNext(p);
	}
	public abstract void print(String str) ;
}
class DbPrinter extends Printer{
	@Override
	public void print(String str) {
		System.out.println("DB" + str);
		if(next!=null)
			next.print(str);
	}
}
class ConsolePrinter extends Printer{
	@Override
	public void print(String str) {
		System.out.println("console "+str);
		if(next!=null)
			next.print(str);
	}
}

class FilePrinter extends Printer{
	@Override
	public void print(String str) {
		System.out.println("file "+str);
		if(next!=null)
			next.print(str);
	}
}
