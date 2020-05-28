package model.logic;

import java.util.Iterator;

public interface Storable<B> extends Iterable<B>{
	void add(B b);

	void addAll(Storable<B> b);

	void remove(int i);

	B get(int i);

	int size();
	
	void set(int index, B elem);
	
	public default Iterator<B> iterator() {
		return new StorableIterator<B>((Storable<B>) this);
	}
	
}
