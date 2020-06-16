package io;

import java.io.*;

public class ObjectIOStream {
	public static void main(String[] args) throws FileNotFoundException, ClassNotFoundException, IOException{
		versionsRead();
	}

	static void defaultProtocol()  throws FileNotFoundException, IOException, ClassNotFoundException {
		ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream("person.dat"));
		oos.writeObject(new Person("Sam", 33, 178, true));
		oos.writeObject(new Person("Liz", 18, 168, true));
		oos.close();
		ObjectInputStream ois = new ObjectInputStream(new FileInputStream("person.dat"));

		Person p1 = (Person) ois.readObject();
		Person p2 = (Person) ois.readObject();

		System.out.printf("Name: %s \nAge: %d \n", p1.getName(), p1.getAge());
		System.out.printf("Name: %s \nAge: %d \n", p2.getName(), p2.getAge());
	}
	static void changedDefaultProtocol() throws IOException, ClassNotFoundException {
		FileOutputStream fos = new FileOutputStream("example2.dat");
		ObjectOutputStream oos = new ObjectOutputStream(fos);
		Car c1 = new Car(10,"reno");
		Car c2 = new Car(20,"mers");
		oos.writeObject(c1);
		oos.writeObject(c2);
		oos.close();
		fos.close();
		
		
		FileInputStream fis = new FileInputStream("example2.dat");
		ObjectInputStream ois = new ObjectInputStream(fis);
		Car c11 = (Car) ois.readObject();
		Car c22 = (Car) ois.readObject();
		System.out.println(c11.toString());
		System.out.println(c22.toString());
	}
	static void myOwnProtocol() throws IOException, ClassNotFoundException {
		FileOutputStream fos = new FileOutputStream("myOwnProtocol.dat");
		ObjectOutputStream oos = new ObjectOutputStream(fos);
		Gown g1 = new Gown("red",5);
		Gown g2 = new Gown("blue",8);
		System.out.println(g1.toString());
		System.out.println(g2.toString());
		oos.writeObject(g1);
		oos.writeObject(g2);
		
		FileInputStream fis = new FileInputStream("myOwnProtocol.dat");
		ObjectInputStream ois = new ObjectInputStream(fis);
		Gown g11 = (Gown) ois.readObject();
		Gown g22 = (Gown) ois.readObject();

		System.out.println(g11.toString());
		System.out.println(g22.toString());
	}
	static void nuance() throws IOException, ClassNotFoundException {
		FileOutputStream fos = new FileOutputStream("nuance.dat");
		ObjectOutputStream oos = new ObjectOutputStream(fos);
		Person g1 = new Person("Ivan",5,3,true);
		System.out.println(g1.toString());
		oos.writeObject(g1);
		g1.name = "Valera";
		oos.reset();
		System.out.println(g1.toString());
		oos.writeObject(g1);
		
		FileInputStream fis = new FileInputStream("nuance.dat");
		ObjectInputStream ois = new ObjectInputStream(fis);
		Person g11 = (Person) ois.readObject();
		Person g22 = (Person) ois.readObject();

		System.out.println(g11.toString());
		System.out.println(g22.toString());
	}
	static void versionsWrite() throws IOException, ClassNotFoundException {
		FileOutputStream fos = new FileOutputStream("versions.dat");
		ObjectOutputStream oos = new ObjectOutputStream(fos);
		V g1 = new V("red");
		System.out.println(g1.toString());
		oos.writeObject(g1);
	}
	static void versionsRead() throws IOException, ClassNotFoundException {

		
		FileInputStream fis = new FileInputStream("versions.dat");
		ObjectInputStream ois = new ObjectInputStream(fis);
		V g11 = (V) ois.readObject();

		System.out.println(g11.toString());
	}
}

class V implements Serializable{
	int y;
	String color;
	V(String c){
		color = c;
	}
	public String toString() {
		return color;
	}
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
}

class Gown implements Externalizable{
	String color;
	int size;
	public Gown(){
		System.out.println("def const");
	}
	Gown(String s, int i){
		System.out.println("option const");
		color = s;
		size = i;
	}
	@Override
	public void writeExternal(ObjectOutput s) throws IOException {
		s.writeObject(color);
	}
	@Override
	public void readExternal(ObjectInput s) throws ClassNotFoundException, IOException {
		color = (String)s.readObject();
	}
	public String toString() {
		return "color:"+color + " size:"+ size;
	}
}

class Car implements Serializable, Runnable{
	int cost;
	String name;
	transient Thread t;
	Car(int i , String n){
		cost = i;
		name = n;
		t = new Thread(this);
		t.start();
	}
	private void writeObject(ObjectOutputStream s) throws IOException {
		s.defaultWriteObject();
	}
	private void readObject(ObjectInputStream s) throws ClassNotFoundException, IOException {
		s.defaultReadObject();
		activateThread();
	}
	public String toString() {
		return "name:"+name+" cost:" + cost;
	}
	void activateThread() {
		t = new Thread(this);
		t.start();
	}
	@Override
	public void run() {
		// TODO Auto-generated method stub
		
	}
}

class Person implements Serializable {
	String name;
	transient InputStream is = System.in;
	private int age;
	private double height;
	private boolean married;
	Person(String n, int a, double h, boolean m) {
		name = n;
		age = a;
		height = h;
		married = m;
	}

	String getName() {
		return name;
	}

	int getAge() {
		return age;
	}

	double getHeight() {
		return height;
	}

	boolean getMarried() {
		return married;
	}
	public String toString() {
		return name + " age:"+ age;
	}
}
