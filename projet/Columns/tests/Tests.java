import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class ClavierBorneArcadeTest {

    @Test
    void testClavierBorneArcadeConstructor() {
        ClavierBorneArcade clavier = new ClavierBorneArcade();
        assertNotNull(clavier);
    }

    @Test
    void testGetJoyJ1Haut() {
        ClavierBorneArcade clavier = new ClavierBorneArcade();
        boolean pressed = clavier.getJoyJ1HautTape();
        assertFalse(pressed);
    }

    @Test
    void testGetJoyJ1Bas() {
        ClavierBorneArcade clavier = new ClavierBorneArcade();
        boolean pressed = clavier.getJoyJ1BasTape();
        assertFalse(pressed);
    }

    @Test
    void testGetJoyJ1Droite() {
        ClavierBorneArcade clavier = new ClavierBorneArcade();
        boolean pressed = clavier.getJoyJ1DroiteTape();
        assertFalse(pressed);
    }

    @Test
    void testGetJoyJ1Gauche() {
        ClavierBorneArcade clavier = new ClavierBorneArcade();
        boolean pressed = clavier.getJoyJ1GaucheTape();
        assertFalse(pressed);
    }

    @Test
    void testGetBoutonJ1ATape() {
        ClavierBorneArcade clavier = new ClavierBorneArcade();
        boolean pressed = clavier.getBoutonJ1ATape();
        assertFalse(pressed);
    }

    @Test
    void testGetBoutonJ1ZTape() {
        ClavierBorneArcade clavier = new ClavierBorneArcade();
        boolean pressed = clavier.getBoutonJ1ZTape();
        assertFalse(pressed);
    }
}
