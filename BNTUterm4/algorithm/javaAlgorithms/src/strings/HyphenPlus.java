package strings;

public class HyphenPlus {

	public static void main(String ...sdf) {
		String str = "2e 71";
		System.out.println("Init string : " + str);
		System.out.println(proceed(str));
	}
	
	public static String proceed(String s) {
		char[] res=s.toCharArray();
		int buf;
		for(int i=0; i< res.length; i++) {
			if(res[i] - 48<10 && res[i] - 48>0) {
				buf = res[i] - 48;
				if(buf%2==0) {
					res = insert(res,i, '+', buf);
				}
				else {
					res = insert(res,i,'-', buf);
				}
				i+=buf-1;
			}
		}
		
		return new String(res);
	}
	
	static char[] insert(char[] ms, int i, char e, int n) {
		char[] res=new char[ms.length + n-1];
		System.arraycopy(ms, 0, res, 0, i);
		for(int j = i; j<i +n; j++) {
			res[j] = e;
		}
		System.arraycopy(ms, i+1, res, i+n,ms.length- i -1);
		return res;
	}

}
