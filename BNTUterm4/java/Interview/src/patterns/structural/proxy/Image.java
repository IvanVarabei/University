package patterns.structural.proxy;

interface Image {
	void show();
}

class RealImage implements Image{
	RealImage(){
		load();
		int [][][]t[][];
	}

	public void load() {
		System.out.println("The image is being loaded...");
	}
	@Override
	public void show() {
		System.out.println("The image has been shown.");
	}
}

class ProxyImage implements Image{
	RealImage realImage;

	@Override
	public void show() {
		if(realImage == null) {
			realImage = new RealImage();
		}
		realImage.show();
	}
}