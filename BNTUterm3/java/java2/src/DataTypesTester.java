
public class DataTypesTester {
public static void testInt() {
		int x3 = 5_______2;//ОК. (Десятичный литерал.)
		int a = 5, b = 2, c;
		System.out.println("\n***** Arithmetical Operators *****");
		// addition
		c = a + b;
		System.out.printf("%d + %d = %d\n", a, b, c);
		//subtraction
		c=a-b;
		System.out.printf("%d-%d=%d\n",a,b,c);
		//multiplication
		c=a*b;
		System.out.printf("%d*%d=%d\n",a,b,c);
		//division
		c=a/b;
		System.out.printf("%d/%d=%d\n",a,b,c);
		//modulus(modulo=remainder of division
		c=a%b;
		System.out.printf("%d %% %d=%d\n",a,b,c);
		//unary minus
		c=-a;
		System.out.printf("-%d=%d\n",a,c);
		//unary plus
		c=+a;
		System.out.printf("+%d=%d\n",a,c);
		//prefix incriment
		System.out.printf("++%d=%d\n",a,++a);
		//postfix increment
		a=5;
		System.out.printf("%d++=%d\n",a,a++);
		//prefix decremen
		a=5;
		System.out.printf("--%d=%d\n",a,--a);
		//postfix decrement
		a=5;
		System.out.printf("%d--=%d\n",a,a--);
		a=5;
		b=2;
		System.out.println("\n***** Bitwise Operators *****");
		c=a&b; //bitwise and(bitwise multiplication)
		System.out.printf("%d & %d = %d\n",a,b,c);
		System.out.println("in binary form:");
		System.out.printf("%s & %s = %s\n", Integer.toBinaryString(a),
				Integer.toBinaryString(b), Integer.toBinaryString(c));
		c=a|b; //bitwise or(bitwise addition)
		System.out.printf("%d | %d = %d\n",a,b,c);
		System.out.println("in binary form:");
		System.out.printf("%s | %s = %s\n", Integer.toBinaryString(a),
				Integer.toBinaryString(b), Integer.toBinaryString(c));
		c=a^b; //bitwise xor
		System.out.printf("%d ^ %d = %d\n",a,b,c);
		System.out.println("in binary form:");
		System.out.printf("%s ^ %s = %s\n", Integer.toBinaryString(a),
				Integer.toBinaryString(b), Integer.toBinaryString(c));
		c = ~a; // bitwise unary compliment
		System.out.printf("~%d = %d\n", a, c);
		System.out.println("in binary form:");
		System.out.printf("~%s = %s\n", Integer.toBinaryString(a),
				Integer.toBinaryString(c));
		a=76;b=2;
		c=a<<1;
		System.out.printf("%d << 1 =%d\n",a,c);
		System.out.printf("in binary form:");
		System.out.printf("%s << 1 =%s\n",Integer.toBinaryString(a),
				Integer.toBinaryString(c));
		c = a >> 1; // right shift
		System.out.printf("%d >> 1 = %d\n", a, c);
		System.out.println("in binary form:");
		System.out.printf("%s >> 1 = %s\n", Integer.toBinaryString(a),
		Integer.toBinaryString(c));
		
		a = -5;
		c = a >> 1; // right shift
		System.out.printf("%d >> 1 = %d\n", a, c);
		System.out.println("in binary form:");
		System.out.printf("%s >> 1 = %s\n", Integer.toBinaryString(a),
		Integer.toBinaryString(c));
		/*11111111111111111111111111111011
		11111111111111111111111111111101
		00000000000000000000000000001000
		01111111111111111111111111110111
		10000000000000000000000000000000*/
		a = 5;
		c = a >>> 1; // zero fill right shift
		System.out.printf("%d >>> 1 = %d\n", a, c);
		System.out.println("in binary form:");
		System.out.printf("%s >>> 1 = %s\n", Integer.toBinaryString(a),
		Integer.toBinaryString(c));
		
		a = -5;
		c = a >>> 1; // zero fill right shift
		System.out.printf("%d >>> 1 = %d\n", a, c);
		System.out.println("in binary form:");
		System.out.printf("%s >>> 1 = %s\n", Integer.toBinaryString(a),
		Integer.toBinaryString(c));
		
		System.out.println("\n***** Assignment Operators *****");
		a=7;
		c = 83;
		System.out.printf("%d += %d --> c = %d\n", c, a, c += a);
		System.out.printf("%d -= %d --> c = %d\n", c, a, c -= a);
		System.out.printf("%d *= %d --> c = %d\n", c, a, c *= a);
		System.out.printf("%d /= %d --> c = %d\n", c, a, c /= a);
		System.out.printf("%d %%= %d --> c = %d\n", c, a, c %= a);
		// c %= 0; --> Arithmetical Exception
		// c /= 0; --> Arithmetical Exception
		a=7;
		c = 83;
		System.out.printf("%d |= %d --> c = %d\n", c, a, c |= a);
		System.out.printf("%d &= %d --> c = %d\n", c, a, c &= a);
		System.out.printf("%d ^= %d --> c = %d\n", c, a, c ^= a);
		System.out.printf("%d >>= 1 --> c = %d\n", c, c >>= 1);
		System.out.printf("%d <<= 1 --> c = %d\n", c, c <<= 1);
		System.out.printf("%d >>>= 1 --> c = %d\n", c, c >>>= 1);
		
		System.out.println("\n***** Relational Operators *****");
		// greater than
		System.out.printf("%d > %d --> %b\n", a, b, a > b);
		// greater than or equal to
		System.out.printf("%d >= %d --> %b\n", a, b, a >= b);
		// less than
		System.out.printf("%d < %d --> %b\n", a, b, a < b);
		// less than or equal to
		System.out.printf("%d <= %d --> %b\n", a, b, a <= b);
		// equal to
		System.out.printf("%d == %d --> %b\n", a, b, a == b);
		// not equal to
		System.out.printf("%d != %d --> %b\n", a, b, a != b);
		
		System.out.println("\n***** Logical Operations *****");
		// logical AND
		System.out.printf("(%d > %d) && (%d > 0) --> %b\n", a, b, a,
		(a > b) && (a > 0));
		// bitwise logical AND
		System.out.printf("(%d > %d) & (%d > 0) --> %b\n", a, b, a,
		(a > b) & (a > 0));
		// logical OR
		System.out.printf("(%d >= %d) || (%d != 0) --> %b\n", a, b, b,
		(a >= b) || (b != 0));
		// bitwise logical OR
		System.out.printf("(%d >= %d) | (%d != 0) --> %b\n", a, b, b,
		(a >= b) | (b != 0));
		// logical XOR
		System.out.printf("(%d >= %d) | (%d != 0) --> %b\n", a, b, b,
		(a >= b) ^ (b != 0));
		// logical NOT
		System.out.printf("!(%d >= %d) --> %b\n", a, b, !(a >= b));
		
		System.out.println("\n***** Misc Operators *****");
		System.out.println("\nCondition Operator:");
		System.out.printf("%d > %d ? %d : %d --> %d\n", a, b, a, b,
				(a > b ? a : b));
		System.out.println("\nType Cast Operator:");
		byte bt = 1;
		short sh = -32000;
		char ch = '\u00d5';
		long l = 100000000000000000L;
		float f = 2.9f;
		double d = 123456789.625;
		boolean bool = true;
		c = bt;
		System.out.printf("int = byte: c = %d --> c = %d\n", bt, c);
		c = sh;
		System.out.printf("int = short: c = %d --> c = %d\n", sh, c);
		c = ch;
		System.out.printf("int = char: c = '%c' --> c = %d\n", ch, c);
		c = (int) l;
		System.out.printf("int = long: c = (int)%d --> c = %d\n", l, c);
		c = (int) f;
		System.out.printf("int = float: c = (int)%f --> c = %d\n", f, c);
		c = (int) d;
		System.out.printf("int = double: c = (int)%f --> c = %d\n", d, c);
		// c = (int)bool;
		System.out.printf("int = boolean: c = (int)%b --> Compile Error\n",
		bool);
		d=f+bt+l+c+sh+ch;
	}

public static void testBoolean() {
	boolean a = true, b = false, c;
	System.out.println("\n***** Arithmetical Operators *****");
	// c = a + b; // addition
	// c = a - b; // subtraction
	// c = a * b; // multiplication
	// c = a / b; // division
	// c = a % b; // modulus
	// c = -a; // unary minus
	// c = +a; // unary plus
	// c = ++a; // prefix increment
	// c = a++; // postfix increment
	// c = --a; // prefix decrement
	// c = a--; // postfix decrement
	System.out.println("\n***** Bitwise Operators *****");
	c = a & b; // bitwise AND
	System.out.printf("%b & %b = %b\n", a, b, c);	
	c = a | b; // bitwise OR
	System.out.printf("%b | %b = %b\n", a, b, c);
	c = a ^ b; // bitwise XOR
	System.out.printf("%b ^ %b = %b\n", a, b, c);
	System.out.println("\n***** Assignment Operators *****");
	System.out.printf("%b |= %b --> c = %b\n", c, a, c |= a);
	System.out.printf("%b &= %b --> c = %b\n", c, a, c &= a);
	System.out.printf("%b ^= %b --> c = %b\n", c, a, c ^= a);
	System.out.println("\n***** Relational Operators *****");
	// equal to
	System.out.printf("%b == %b --> %b\n", a, b, a == b);
	// not equal to
	System.out.printf("%b != %b --> %b\n", a, b, a != b);
	System.out.println("\n***** Logical Operations *****");
	c = a && b; // logical AND
	System.out.printf("%b && %b = %b\n", a, b, c);
	c = a || b; // logical OR
	System.out.printf("%b || %b = %b\n", a, b, c);
	c = a ^ b; // logical XOR
	System.out.printf("%b ^ %b = %b\n", a, b, c);
	// logical NOT
	System.out.printf("!%b --> %b\n", a, !a);
	System.out.println("\n***** Misc Operators *****");
	System.out.println("\nCondition Operator:");
	System.out.printf(" %b ? %b : %b --> %b\n", c, a, b, (c ? a : b));
	System.out.println("\nType Cast Operator:");
	}

public static void testByte() {
	//byte _r=128; error if -128<=_r<=127
	byte a =63,b=3,c=2;
	System.out.println("\n***** Arithmetical Operators *****");
	//!!!We can't use subsequent arefmatical opperatons whith byte type:
	// c = a + b; // addition
		// c = a - b; // subtraction
		// c = a * b; // multiplication
		// c = a / b; // division
		// c = a % b; // modulus
		// c = -a; // unary minus
		// c = +a; // unary plus
	System.out.println("\n***** Bitwise Operators *****");
	/*This operations are not alowed for type byte
	 * c=a<<b;
	c=a>>>b;
	c = a & b; // bitwise AND
	c = a | b; // bitwise OR
	c = a ^ b; // bitwise XOR
	c = ~a; // bitwise unary compliment*/
	System.out.println("\n***** Assignment Operators *****");
	System.out.printf("\n%d*=%d--> c=%d",c,a,c*=a);
	a=127;
	System.out.printf("\n%d/=%d--> c=%d",c,a,c/=a);
	System.out.printf("\n%d+=%d-->%d",c,a,c+=a);
	a=7;
	System.out.printf("\n%d-=%d--> %d",c,a,c-=a);
	a=7;c = 83;
	System.out.printf("\n%d |= %d --> c = %d\n", c, a, c |= a);
	System.out.printf("%d &= %d --> c = %d\n", c, a, c &= a);
	System.out.printf("%d ^= %d --> c = %d\n", c, a, c ^= a);
	c=9;
	System.out.printf("%d >>= 1 --> c = %d\n", c, c >>= 1);
	System.out.printf("%d <<= 1 --> c = %d\n", c, c <<= 1);
	System.out.printf("%d >>>= 1 --> c = %d\n", c, c >>>= 1);
	System.out.println("\n***** Relational Operators *****");
	// greater than
	System.out.printf("%d > %d --> %b\n", a, b, a > b);
	// greater than or equal to
	System.out.printf("%d >= %d --> %b\n", a, b, a >= b);
	// less than
	System.out.printf("%d < %d --> %b\n", a, b, a < b);
	// less than or equal to
	System.out.printf("%d <= %d --> %b\n", a, b, a <= b);
	// equal to
	System.out.printf("%d == %d --> %b\n", a, b, a == b);
	// not equal to
	System.out.printf("%d != %d --> %b\n", a, b, a != b);
	System.out.println("\n***** Logical Operations *****");
	// logical AND
	System.out.printf("(%d > %d) && (%d > 0) --> %b\n", a, b, a,
	(a > b) && (a > 0));
	// bitwise logical AND
	System.out.printf("(%d > %d) & (%d > 0) --> %b\n", a, b, a,
	(a > b) & (a > 0));
	// logical OR
	System.out.printf("(%d >= %d) || (%d != 0) --> %b\n", a, b, b,
	(a >= b) || (b != 0));
	// bitwise logical OR
	System.out.printf("(%d >= %d) | (%d != 0) --> %b\n", a, b, b,
	(a >= b) | (b != 0));
	// logical XOR
	System.out.printf("(%d >= %d) | (%d != 0) --> %b\n", a, b, b,
	(a >= b) ^ (b != 0));
	// logical NOT
	System.out.printf("!(%d >= %d) --> %b\n", a, b, !(a >= b));
	
	System.out.println("\n***** Misc Operators *****");
	System.out.println("\nCondition Operator:");
	System.out.printf("%d > %d ? %d : %d --> %d\n", a, b, a, b,
			(a > b ? a : b));
	System.out.println("\nType Cast Operator:");
	int bt = 1;
	short sh = -32000;
	char ch = '\u00d5';
	long l = 100000000000000000L;
	float f = 2.9f;
	double d = 123456789.625;
	boolean bool = true;
	
	c = (byte)bt;
	System.out.printf("byte = int: c = (byte)%d --> c = %d\n", bt, c);
	c = (byte)sh;
	System.out.printf("byte = short: c =(byte) %d --> c = %d\n", sh, c);
	c = (byte)ch;
	System.out.printf("byte= char: c =(byte) '%c' --> c = %d\n", ch, c);
	c = (byte) l;
	System.out.printf("byte= long: c = (byte)%d --> c = %d\n", l, c);
	c = (byte)f;
	System.out.printf("byte= float: c = (byte)%f --> c = %d\n", f, c);
	c = (byte) d;
	System.out.printf("byte= double: c = (byte)%f --> c = %d\n", d, c);
	// c = (byte)bool;
	System.out.printf("byte= boolean: c = (byte)%b --> Compile Error\n",

	bool);
}

public static void testDoable() {
	double aa = 2.0 - 1.1,
				f = 0.0,dd=123.123456789123456789,dd19=1.999999999999999,
				ddd=1234567891234567899.22323,
				d21=0.12345678_9123456789123456d,dc;
	for (int i=1; i <= 10; i++) {
		f += 0.1;
	}
	/*double x = 1.0F;
	int numDoubles = 0;
	while (x <= 2.0) {
	    numDoubles++;
	    System.out.println(x);
	    x = Math.nextUp(x);
	}
	System.out.println(numDoubles);*/
	System.out.println("Pretisionity of double is 17 signes after comma : "
	+d21);
	System.out.println(dd);//!!!println show better accuracy than printf!!!
	System.out.printf("%f\n%f\n",dd,ddd);
	System.out.println(dd19);
	System.out.println("2.0-1.2 = "+aa);
	System.out.println(f);
	System.out.printf("%f\n",Double.MAX_VALUE);
	System.out.println(Double.parseDouble("1.7976931348623157E308")); // (...7E308) = 1.7976931348623157E308 max value 
	System.out.println(Double.parseDouble("1.7976931348623158E308")); // (...8E308) = 1.7976931348623157E308 same???
	System.out.println(Double.parseDouble("1.7976931348623159E308")); // (...9E308) = Infinity
	//Wrapper
	Double obj=new Double(32.1); 
	Double xxx=9.432;
	double yyy=xxx;
	System.out.println(obj.byteValue());
	Object yt = new Object();
	//yt.
	System.out.println("\nType Cast Operator:");
	int in=435243;
	byte bt = 1;
	short sh = -32000;
	char ch = '\u00d5';
	long l = 100000000000000000L;
	float fl = 2.9f;
	dc = bt;
	System.out.printf("double = byte: c = %d --> c = %f\n", bt, dc);
	dc = sh;
	System.out.printf("double = short: c = %d --> c = %f\n", sh, dc);
	dc = ch;
	System.out.printf("double = char: c = '%c' --> c = %f\n", ch, dc);
	dc = l;
	System.out.printf("double = long: c = %d --> c = %f\n", l, dc);
	dc =  fl;
	System.out.printf("double = float: c = %f --> c = %f\n", fl, dc);
	dc =  in;
	System.out.printf("double= int: c = %d --> c = %f\n", in, dc);	
	
	System.out.println("\n***** Arithmetical Operators *****");
	double a = 5.9, b = 2.87, c;
	// addition
	c = a + b;
	System.out.printf("%f + %f = %f\n", a, b, c);
	//subtraction
	c=a-b;
	System.out.printf("%f-%f=%f\n",a,b,c);
	//multiplication
	c=a*b;
	System.out.printf("%f*%f=%f\n",a,b,c);
	//division
	c=a/b;
	System.out.printf("%f/%f=%f\n",a,b,c);
	//modulus(modulo=remainder of division
	c=a%b;
	System.out.printf("%f %% %f=%f\n",a,b,c);
	//unary minus
	c=-a;
	System.out.printf("-%f=%f\n",a,c);
	//unary plus
	c=+a;
	System.out.printf("+%f=%f\n",a,c);
	//prefix incriment
	System.out.printf("++%f=%f\n",a,++a);
	//postfix increment
	a=5.787;
	System.out.printf("%f++=%f\n",a,a++);
	//prefix decremen
	a=5.4565;
	System.out.printf("--%f=%f\n",a,--a);
	//postfix decrement
	System.out.printf("%f--=%f\n",a,a--);

	System.out.println("\n***** Bitwise Operators not allowed to double *****");
	System.out.println("\n***** Assignment Operators *****");
	a=7.878;
	c = 83.997;
	System.out.printf("%f += %f --> c = %f\n", c, a, c += a);
	System.out.printf("%f -= %f --> c = %f\n", c, a, c -= a);
	System.out.printf("%f *= %f --> c = %f\n", c, a, c *= a);
	System.out.printf("%f /= %f --> c = %f\n", c, a, c /= a);
	System.out.printf("%f %%= %f --> c = %f\n", c, a, c %= a);
	System.out.println("\n***** Relational Operators *****");
	a=7.123456789123451111119;
	b=7.123456789123451111118;
	// greater than
	System.out.printf("%f > %f --> %b\n", a, b, a > b);
	// greater than or equal to
	System.out.printf("%f >= %f --> %b\n", a, b, a >= b);
	// less than
	System.out.printf("%f < %f--> %b\n", a, b, a < b);
	// less than or equal to
	System.out.printf("%f <= %f --> %b\n", a, b, a <= b);
	// equal to
	System.out.printf("%f == %f --> %b\n", a, b, a == b);
	// not equal to
	System.out.printf("%f != %f --> %b\n", a, b, a != b);

}

public static void testFloat() {


	float f1=10,f2=3,f3=1.999997999999999f,f4=1.9999997f;
	float f22=123456789123456789F,
			accurancyTest=0.123456789123456789f;
	System.out.println("Accurancy println : " +accurancyTest);
	System.out.printf("Accurancy printf : %f" , accurancyTest);
	System.out.printf("10/3=%f\n%f\n%f\n%f\n",f1/f2,f3,f4,f22);
	System.out.printf("Max_value = %f\n",Float.MAX_VALUE);
	/*float x = 1.0F;
	int numFloats = 0;
	while (x <= 2.0) {
	    numFloats++;
	    System.out.println(x);
	    x = Math.nextUp(x);
	}
	System.out.println(numFloats);*/
	System.out.println("\nType Cast Operator:");
	float dc;
	int in=435243;
	byte bt = 1;
	short sh = -32000;
	char ch = '\u00d5';
	long l = 100000000000000000L;
	double fl = 2.9d;
	dc = bt;
	System.out.printf("float = byte: c = %d --> c = %f\n", bt, dc);
	dc = sh;
	System.out.printf("float = short: c = %d --> c = %f\n", sh, dc);
	dc = ch;
	System.out.printf("float = char: c = '%c' --> c = %f\n", ch, dc);
	dc = l;
	System.out.printf("float = long: c = %d --> c = %f\n", l, dc);
	dc =  (float)fl;
	System.out.printf("float =(float) doyble : c = %f --> c = %f\n", fl, dc);
	dc =  in;
	System.out.printf("float= int: c = %d --> c = %f\n", in, dc);	
	
	System.out.println("\n***** Arithmetical Operators *****");
	float a = 5.9f, b = 2.87f, c;
	// addition
	c = a + b;
	System.out.printf("%f + %f = %f\n", a, b, c);
	//subtraction
	c=a-b;
	System.out.printf("%f-%f=%f\n",a,b,c);
	//multiplication
	c=a*b;
	System.out.printf("%f*%f=%f\n",a,b,c);
	//division
	c=a/b;
	System.out.printf("%f/%f=%f\n",a,b,c);
	//modulus(modulo=remainder of division
	c=a%b;
	System.out.printf("%f %% %f=%f\n",a,b,c);
	//unary minus
	c=-a;
	System.out.printf("-%f=%f\n",a,c);
	//unary plus
	c=+a;
	System.out.printf("+%f=%f\n",a,c);
	//prefix incriment
	System.out.printf("++%f=%f\n",a,++a);
	//postfix increment
	a=5.787f;
	System.out.printf("%f++=%f\n",a,a++);
	//prefix decremen
	a=5.4565f;
	System.out.printf("--%f=%f\n",a,--a);
	//postfix decrement
	System.out.printf("%f--=%f\n",a,a--);

	System.out.println("\n***** Bitwise Operators not allowed to double *****");
	System.out.println("\n***** Assignment Operators *****");
	a=7.878f;
	c = 83.997f;
	System.out.printf("%f += %f --> c = %f\n", c, a, c += a);
	System.out.printf("%f -= %f --> c = %f\n", c, a, c -= a);
	System.out.printf("%f *= %f --> c = %f\n", c, a, c *= a);
	System.out.printf("%f /= %f --> c = %f\n", c, a, c /= a);
	System.out.printf("%f %%= %f --> c = %f\n", c, a, c %= a);
	System.out.println("\n***** Relational Operators *****");
	a=7.123458789123451111119f;
	b=7.123456789123451111118f;
	// greater than
	System.out.printf("%f > %f --> %b\n", a, b, a > b);
	// greater than or equal to
	System.out.printf("%f >= %f --> %b\n", a, b, a >= b);
	// less than
	System.out.printf("%f < %f--> %b\n", a, b, a < b);
	// less than or equal to
	System.out.printf("%f <= %f --> %b\n", a, b, a <= b);
	// equal to
	System.out.printf("%f == %f --> %b\n", a, b, a == b);
	// not equal to
	System.out.printf("%f != %f --> %b\n", a, b, a != b);

}

public static void testShort() {
	
	short _=7, $=9;

	Object obj=new Short((short)2); //Class Object is parent of all classes
	if (obj instanceof Short)
		System.out.println("obj is istance of class Sort");
	System.out.println(obj instanceof Object);
	System.out.println();
	short a = 5, b = 2, c;
	System.out.println("\n***** Arithmetical Operators *****");
	System.out.println("Allowed only dicriment & increment");
	//prefix incriment
	System.out.printf("++%d=%d\n",a,++a);
	//postfix increment
	a=5;
	System.out.printf("%d++=%d\n",a,a++);
	//prefix decremen
	a=5;
	System.out.printf("--%d=%d\n",a,--a);
	//postfix decrement
	a=5;
	System.out.printf("%d--=%d\n",a,a--);
	a=5;
	b=2;
	System.out.println("\n***** Bitwise Operators are not allowed for short *****");

	
	System.out.println("\n***** Assignment Operators *****");
	a=7;
	c = 83;
	System.out.printf("%d += %d --> c = %d\n", c, a, c += a);
	System.out.printf("%d -= %d --> c = %d\n", c, a, c -= a);
	System.out.printf("%d *= %d --> c = %d\n", c, a, c *= a);
	System.out.printf("%d /= %d --> c = %d\n", c, a, c /= a);
	System.out.printf("%d %%= %d --> c = %d\n", c, a, c %= a);
	// c %= 0; --> Arithmetical Exception
	// c /= 0; --> Arithmetical Exception
	a=7;
	c = 83;
	System.out.printf("%d |= %d --> c = %d\n", c, a, c |= a);
	System.out.printf("%d &= %d --> c = %d\n", c, a, c &= a);
	System.out.printf("%d ^= %d --> c = %d\n", c, a, c ^= a);
	System.out.printf("%d >>= 1 --> c = %d\n", c, c >>= 1);
	System.out.printf("%d <<= 1 --> c = %d\n", c, c <<= 1);
	System.out.printf("%d >>>= 1 --> c = %d\n", c, c >>>= 1);
	
	System.out.println("\n***** Relational Operators *****");
	// greater than
	System.out.printf("%d > %d --> %b\n", a, b, a > b);
	// greater than or equal to
	System.out.printf("%d >= %d --> %b\n", a, b, a >= b);
	// less than
	System.out.printf("%d < %d --> %b\n", a, b, a < b);
	// less than or equal to
	System.out.printf("%d <= %d --> %b\n", a, b, a <= b);
	// equal to
	System.out.printf("%d == %d --> %b\n", a, b, a == b);
	// not equal to
	System.out.printf("%d != %d --> %b\n", a, b, a != b);
	
	System.out.println("\n***** Logical Operations *****");
	// logical AND
	System.out.printf("(%d > %d) && (%d > 0) --> %b\n", a, b, a,
	(a > b) && (a > 0));
	// bitwise logical AND
	System.out.printf("(%d > %d) & (%d > 0) --> %b\n", a, b, a,
	(a > b) & (a > 0));
	// logical OR
	System.out.printf("(%d >= %d) || (%d != 0) --> %b\n", a, b, b,
	(a >= b) || (b != 0));
	// bitwise logical OR
	System.out.printf("(%d >= %d) | (%d != 0) --> %b\n", a, b, b,
	(a >= b) | (b != 0));
	// logical XOR
	System.out.printf("(%d >= %d) | (%d != 0) --> %b\n", a, b, b,
	(a >= b) ^ (b != 0));
	// logical NOT
	System.out.printf("!(%d >= %d) --> %b\n", a, b, !(a >= b));
	
	System.out.println("\n***** Misc Operators *****");
	System.out.println("\nCondition Operator:");
	System.out.printf("%d > %d ? %d : %d --> %d\n", a, b, a, b,
			(a > b ? a : b));
	System.out.println("\nType Cast Operator:");
	byte bt = 1;
	int it = -32000;
	char ch = '\u00d5';
	long l = 100000000000000000L;
	float f = 2.9f;
	double d = 123456789.625;
	boolean bool = true;
	c = bt;
	System.out.printf("short = byte: c = %d --> c = %d\n", bt, c);
	c = (short)it;
	System.out.printf("short = int: c = (short)%d --> c = %d\n", it, c);
	c =(short) ch;
	System.out.printf("short = char: c = (short)'%c' --> c = %d\n", ch, c);
	c =(short) l;
	System.out.printf("short = long: c = (short)%d --> c = %d\n", l, c);
	c = (short) f;
	System.out.printf("short = float: c = (short)%f --> c = %d\n", f, c);
	c = (short) d;
	System.out.printf("short = double: c = (short)%f --> c = %d\n", d, c);
	// c = (int)bool;
	System.out.printf("short = boolean: c = (short)%b --> Compile Error\n",
	bool);
}

public static void testChar() {
 char ch='a',x='\u0000',$=89;
 int i=0;
 while (i <= 50) {
	    x++;
	    i++;
	    System.out.println(x);
	}
 char sign = '\u00d5',smile = '\u00ad', a='u',c='a',b=5;
 System.out.println(ch);
 System.out.println(sign);
 System.out.println(smile);
 System.out.println($);
 System.out.println("Concotination : " +$+sign);
 System.out.println("\n***** Assignment Operators *****");
	//a=1;
	//c = 83;
	System.out.printf("%c += %c --> c = %c\n", c, a, c += a);
	System.out.printf("%c -= %c --> c = %c\n", c, a, c -= a);
	System.out.printf("%c *= %c --> c = %c\n", c, a, c *= a);
	System.out.printf("%c /= %c --> c = %c\n", c, a, c /= a);
	System.out.printf("%c %%= %c --> c = %c\n", c, a, c %= a);
	// c %= 0; --> Arithmetical Exception
	// c /= 0; --> Arithmetical Exception
	a=7;
	c = 83;
	System.out.printf("%c |= %c --> c = %c\n", c, a, c |= a);
	System.out.printf("%c &= %c --> c = %c\n", c, a, c &= a);
	System.out.printf("%c ^= %c --> c = %c\n", c, a, c ^= a);
	System.out.printf("%c >>= 1 --> c = %c\n", c, c >>= 1);
	System.out.printf("%c <<= 1 --> c = %c\n", c, c <<= 1);
	System.out.printf("%c >>>= 1 --> c = %c\n", c, c >>>= 1);

	System.out.println("\n***** Bitwise Operators *****\nare not allowed");
	System.out.println("\n***** Relational Operators *****");
	a='b';
	b='i';
	// greater than
	System.out.printf("%c > %c --> %b\n", a, b, a > b);
	// greater than or equal to
	System.out.printf("%c >= %c --> %b\n", a, b, a >= b);
	// less than
	System.out.printf("%c < %c --> %b\n", a, b, a < b);
	// less than or equal to
	System.out.printf("%c <= %c --> %b\n", a, b, a <= b);
	// equal to
	System.out.printf("%c == %c --> %b\n", a, b, a == b);
	// not equal to
	System.out.printf("%c != %c --> %b\n", a, b, a != b);
	
	System.out.println("\n***** Logical Operations *****");
	// logical AND
	System.out.printf("(%c > %c) && (%c > 0) --> %b\n", a, b, a,
	(a > b) && (a > 0));
	// bitwise logical AND
	System.out.printf("(%c > %c) & (%c > 0) --> %b\n", a, b, a,
	(a > b) & (a > 0));
	// logical OR
	System.out.printf("(%c >= %c) || (%c != 0) --> %b\n", a, b, b,
	(a >= b) || (b != 0));
	// bitwise logical OR
	System.out.printf("(%c >= %c) | (%c != 0) --> %b\n", a, b, b,
	(a >= b) | (b != 0));
	// logical XOR
	System.out.printf("(%c >= %c) | (%c != 0) --> %b\n", a, b, b,
	(a >= b) ^ (b != 0));
	// logical NOT
	System.out.printf("!(%c >= %c) --> %b\n", a, b, !(a >= b));
	System.out.println("\n***** Misc Operators *****");
	System.out.println("\nCondition Operator:");
	System.out.printf("%c > %c ? %c : %c --> %c\n", a, b, a, b,
			(a > b ? a : b));
	System.out.println("\nType Cast Operator:");
	byte bt = 55;
	int it=86;
	short sh = -32000;
	long l = 100000000000000000L;
	float f = 2.9f;
	double d = 123456789.625;
	boolean bool = true;
	c = (char)bt;
	System.out.printf("char = byte: c = (char)%d --> c = %c\n", bt, c);
	c = (char)sh;
	System.out.printf("char = short: c = (char)%d --> c = %c\n", sh, c);
	c = (char)it;
	System.out.printf("char = int: c = (char)%c --> c = %c\n", ch, c);
	c = (char) l;
	System.out.printf("char = long: c = (char)%d --> c = %c\n", l, c);
	c = (char) f;
	System.out.printf("char = float: c = (char)%f --> c = %c\n", f, c);
	c = (char) d;
	System.out.printf("char = double: c = (char)%f --> c = %c\n", d, c);
	// c = (char)bool;
	System.out.printf("char = boolean: c = (char)%b --> Compile Error\n",

	bool);
	
}

public static void testLong()
{
	System.out.printf("Max_value of long = %d\n",Long.MAX_VALUE);
	long a = 5L, b = 2L, c;
	System.out.println("\n***** Arithmetical Operators *****");
	// addition
	c = a + b;
	System.out.printf("%d + %d = %d\n", a, b, c);
	//subtraction
	c=a-b;
	System.out.printf("%d-%d=%d\n",a,b,c);
	//multiplication
	c=a*b;
	System.out.printf("%d*%d=%d\n",a,b,c);
	//division
	c=a/b;
	System.out.printf("%d/%d=%d\n",a,b,c);
	//modulus(modulo=remainder of division
	c=a%b;
	System.out.printf("%d %% %d=%d\n",a,b,c);
	//unary minus
	c=-a;
	System.out.printf("-%d=%d\n",a,c);
	//unary plus
	c=+a;
	System.out.printf("+%d=%d\n",a,c);
	//prefix incriment
	System.out.printf("++%d=%d\n",a,++a);
	//postfix increment
	a=5;
	System.out.printf("%d++=%d\n",a,a++);
	//prefix decremen
	a=5;
	System.out.printf("--%d=%d\n",a,--a);
	//postfix decrement
	a=5;
	System.out.printf("%d--=%d\n",a,a--);
	a=5;
	b=2;
	System.out.println("\n***** Bitwise Operators *****");
	c=a&b; //bitwise and(bitwise multiplication)
	System.out.printf("%d & %d = %d\n",a,b,c);
	System.out.println("in binary form:");
	System.out.printf("%s & %s = %s\n", Long.toBinaryString(a),
			Long.toBinaryString(b), Long.toBinaryString(c));
	c=a|b; //bitwise or(bitwise addition)
	System.out.printf("%d | %d = %d\n",a,b,c);
	System.out.println("in binary form:");
	System.out.printf("%s | %s = %s\n", Long.toBinaryString(a),
			Long.toBinaryString(b), Long.toBinaryString(c));
	c=a^b; //bitwise xor
	System.out.printf("%d ^ %d = %d\n",a,b,c);
	System.out.println("in binary form:");
	System.out.printf("%s ^ %s = %s\n", Long.toBinaryString(a),
			Long.toBinaryString(b), Long.toBinaryString(c));
	c = ~a; // bitwise unary compliment
	System.out.printf("~%d = %d\n", a, c);
	System.out.println("in binary form:");
	System.out.printf("~%s = %s\n", Long.toBinaryString(a),
			Long.toBinaryString(c));
	a=76;b=2;
	c=a<<1;
	System.out.printf("%d << 1 =%d\n",a,c);
	System.out.printf("in binary form:");
	System.out.printf("%s << 1 =%s\n",Long.toBinaryString(a),
			Long.toBinaryString(c));
	c = a >> 1; // right shift
	System.out.printf("%d >> 1 = %d\n", a, c);
	System.out.println("in binary form:");
	System.out.printf("%s >> 1 = %s\n", Long.toBinaryString(a),
	Long.toBinaryString(c));
	
	a = -5;
	c = a >> 1; // right shift
	System.out.printf("%d >> 1 = %d\n", a, c);
	System.out.println("in binary form:");
	System.out.printf("%s >> 1 = %s\n", Long.toBinaryString(a),
	Long.toBinaryString(c));

	a = 5;
	c = a >>> 1; // zero fill right shift
	System.out.printf("%d >>> 1 = %d\n", a, c);
	System.out.println("in binary form:");
	System.out.printf("%s >>> 1 = %s\n", Long.toBinaryString(a),
	Long.toBinaryString(c));
	
	a = -5;
	c = a >>> 1; // zero fill right shift
	System.out.printf("%d >>> 1 = %d\n", a, c);
	System.out.println("in binary form:");
	System.out.printf("%s >>> 1 = %s\n",Long.toBinaryString(a),
	Long.toBinaryString(c));
	
	System.out.println("\n***** Assignment Operators *****");
	a=7;
	c = 83;
	System.out.printf("%d += %d --> c = %d\n", c, a, c += a);
	System.out.printf("%d -= %d --> c = %d\n", c, a, c -= a);
	System.out.printf("%d *= %d --> c = %d\n", c, a, c *= a);
	System.out.printf("%d /= %d --> c = %d\n", c, a, c /= a);
	System.out.printf("%d %%= %d --> c = %d\n", c, a, c %= a);
	// c %= 0; --> Arithmetical Exception
	// c /= 0; --> Arithmetical Exception
	a=7;
	c = 83;
	System.out.printf("%d |= %d --> c = %d\n", c, a, c |= a);
	System.out.printf("%d &= %d --> c = %d\n", c, a, c &= a);
	System.out.printf("%d ^= %d --> c = %d\n", c, a, c ^= a);
	System.out.printf("%d >>= 1 --> c = %d\n", c, c >>= 1);
	System.out.printf("%d <<= 1 --> c = %d\n", c, c <<= 1);
	System.out.printf("%d >>>= 1 --> c = %d\n", c, c >>>= 1);
	
	System.out.println("\n***** Relational Operators *****");
	// greater than
	System.out.printf("%d > %d --> %b\n", a, b, a > b);
	// greater than or equal to
	System.out.printf("%d >= %d --> %b\n", a, b, a >= b);
	// less than
	System.out.printf("%d < %d --> %b\n", a, b, a < b);
	// less than or equal to
	System.out.printf("%d <= %d --> %b\n", a, b, a <= b);
	// equal to
	System.out.printf("%d == %d --> %b\n", a, b, a == b);
	// not equal to
	System.out.printf("%d != %d --> %b\n", a, b, a != b);
	
	System.out.println("\n***** Logical Operations *****");
	// logical AND
	System.out.printf("(%d > %d) && (%d > 0) --> %b\n", a, b, a,
	(a > b) && (a > 0));
	// bitwise logical AND
	System.out.printf("(%d > %d) & (%d > 0) --> %b\n", a, b, a,
	(a > b) & (a > 0));
	// logical OR
	System.out.printf("(%d >= %d) || (%d != 0) --> %b\n", a, b, b,
	(a >= b) || (b != 0));
	// bitwise logical OR
	System.out.printf("(%d >= %d) | (%d != 0) --> %b\n", a, b, b,
	(a >= b) | (b != 0));
	// logical XOR
	System.out.printf("(%d >= %d) | (%d != 0) --> %b\n", a, b, b,
	(a >= b) ^ (b != 0));
	// logical NOT
	System.out.printf("!(%d >= %d) --> %b\n", a, b, !(a >= b));
	
	System.out.println("\n***** Misc Operators *****");
	System.out.println("\nCondition Operator:");
	System.out.printf("%d > %d ? %d : %d --> %d\n", a, b, a, b,
			(a > b ? a : b));
	System.out.println("\nType Cast Operator:");
	byte bt = 1;
	short sh = -32000;
	char ch = '\u00d5';
	int it = 1000000000;
	float f = 2.9f;
	double d = 123456789.625;
	boolean bool = true;
	c = bt;
	System.out.printf("long = byte: c = %d --> c = %d\n", bt, c);
	c = sh;
	System.out.printf("long = short: c = %d --> c = %d\n", sh, c);
	c = ch;
	System.out.printf("long = char: c = '%c' --> c = %d\n", ch, c);
	c =  it;
	System.out.printf("long = long: c = %d --> c = %d\n", it, c);
	c = (long) f;
	System.out.printf("long = float: c = (long)%f --> c = %d\n", f, c);
	c = (long) d;
	System.out.printf("long = double: c = (long)%f --> c = %d\n", d, c);
	// c = (int)bool;
	System.out.printf("long = boolean: c = (long)%b --> Compile Error\n",

	bool);
	}
}
