package model.logic;

import java.util.Iterator;


public class StorableIterator<T> implements Iterator<T>{
	
	private Storable<T> ms;
	private int position;
	

	public StorableIterator(Storable<T> ms) {
		this.ms = ms;	
	}

	@Override
	public boolean hasNext() {
		return (position) < ms.size();
	}

	@Override
	public T next() {
		return ms.get(position++);
	}

}
