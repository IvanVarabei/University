package io;

import java.io.*;

public class BufferedIOStream {
	
	static void read(String text) {
		byte[] buffer = text.getBytes();
		ByteArrayInputStream in = new ByteArrayInputStream(buffer);
		try (BufferedInputStream bis = new BufferedInputStream(in)) {
			int c;
			while ((c = bis.read()) != -1) {
				System.out.print((char) c);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	static void write(String text, boolean isRewrite) {
		try (FileOutputStream fos = new FileOutputStream(FileIOStreamTest.file, !isRewrite);
				BufferedOutputStream bos = new BufferedOutputStream(fos)) {
			bos.write(text.getBytes());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static void main(String... gf) {
		System.out.println("nuull != "+(null==new Object()));
		read("Hello");
		write("Bye!", false);
	}

}
