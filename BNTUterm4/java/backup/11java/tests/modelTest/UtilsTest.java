package modelTest;

import static org.junit.Assert.*;
import static view.Output.exhibit;

import java.util.Arrays;

import static model.Utils.*;
import org.junit.Test;

import model.Developer;
import model.MyFactory;

public class UtilsTest {

	@Test
	public final void testSearchIndexByValue1() {
		int ms[] = { 0, 3, 1, 4, 9 };
		assertEquals(4, searchIndexByValue(ms, 9));
	}

	@Test
	public final void testSearchIndexByValue2() {
		int ms[] = { 10, 3, 1, 4, 9 };
		assertEquals(0, searchIndexByValue(ms, 10));
	}

	@Test
	public final void testBinarySearch() {
		MyFactory factory = new MyFactory();
		Developer ms[] = factory.developerCrete(60, true);
		assertEquals(ms[51].toString(), binarySearch(ms, ms[51].getId()).toString());
	}

	@Test
	public final void testSortAge() {
		fail("Not yet implemented"); // TODO
	}

	@Test
	public final void testSortName() {
		fail("Not yet implemented"); // TODO
	}

	@Test
	public final void testSortSkill() {
		fail("Not yet implemented"); // TODO
	}

	@Test
	public final void testSortIdMinToMax() {
		MyFactory factory = new MyFactory();
		Developer ms[] = factory.developerCrete(100, true);
		ms = sortIdMinToMax(ms);
		for (int i = 0; i < ms.length - 1; i++) {
			if (ms[i].getId() > ms[i + 1].getId()) {
				fail();
			}
		}
	}

	@Test
	public final void testAddElemDeveloperArrayDeveloper() {
		MyFactory factory = new MyFactory();
		Developer ms[] = factory.developerCrete(10, true);
		int curId = 23154;
		Developer item = new Developer("Valera", 40, true, 43, curId);
		ms = addElem(ms, item);
		assertEquals(curId, ms[10].getId());
	}

	@Test
	public final void testAddElemIntArrayInt() {

	}

	@Test
	public final void testDelElemIntArrayInt() {
		fail("Not yet implemented"); // TODO
	}

	@Test
	public final void testDelElemDeveloperArrayInt() {
		fail("Not yet implemented"); // TODO
	}

	@Test
	public final void testCombainArrays() {
		fail("Not yet implemented"); // TODO
	}

}
