package io;

import java.io.*;

public class StudentSerializator {

	public static void write(String fileName, Student s ) throws IOException{
		try (ObjectOutputStream stream = 
				new ObjectOutputStream(
						new BufferedOutputStream(
								new FileOutputStream(fileName)))) {
			stream.writeObject(s);
		}
	}
	
	public static Student read(String fileName) {
		Student s = null;
		try (ObjectInputStream stream = 
				new ObjectInputStream(
						new BufferedInputStream(
								new FileInputStream(fileName)))) {
			s = (Student) stream.readObject();
			
		} catch (IOException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		return s;
	}

}
