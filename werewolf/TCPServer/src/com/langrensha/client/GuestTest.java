package com.langrensha.client;

import javax.swing.JFrame;

public class GuestTest {
	static int width = 360;
	static int height = 400;
	static int count = 3;

	public static void main(String[] args) {
		createGuest();
	}

	public static void createGuest() {
		ClientFrame c = new ClientFrame(false, "999");
		c.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		c.setBounds((int) (Math.random() * 1000), 100, width, height);
		c.setVisible(true);
		c.run();
	}
}
