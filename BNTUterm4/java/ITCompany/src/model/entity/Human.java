package model.entity;

import java.util.Objects;

public class Human {

	private String name;
	private int age;
	private boolean isHasJob;

	public Human(String name, int age, boolean isHasJob) {
		this.name = name;
		this.age = age;
		this.isHasJob = isHasJob;
	}

	public Human(Human human) {
		name = human.name;
		age = human.age;
		isHasJob = human.isHasJob;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public int getAge() {
		return age;
	}

	public void setIsHasJob(boolean isHasJob) {
		this.isHasJob = isHasJob;
	}

	public boolean getIsHasJob() {
		return isHasJob;
	}

	@Override
	public int hashCode() {
		return Objects.hash(age, isHasJob, name);
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
		Human other = (Human) obj;
		return age == other.age && isHasJob == other.isHasJob && Objects.equals(name, other.name);
	}

	@Override
	public String toString() {
		return "name=" + name + "\tage=" + age + "\tisHasJob=" + isHasJob;
	}

}
