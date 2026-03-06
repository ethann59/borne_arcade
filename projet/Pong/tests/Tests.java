import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

import java.awt.event.KeyEvent;

class ClavierBorneArcadeTest {

    private ClavierBorneArcade clavier;

    @BeforeEach
    void setUp() {
        clavier = new ClavierBorneArcade();
    }

    // Tests de base - Initialisation, constructeurs
    @Test
    void testConstructorInitialState() {
        assertFalse(clavier.getJoyJ1GaucheEnfoncee());
        assertFalse(clavier.getJoyJ1DroiteEnfoncee());
        assertFalse(clavier.getJoyJ1HautEnfoncee());
        assertFalse(clavier.getJoyJ1BasEnfoncee());
        assertFalse(clavier.getBoutonJ1AEnfoncee());
        assertFalse(clavier.getBoutonJ1BEnfoncee());
        assertFalse(clavier.getBoutonJ1CEnfoncee());
        assertFalse(clavier.getBoutonJ1XEnfoncee());
        assertFalse(clavier.getBoutonJ1YEnfoncee());
        assertFalse(clavier.getBoutonJ1ZEnfoncee());
        assertFalse(clavier.getJoyJ2GaucheEnfoncee());
        assertFalse(clavier.getJoyJ2DroiteEnfoncee());
        assertFalse(clavier.getJoyJ2HautEnfoncee());
        assertFalse(clavier.getJoyJ2BasEnfoncee());
        assertFalse(clavier.getBoutonJ2AEnfoncee());
        assertFalse(clavier.getBoutonJ2BEnfoncee());
        assertFalse(clavier.getBoutonJ2CEnfoncee());
        assertFalse(clavier.getBoutonJ2XEnfoncee());
        assertFalse(clavier.getBoutonJ2YEnfoncee());
        assertFalse(clavier.getBoutonJ2ZEnfoncee());
    }

    @Test
    void testTapeInitialState() {
        assertFalse(clavier.getJoyJ1GaucheTape());
        assertFalse(clavier.getJoyJ1DroiteTape());
        assertFalse(clavier.getJoyJ1HautTape());
        assertFalse(clavier.getJoyJ1BasTape());
        assertFalse(clavier.getBoutonJ1ATape());
        assertFalse(clavier.getBoutonJ1BTape());
        assertFalse(clavier.getBoutonJ1CTape());
        assertFalse(clavier.getBoutonJ1XTape());
        assertFalse(clavier.getBoutonJ1YTape());
        assertFalse(clavier.getBoutonJ1ZTape());
        assertFalse(clavier.getJoyJ2GaucheTape());
        assertFalse(clavier.getJoyJ2DroiteTape());
        assertFalse(clavier.getJoyJ2HautTape());
        assertFalse(clavier.getJoyJ2BasTape());
        assertFalse(clavier.getBoutonJ2ATape());
        assertFalse(clavier.getBoutonJ2BTape());
        assertFalse(clavier.getBoutonJ2CTape());
        assertFalse(clavier.getBoutonJ2XTape());
        assertFalse(clavier.getBoutonJ2YTape());
        assertFalse(clavier.getBoutonJ2ZTape());
    }

    // Tests fonctionnels - Logique métier, mécaniques de jeu
    @Test
    void testJoyJ1HautEnfoncee() {
        KeyEvent keyEvent = new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_PRESSED, System.currentTimeMillis(), 0, KeyEvent.VK_UP, KeyEvent.CHAR_UNDEFINED);
        clavier.keyPressed(keyEvent);
        assertTrue(clavier.getJoyJ1HautEnfoncee());
    }

    @Test
    void testJoyJ1BasEnfoncee() {
        KeyEvent keyEvent = new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_PRESSED, System.currentTimeMillis(), 0, KeyEvent.VK_DOWN, KeyEvent.CHAR_UNDEFINED);
        clavier.keyPressed(keyEvent);
        assertTrue(clavier.getJoyJ1BasEnfoncee());
    }

    @Test
    void testJoyJ1GaucheEnfoncee() {
        KeyEvent keyEvent = new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_PRESSED, System.currentTimeMillis(), 0, KeyEvent.VK_LEFT, KeyEvent.CHAR_UNDEFINED);
        clavier.keyPressed(keyEvent);
        assertTrue(clavier.getJoyJ1GaucheEnfoncee());
    }

    @Test
    void testJoyJ1DroiteEnfoncee() {
        KeyEvent keyEvent = new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_PRESSED, System.currentTimeMillis(), 0, KeyEvent.VK_RIGHT, KeyEvent.CHAR_UNDEFINED);
        clavier.keyPressed(keyEvent);
        assertTrue(clavier.getJoyJ1DroiteEnfoncee());
    }

    @Test
    void testBoutonJ1AEnfoncee() {
        KeyEvent keyEvent = new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_PRESSED, System.currentTimeMillis(), 0, KeyEvent.VK_F, KeyEvent.CHAR_UNDEFINED);
        clavier.keyPressed(keyEvent);
        assertTrue(clavier.getBoutonJ1AEnfoncee());
    }

    @Test
    void testBoutonJ1BEnfoncee() {
        KeyEvent keyEvent = new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_PRESSED, System.currentTimeMillis(), 0, KeyEvent.VK_G, KeyEvent.CHAR_UNDEFINED);
        clavier.keyPressed(keyEvent);
        assertTrue(clavier.getBoutonJ1BEnfoncee());
    }

    @Test
    void testBoutonJ1CEnfoncee() {
        KeyEvent keyEvent = new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_PRESSED, System.currentTimeMillis(), 0, KeyEvent.VK_H, KeyEvent.CHAR_UNDEFINED);
        clavier.keyPressed(keyEvent);
        assertTrue(clavier.getBoutonJ1CEnfoncee());
    }

    @Test
    void testBoutonJ1XEnfoncee() {
        KeyEvent keyEvent = new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_PRESSED, System.currentTimeMillis(), 0, KeyEvent.VK_R, KeyEvent.CHAR_UNDEFINED);
        clavier.keyPressed(keyEvent);
        assertTrue(clavier.getBoutonJ1XEnfoncee());
    }

    @Test
    void testBoutonJ1YEnfoncee() {
        KeyEvent keyEvent = new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_PRESSED, System.currentTimeMillis(), 0, KeyEvent.VK_T, KeyEvent.CHAR_UNDEFINED);
        clavier.keyPressed(keyEvent);
        assertTrue(clavier.getBoutonJ1YEnfoncee());
    }

    @Test
    void testBoutonJ1ZEnfoncee() {
        KeyEvent keyEvent = new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_PRESSED, System.currentTimeMillis(), 0, KeyEvent.VK_Y, KeyEvent.CHAR_UNDEFINED);
        clavier.keyPressed(keyEvent);
        assertTrue(clavier.getBoutonJ1ZEnfoncee());
    }

    @Test
    void testJoyJ2HautEnfoncee() {
        KeyEvent keyEvent = new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_PRESSED, System.currentTimeMillis(), 0, KeyEvent.VK_O, KeyEvent.CHAR_UNDEFINED);
        clavier.keyPressed(keyEvent);
        assertTrue(clavier.getJoyJ2HautEnfoncee());
    }

    @Test
    void testJoyJ2BasEnfoncee() {
        KeyEvent keyEvent = new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_PRESSED, System.currentTimeMillis(), 0, KeyEvent.VK_L, KeyEvent.CHAR_UNDEFINED);
        clavier.keyPressed(keyEvent);
        assertTrue(clavier.getJoyJ2BasEnfoncee());
    }

    @Test
    void testJoyJ2GaucheEnfoncee() {
        KeyEvent keyEvent = new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_PRESSED, System.currentTimeMillis(), 0, KeyEvent.VK_K, KeyEvent.CHAR_UNDEFINED);
        clavier.keyPressed(keyEvent);
        assertTrue(clavier.getJoyJ2GaucheEnfoncee());
    }

    @Test
    void testJoyJ2DroiteEnfoncee() {
        KeyEvent keyEvent = new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_PRESSED, System.currentTimeMillis(), 0, KeyEvent.VK_M, KeyEvent.CHAR_UNDEFINED);
        clavier.keyPressed(keyEvent);
        assertTrue(clavier.getJoyJ2DroiteEnfoncee());
    }

    @Test
    void testBoutonJ2AEnfoncee() {
        KeyEvent keyEvent = new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_PRESSED, System.currentTimeMillis(), 0, KeyEvent.VK_Q, KeyEvent.CHAR_UNDEFINED);
        clavier.keyPressed(keyEvent);
        assertTrue(clavier.getBoutonJ2AEnfoncee());
    }

    @Test
    void testBoutonJ2BEnfoncee() {
        KeyEvent keyEvent = new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_PRESSED, System.currentTimeMillis(), 0, KeyEvent.VK_S, KeyEvent.CHAR_UNDEFINED);
        clavier.keyPressed(keyEvent);
        assertTrue(clavier.getBoutonJ2BEnfoncee());
    }

    @Test
    void testBoutonJ2CEnfoncee() {
        KeyEvent keyEvent = new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_PRESSED, System.currentTimeMillis(), 0, KeyEvent.VK_D, KeyEvent.CHAR_UNDEFINED);
        clavier.keyPressed(keyEvent);
        assertTrue(clavier.getBoutonJ2CEnfoncee());
    }

    @Test
    void testBoutonJ2XEnfoncee() {
        KeyEvent keyEvent = new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_PRESSED, System.currentTimeMillis(), 0, KeyEvent.VK_A, KeyEvent.CHAR_UNDEFINED);
        clavier.keyPressed(keyEvent);
        assertTrue(clavier.getBoutonJ2XEnfoncee());
    }

    // Note : tests tronqués lors de la génération automatique.
}
