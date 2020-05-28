package io;

import java.io.*;

public class ByteArrayIOStream {
	static void read(byte[] array1) {
		ByteArrayInputStream byteStream1 = new ByteArrayInputStream(array1, 0, 5);
		int b;
		while ((b = byteStream1.read()) != -1) {
			System.out.println(b);
		}
	}

	static void write(String text) {
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		byte[] buffer = text.getBytes();
		try {
			baos.write(buffer);
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
		}
		System.out.println(baos.toString());
	}
	
	static void writeTo(String text) {
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		byte[] buffer = text.getBytes();
		try{
		    baos.write(buffer);
		}
		catch(Exception ex){
		    System.out.println(ex.getMessage());
		}
		
		try(FileOutputStream fos = new FileOutputStream("hello.txt")){    
		    baos.writeTo(fos);
		}
		catch(IOException e){            
		    System.out.println(e.getMessage());
		}
	}

	public static void main(String... hf) {
		//read(new byte[] { 1, 3, 5, 7, 'i' });
		//write("Hello Wolrd!");
		writeTo("Hello Wolrd!");
	}

}
