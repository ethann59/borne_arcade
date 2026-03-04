import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class ClavierBorneArcadeTest {

    @Test
    void testInitialisation() {
        ClavierBorneArcade clavier = new ClavierBorneArcade();
        assertNotNull(clavier);
    }

    @Test
    void testJoystickJ1InitialState() {
        ClavierBorneArcade clavier = new ClavierBorneArcade();
        assertFalse(clavier.getJoyJ1GaucheEnfoncee());
        assertFalse(clavier.getJoyJ1DroiteEnfoncee());
        assertFalse(clavier.getJoyJ1HautEnfoncee());
        assertFalse(clavier.getJoyJ1BasEnfoncee());
    }

    @Test
    void testBoutonsJ1InitialState() {
        ClavierBorneArcade clavier = new ClavierBorneArcade();
        assertFalse(clavier.getBoutonJ1AEnfoncee());
        assertFalse(clavier.getBoutonJ1BEnfoncee());
        assertFalse(clavier.getBoutonJ1CEnfoncee());
    }

    @Test
    void testReinitialisation() {
        ClavierBorneArcade clavier = new ClavierBorneArcade();
        clavier.reinitialisation();
        assertFalse(clavier.getJoyJ1GaucheEnfoncee());
        assertFalse(clavier.getJoyJ1DroiteEnfoncee());
        assertFalse(clavier.getJoyJ1HautEnfoncee());
        assertFalse(clavier.getJoyJ1BasEnfoncee());
    }

    @Test
    void testJoystickJ1TapeInitialState() {
        ClavierBorneArcade clavier = new ClavierBorneArcade();
        assertFalse(clavier.getJoyJ1GaucheTape());
        assertFalse(clavier.getJoyJ1DroiteTape());
        assertFalse(clavier.getJoyJ1HautTape());
        assertFalse(clavier.getJoyJ1BasTape());
    }
}
