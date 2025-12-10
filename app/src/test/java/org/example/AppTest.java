package org.example;

import org.junit.Test;
import static org.junit.Assert.*;

public class AppTest {

    @Test
    public void appHasAGreeting() {
        String greeting = App.getGreeting();
        assertEquals("Hello World", greeting);
    }
}
