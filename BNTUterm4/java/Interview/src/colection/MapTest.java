package colection;

import java.util.*;

public class MapTest {

	public static void main(String ...ds) {
		HashMap<Integer, Foot> hashMap = new HashMap<>();
		Map linkedHashMap = new LinkedHashMap();
		Map treeMap = new TreeMap();//can't contain null
		Map weakHashMap = new WeakHashMap();
		Map hashTable = new Hashtable();
		hashMap.put(1, new Foot(11));
		hashMap.put(2, new Foot(22));
		hashMap.put(3, new Foot(33));
		hashMap.put(4, new Foot(44));
		hashMap.put(5, new Foot(55));
		System.out.println(hashMap.get(11));
		// получим весь набор ключей
	       Set<Integer> keys = hashMap.keySet();
	       keys.forEach(t -> System.out.println(t));
	       // получить набор всех значений
	       Collection<Foot> values = hashMap.values();
	       values.forEach(t -> System.out.println(t));

	       // перебор элементов
	       for(Map.Entry<Integer, Foot> item : hashMap.entrySet()){
	         
	           System.out.printf("Key: %d  Value: %s \n", item.getKey(), item.getValue());
	       }
	       
	       hashMap.forEach((item, i) ->System.out.printf("Key: %d  Value: %s \n", item, i));
	}


}

class Foot implements Comparable{
	public Foot(int i ) {
		Field = i;
	}
	public int Field;
	
	public int get(Foot f) {
		System.out.println("Foot");
		return 0;
	}
	
	

	@Override
	public int hashCode() {
		return Objects.hash(Field);
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
		Foot other = (Foot) obj;
		return Field == other.Field;
	}



	@Override
	public String toString() {
		return "Field = " + Field;
	}


	@Override
	public int compareTo(Object o) {
		// TODO Auto-generated method stub
		return this.Field - ((Foot)o).Field;
	}

}

class Foot2 extends Foot{

	public Foot2(int i) {
		super(i);
		// TODO Auto-generated constructor stub
	}
	
	@Override
	public int get(Foot f) {
		System.out.println("Foot2");
		return 0;
	}
	
}