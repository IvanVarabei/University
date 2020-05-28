package colection;

import java.util.*;

public class SetTest {

	public static void main(String... ew) {
		Set hashSet = new HashSet();
		Set linkedHashSet = new LinkedHashSet();// doesn't add new methods, but
		// provides the sequence of adding
		
		Comparator cp = new Comparator() {
			@Override
			public int compare(Object o1, Object o2) {
				return ((Foot)o1).Field - ((Foot)o2).Field;
			}
		};
		
		
		@SuppressWarnings("unchecked")
		Set treeSet = new TreeSet(cp);

		treeSet.add(new Foot(5));
		treeSet.add(new Foot(1));
		treeSet.add(new Foot(1));
		treeSet.add(new Foot(2));
		treeSet.add(new Foot(3));
		treeSet.add(new Foot(4));
		treeSet.add(new Foot(7));
		treeSet.add(new Foot(8));
		treeSet.add(new Foot(6));

		Iterator iter = treeSet.iterator();

		while (iter.hasNext()) {
			System.out.println(iter.next());
		}

		//linkedHashSet.forEach(t -> System.out.println(t));
		System.out.println();
		
	}

}

