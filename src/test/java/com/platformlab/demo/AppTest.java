package com.platformlab.demo;

import org.junit.Test;
import static org.junit.Assert.*;

public class AppTest {

    @Test
    public void testGreet() {
        App app = new App();
        String result = app.greet("Giri");
        assertEquals("Hello, Giri! Welcome to Platform Engineering.", result);
    }

    @Test
    public void testGreetWithDifferentName() {
        App app = new App();
        String result = app.greet("Zions");
        assertTrue(result.contains("Zions"));
    }
}
