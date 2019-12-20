package lab4.view;
import java.util.Date;

public class Output {
 public static void exhibit(String str,double arg1,double arg2) {
	 System.out.printf(str+"\n",arg1,arg2);
 }
 
 public static void exhibit(String str,int arg) {
	 System.out.printf(str+"\n",arg);
 }
 
 public static void exhibit(String str,double arg) {
	 System.out.printf(str+"\n",arg);
 }
 
 public static void exhibit(String str) {
	 System.out.printf(str);
	 }
 
 public static void exhibit(Date str) {
	 System.out.println(str);
	 }

}
