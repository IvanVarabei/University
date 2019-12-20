package by.bntu.fitr.nameofstudent.javalabs.lab07.model;

import static org.junit.Assert.*;

import org.junit.Test;

import by.bntu.fitr.varabei.javalabs.lab07.model.Letter;

public class LetterTest {

	@Test
	public void testDetermineLetter() {
		assertEquals("error",Letter.determineLetter('0'));
		assertEquals("CONSONANT",Letter.determineLetter('d'));
		assertEquals("CONSONANT",Letter.determineLetter('r'));
		assertEquals("VOWEL",Letter.determineLetter('o'));
		assertEquals("VOWEL",Letter.determineLetter('U'));
	}

}
