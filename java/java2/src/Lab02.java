class Lab02 {
	public static void main(String args[]) {
		//DataTypesTester.testBoolean();
		//DataTypesTester.testByte();
		//DataTypesTester.testDoable();
		//DataTypesTester.testFloat();
		//DataTypesTester.testShort();
		//DataTypesTester.testChar();
		//DataTypesTester.testInt();
		//DataTypesTester.testLong();
		class Typetester {
		    void printType(byte x) {
		        System.out.println(x + " is an byte");
		    }
		    void printType(int x) {
		        System.out.println(x + " is an int");
		    }
		    void printType(float x) {
		        System.out.println(x + " is an float");
		    }
		    void printType(double x) {
		        System.out.println(x + " is an double");
		    }
		    void printType(char x) {
		        System.out.println(x + " is an char");
		    }
		}
		Typetester t = new Typetester();
		
		/*byte bt = 127;
		byte res = (byte)(bt + 5);
		System.out.println(res);
		int a=6;
		int b=7;
		int c=a+++b++;
		System.out.println("c="+c);
		*/
		//short a =0x7fff+0x1;
		/*char x='\u000c'+'\ufff0';
		System.out.println(-17%-5);
		int n=0, b=2;*/
		
		//String x = "Hello";
		/*int y=4,a=2;
		a=a+++a++;
		System.out.println("a="+a);
		System.out.println("2+2="+2+2);
		System.out.println(7%-6);
		byte bt=5,r=2;
		int it=2,cc=6;
		cc=-it;
		t.printType( x );
		System.out.println(cc);*/
	}

}
//enum