package com.platformlab.demo;

public class App {

    public String greet(String name) {
        return "Hello, " + name + "! Welcome to Platform Engineering.";
    }

    public static void main(String[] args) {
        App app = new App();
        System.out.println(app.greet("Giri"));
    }
}
