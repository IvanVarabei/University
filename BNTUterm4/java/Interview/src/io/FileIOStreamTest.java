package io;

import java.io.*;

//FileInputStream InputStreamReader
//FileOutputStream
public class FileIOStreamTest {
	static File file = new File("C:\\fourth\\java\\Interview\\src\\io\\inf.txt");

	/*static String readInputStreamReader() {
		int c;
		StringBuilder str = new StringBuilder();
		try (FileInputStream fis = new FileInputStream(file);
				InputStreamReader isr = new InputStreamReader(fis, "UTF8");) {			
			while (isr.ready()) {
				char ms[] = new char[5];
				isr.read(ms);
				str.append(new String(ms));		
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return str.toString();
	}*/
	
	static String readFileInputStream() {
		StringBuilder str = new StringBuilder();
		try (FileInputStream fis = new FileInputStream(file)) {		
			byte ms[] = new byte[fis.available()];
				fis.read(ms);
				str.append(new String(ms));		
		} catch (IOException e) {
			e.printStackTrace();
		}
		return str.toString();
	}

	static void write(String str, boolean isRewrite) {
		try (FileOutputStream fos = new FileOutputStream(file, !isRewrite)) {
			fos.write(str.getBytes());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static void main(String... gf) {
		write("12345 1234567890", true);

		System.out.println(readFileInputStream());
	}

}
