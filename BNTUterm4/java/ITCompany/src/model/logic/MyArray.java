package model.logic;

import java.util.Arrays;
import java.util.Iterator;

public class MyArray implements Storable{

	private Object ms[] = new Object[0];

	public MyArray() {
	}


	@Override
	public void add(Object b) {
		Object[] res = new Object[ms.length + 1];
		for (int i = 0; i < ms.length; i++) {
			res[i] = ms[i];
		}
		res[ms.length] = b;
		ms = res;
	}

	@Override
	public void addAll(Storable b) {
		Object[] res = new Object[ms.length + b.size()];
		int i = 0;
		for (; i < ms.length; i++) {
			res[i] = ms[i];
		}
		int j = i;
		for (int j1 = 0; j < res.length; j++, j1++) {
			res[j] = b.get(j1);
		}
		ms = res;
	}

	@Override
	public void remove(int i) {
		Object[] result = new Object[ms.length - 1];
		System.arraycopy(ms, 0, result, 0, i);
		System.arraycopy(ms, i + 1, result, i, ms.length - i - 1);
		ms = result;

	}

	@Override
	public Object get(int i) {
		return ms[i];
	}

	@Override
	public int size() {
		return ms.length;
	}

	@Override
	public void set(int index, Object elem) {
		ms[index]= elem;
	}
	
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + Arrays.deepHashCode(ms);
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj) {
			return true;
		}
		if (obj == null) {
			return false;
		}
		if (getClass() != obj.getClass()) {
			return false;
		}
		MyArray other = (MyArray) obj;
		return Arrays.deepEquals(ms, other.ms);
	}

	@Override
	public String toString() {
		String str = "";
		for (int i = 0; i < size(); i++) {
			str += get(i).toString();
		}
		return str;
	}

}
