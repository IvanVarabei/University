package patterns.behavioral.observer;

import java.util.Observable;
import java.util.Observer;

public class ObserverTest {

	public static void main(String ...dg) {
		EventSource es = new EventSource();
		es.addObserver(new Observer() {
				@Override
				public void update(Observable o, Object arg) {
					System.out.println("First" +  arg.toString());
				}
		});
		es.addObserver(new Third());
		es.addObserver(new Observer() {
			@Override
			public void update(Observable o, Object arg) {
				System.out.println("Second" + arg.toString());
			}
	});
		es.notifyObservers(" hello");
	}

}

class Third implements Observer{
	@Override
	public void update(Observable o, Object arg) {
		System.out.println("Third " + arg.toString());
	}
}

class EventSource extends Observable{

	@Override
	public void notifyObservers(Object o) {
		setChanged();
		super.notifyObservers(o);
		clearChanged();
	}

}
