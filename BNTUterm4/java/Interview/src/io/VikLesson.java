package io;

import java.io.IOException;
import java.io.Serializable;

public class VikLesson {

	public static void main(String ...sgd) {
		Student s = new Student("Alex",18,10);
		try {
		StudentSerializator.write("student.bs", s);
		}
		 catch (IOException e) {
				e.printStackTrace();
			}
		//s= StudentSerializator.read("student.bs");
		System.out.println(s.toString());
	}

}
class Human{
	String name;
	int age;
	public Human() {
		System.out.println("def H it is necessary!");
	}
	public Human(String name, int age) {
		this.name = name;
		this.age = age;
		System.out.println("par H");
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	@Override
	public String toString() {
		return "Human [name=" + name + ", age=" + age + " ";
	}
	
}
class Document{
	
}
class Student extends Human implements Serializable {

	int mark;
	Document d;
	public Student() {
		System.out.println("def S");
		d= new Document();
	}

	
	public Student(String name, int age,int mark) {
		super(name,age);
		this.mark = mark;
		d= new Document();
		System.out.println("Par s");
	}

	public int getMark() {
		return mark;
	}
	public void setMark(int mark) {
		this.mark = mark;
	}
	@Override
	public String toString() {
		return super.toString() + " mark=" + mark + "]";
	}
	
}