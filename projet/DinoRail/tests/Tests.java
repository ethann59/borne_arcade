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

    // Tests de base
    @Test
    void testConstructeurInitialisation() {
        assertNotNull(clavier);
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
    }

    // Tests fonctionnels
    @Test
    void testKeyPressedGauche() {
        clavier.keyPressed(new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_PRESSED, 0, 0, KeyEvent.VK_LEFT));
        assertTrue(clavier.getJoyJ1GaucheEnfoncee());
        assertFalse(clavier.getJoyJ1GaucheTape());
    }

    @Test
    void testKeyReleasedGauche() {
        clavier.keyPressed(new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_PRESSED, 0, 0, KeyEvent.VK_LEFT));
        clavier.keyReleased(new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_RELEASED, 0, 0, KeyEvent.VK_LEFT));
        assertFalse(clavier.getJoyJ1GaucheEnfoncee());
        assertTrue(clavier.getJoyJ1GaucheTape());
    }

    @Test
    void testKeyPressedDroite() {
        clavier.keyPressed(new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_PRESSED, 0, 0, KeyEvent.VK_RIGHT));
        assertTrue(clavier.getJoyJ1DroiteEnfoncee());
        assertFalse(clavier.getJoyJ1DroiteTape());
    }

    @Test
    void testKeyReleasedDroite() {
        clavier.keyPressed(new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_PRESSED, 0, 0, KeyEvent.VK_RIGHT));
        clavier.keyReleased(new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_RELEASED, 0, 0, KeyEvent.VK_RIGHT));
        assertFalse(clavier.getJoyJ1DroiteEnfoncee());
        assertTrue(clavier.getJoyJ1DroiteTape());
    }

    @Test
    void testKeyPressedHaut() {
        clavier.keyPressed(new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_PRESSED, 0, 0, KeyEvent.VK_UP));
        assertTrue(clavier.getJoyJ1HautEnfoncee());
        assertFalse(clavier.getJoyJ1HautTape());
    }

    @Test
    void testKeyReleasedHaut() {
        clavier.keyPressed(new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_PRESSED, 0, 0, KeyEvent.VK_UP));
        clavier.keyReleased(new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_RELEASED, 0, 0, KeyEvent.VK_UP));
        assertFalse(clavier.getJoyJ1HautEnfoncee());
        assertTrue(clavier.getJoyJ1HautTape());
    }

    @Test
    void testKeyPressedBas() {
        clavier.keyPressed(new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_PRESSED, 0, 0, KeyEvent.VK_DOWN));
        assertTrue(clavier.getJoyJ1BasEnfoncee());
        assertFalse(clavier.getJoyJ1BasTape());
    }

    @Test
    void testKeyReleasedBas() {
        clavier.keyPressed(new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_PRESSED, 0, 0, KeyEvent.VK_DOWN));
        clavier.keyReleased(new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_RELEASED, 0, 0, KeyEvent.VK_DOWN));
        assertFalse(clavier.getJoyJ1BasEnfoncee());
        assertTrue(clavier.getJoyJ1BasTape());
    }

    @Test
    void testKeyPressedBoutonA() {
        clavier.keyPressed(new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_PRESSED, 0, 0, KeyEvent.VK_F));
        assertTrue(clavier.getBoutonJ1AEnfoncee());
        assertFalse(clavier.getBoutonJ1ATape());
    }

    @Test
    void testKeyReleasedBoutonA() {
        clavier.keyPressed(new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_PRESSED, 0, 0, KeyEvent.VK_F));
        clavier.keyReleased(new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_RELEASED, 0, 0, KeyEvent.VK_F));
        assertFalse(clavier.getBoutonJ1AEnfoncee());
        assertTrue(clavier.getBoutonJ1ATape());
    }

    @Test
    void testKeyPressedBoutonB() {
        clavier.keyPressed(new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_PRESSED, 0, 0, KeyEvent.VK_G));
        assertTrue(clavier.getBoutonJ1BEnfoncee());
        assertFalse(clavier.getBoutonJ1BTape());
    }

    @Test
    void testKeyReleasedBoutonB() {
        clavier.keyPressed(new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_PRESSED, 0, 0, KeyEvent.VK_G));
        clavier.keyReleased(new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_RELEASED, 0, 0, KeyEvent.VK_G));
        assertFalse(clavier.getBoutonJ1BEnfoncee());
        assertTrue(clavier.getBoutonJ1BTape());
    }

    @Test
    void testKeyPressedBoutonC() {
        clavier.keyPressed(new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_PRESSED, 0, 0, KeyEvent.VK_H));
        assertTrue(clavier.getBoutonJ1CEnfoncee());
        assertFalse(clavier.getBoutonJ1CTape());
    }

    @Test
    void testKeyReleasedBoutonC() {
        clavier.keyPressed(new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_PRESSED, 0, 0, KeyEvent.VK_H));
        clavier.keyReleased(new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_RELEASED, 0, 0, KeyEvent.VK_H));
        assertFalse(clavier.getBoutonJ1CEnfoncee());
        assertTrue(clavier.getBoutonJ1CTape());
    }

    @Test
    void testKeyPressedBoutonX() {
        clavier.keyPressed(new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_PRESSED, 0, 0, KeyEvent.VK_R));
        assertTrue(clavier.getBoutonJ1XEnfoncee());
        assertFalse(clavier.getBoutonJ1XTape());
    }

    @Test
    void testKeyReleasedBoutonX() {
        clavier.keyPressed(new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_PRESSED, 0, 0, KeyEvent.VK_R));
        clavier.keyReleased(new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_RELEASED, 0, 0, KeyEvent.VK_R));
        assertFalse(clavier.getBoutonJ1XEnfoncee());
        assertTrue(clavier.getBoutonJ1XTape());
    }

    @Test
    void testKeyPressedBoutonY() {
        clavier.keyPressed(new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_PRESSED, 0, 0, KeyEvent.VK_T));
        assertTrue(clavier.getBoutonJ1YEnfoncee());
        assertFalse(clavier.getBoutonJ1YTape());
    }

    @Test
    void testKeyReleasedBoutonY() {
        clavier.keyPressed(new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_PRESSED, 0, 0, KeyEvent.VK_T));
        clavier.keyReleased(new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_RELEASED, 0, 0, KeyEvent.VK_T));
        assertFalse(clavier.getBoutonJ1YEnfoncee());
        assertTrue(clavier.getBoutonJ1YTape());
    }

    @Test
    void testKeyPressedBoutonZ() {
        clavier.keyPressed(new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_PRESSED, 0, 0, KeyEvent.VK_Y));
        assertTrue(clavier.getBoutonJ1ZEnfoncee());
        assertFalse(clavier.getBoutonJ1ZTape());
    }

    @Test
    void testKeyReleasedBoutonZ() {
        clavier.keyPressed(new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_PRESSED, 0, 0, KeyEvent.VK_Y));
        clavier.keyReleased(new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_RELEASED, 0, 0, KeyEvent.VK_Y));
        assertFalse(clavier.getBoutonJ1ZEnfoncee());
        assertTrue(clavier.getBoutonJ1ZTape());
    }

    // Tests de cas limites
    @Test
    void testMultipleKeyPressesSameKey() {
        clavier.keyPressed(new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_PRESSED, 0, 0, KeyEvent.VK_LEFT));
        clavier.keyPressed(new KeyEvent(new java.awt.Frame(), KeyEvent.KEY_PRESSED, 0, 0, KeyEvent.VK_LEFT));
        assertTrue(clavier.getJoyJ1GaucheEnfoncee());
    }

    // Note : tests tronqués lors de la génération automatique.
}
