package org.example;

public class App {

    public static void main(String[] args) throws InterruptedException {
        while (true) {
            System.out.println(getGreeting());
            Thread.sleep(2000);
        }
    }

    // Add this so the test can use it
    public static String getGreeting() {
        return "Hello World";
    }
}
