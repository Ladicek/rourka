package com.github.ladicek.rourka.ci;

import java.util.Objects;

abstract public class ValueWrapper {
	protected final String value;
	public static final String emptyValue="Unspecified";

	protected ValueWrapper(String value) {
		this.value = value;
	}

	@Override
	public String toString() {
		if(value == null || value.equals("")){
			return emptyValue;
		}
		return value;
	}

	@Override
	public boolean equals(Object o) {
		if (this == o) return true;
		if (!(o instanceof ValueWrapper)) return false;
		ValueWrapper that = (ValueWrapper) o;
		return Objects.equals(value, that.value);
	}

	@Override
	public int hashCode() {
		return Objects.hash(value);
	}
}
