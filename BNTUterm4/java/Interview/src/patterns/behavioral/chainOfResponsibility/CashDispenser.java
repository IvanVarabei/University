package patterns.behavioral.chainOfResponsibility;

public class CashDispenser {
	CashDispenser next;
	int denominator;
	public CashDispenser(int denominator) {
		this.denominator = denominator;
	}

	public void setNext(CashDispenser next) {
		if(this.next == null)
		this.next = next;
		else
			this.next.setNext(next);
	}
	
	void dispense(int amount) {
		if(amount>=denominator) {
			int num = amount/denominator;
			int remain = amount%denominator;
			System.out.println(num +"*" + denominator + "$");
			if(remain!=0) {
			next.dispense(remain);
			}
		}
		else {
			next.dispense(amount);
		}
	}
	
	public static void main(String ...dfs) {
		CashDispenser cd = new CashDispenser(100);
		 cd.setNext( new CashDispenser(50));
		 cd.setNext( new CashDispenser(20));
		 cd.setNext( new CashDispenser(10));
		 cd.setNext( new CashDispenser(2));
		 cd.setNext( new CashDispenser(1));
		 cd.dispense(347);
	}

}
