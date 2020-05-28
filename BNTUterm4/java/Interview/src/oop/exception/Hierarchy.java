package oop.exception;

import java.io.FileNotFoundException;
import java.io.IOException;

public class Hierarchy {

	int Hierarchy =4;
	
	void Hierarchy() {
		
	}
	
	static void me(Integer ...ds) {
		
	}
	
	static void me(int ...fde) {
		
	}
	
	public static void main(String... fd) {


	}

}

class A{
	void m() throws IOException {
		int data [] = /*new int[]*/ {1,2};
		//data = {1,2};
	}
}
class B extends A{
	void m() throws FileNotFoundException{//compile error
		
	}
}

