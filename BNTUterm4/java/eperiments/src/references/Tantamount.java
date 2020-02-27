package references;

public class Tantamount {

	/*public static void main(String regf[]) {
		//string pull
		//КОГДА МЫ ИСПОЛЬЗУЕМ ДВОЙНЫЕ КОВЫЧКИ, СНАЧАЛА ИЩЕТСЯ СТРОКА
		//В ПУЛЕ С ТАКИМ ЖЕ ЗНАЧЕНИЕМ, ЕСЛИ НАХОДИТЬСЯ ТО ВОЗВРАЩАЕТСЯ 
		//ССЫЛКА, ЕСЛИ НЕТ ,ТО СОЗДАЕТСЯ НОВАЯ СТРОКА В ПУЛЕ И ВОЗВРАЩАЕТСЯ ССЫЛКА 
		String str1 = "AB";
		String str2 = "A"+"B";//компилятор собирает это сразу
		//String str2 = "A".concat("B");//былобы фолс
		//СРАВНИВАЕМ АДРЕСА, УКАЗЫВАЮТ НА ОДНУ И ТУЖЕ СТРОКУ В ПУЛЕ
		System.out.println(str1==str2);//TRUE
		//когда мы используем оператор new, мы принуждаем класс String создать новый объект строки
		//а затем мы можем использовать метод intern() для того, чтобы поместить строку в пул,
		//или получить из пула ссылку на другой объектString с таким же значением.
		String str11= new String("A");
		String str22= new String("A");
		//СРАВНИВАЕМ ССЫЛКИ УКАЗЫВАЮЩИЕ НА РАЗНЫЕ ОБЪЕКТЫ
		System.out.println(str11==str22);//FALSE/
		//EQUALS ПЕРЕГРУЖЕН ДЛЯ STRING И СРАВНИВАЕТ СОДЕРЖИМОЕ
		System.out.println(str11.equals(str22));//TRUE
		//СРАВНИВАЕМ СТРОКУ ИЗ ПУЛА СО СТРОКОЙ СОЗДАННОЙ ЧЕРЕЗ NEW
		System.out.println(str11==str2);//FALSE
		str11=str11.intern();//получить из пула ссылку на другой объектString с таким же значением.
		System.out.println(str11==str2);//true
		
		
		//СОЗДАЕМ ССЫЛОЧНЫЕ ПЕРЕМЕННЫЕ КЛАССА ОБДЖЕКТ
		//ПРИСВАИВАЕМ ИМ ЗНАЧЕНИЕ ССЫЛОК НА ОБЪЕКТЫ
		//КЛАССА ОБДЖЕКТ
		Object obj1 = new Object();
		Object obj2 = new Object();
		//EQUALS ДЛЯ ОБЩЕКТ СРАВНИВАЕТ ССЫЛКИ ТАК ЖЕ КАК ==
		System.out.println(obj1.equals(obj2));//false
		
		
		
		
		
		
		//СОЗДАЕМ ССЫЛОЧНЫЕ ПЕРЕМЕННЫЕ КЛАССА ОБДЖЕКТ
		//ПРИСВАИВАЕМ ИМ ЗНАЧЕНИЕ ССЫЛОК НА ОБЪЕКТЫ
		//КЛАССА String
		Object o1 = new String();
		Object o2 = new String();
		//EQUALS ДЛЯ string перегружен И УЖЕ СРАВНИВАЕТ ЗНАЧЕНИЯ
		System.out.println(o1.equals(o2));//TRUE
		
		
		String a = "hello1";
		String b = "hello".concat("1");//не заносит в пул а создает новый объект
		System.out.println("a="+a+"    b="+b+ "  "+(a==b));//false
		
		
		
		
		
		Object c = new Object();
		Object d = new Object();
		System.out.println("c="+c.hashCode()+"  d= "+ d.hashCode()+"     "+(c.hashCode()==d.hashCode()));
		
		
		
		Character cr1 = 'A';
		Character cr2 = 'A';
		System.out.println((cr1==cr2));
		Character cr11 = new Character('A');
		Character cr22 = new Character('A');
		System.out.println((cr11==cr22));
		
		Integer int1 = 2;
		Integer int2 = 2;
		System.out.println((int1==int2));
		Integer int11 = new Integer(2);
		Integer int22 = new Integer(2);
		System.out.println((int11==int22));

	}*/

}
