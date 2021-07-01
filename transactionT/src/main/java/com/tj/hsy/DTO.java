package com.tj.hsy;

public class DTO {
	private String name;
	private int input,left,withdraw;
	public DTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public DTO(String name, int input, int withdraw) {
		super();
		this.name = name;
		this.input = input;
		this.withdraw = withdraw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getInput() {
		return input;
	}
	public void setInput(int input) {
		this.input = input;
	}
	public int getLeft() {
		return left;
	}
	public void setLeft(int left) {
		this.left = left;
	}
	public int getWithdraw() {
		return withdraw;
	}
	public void setWithdraw(int withdraw) {
		this.withdraw = withdraw;
	}
	
}
