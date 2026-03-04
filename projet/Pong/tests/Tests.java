import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class ClavierBorneArcadeTest {

    private ClavierBorneArcade clavier;

    @BeforeEach
    void setUp() {
        clavier = new ClavierBorneArcade();
    }

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
    }

    @Test
    void testJ2InitialState() {
        assertFalse(clavier.getJoyJ2GaucheEnfoncee());
        assertFalse(clavier.getJoyJ2DroiteEnfoncee());
        assertFalse(clavier.getJoyJ2HautEnfoncee());
        assertFalse(clavier.getJoyJ2BasEnfoncee());
        assertFalse(clavier.getBoutonJ2AEnfoncee());
        assertFalse(clavier.getBoutonJ2BEnfoncee());
    }

    @Test
    void testTapeInitialState() {
        assertFalse(clavier.getJoyJ1GaucheTape());
        assertFalse(clavier.getJoyJ1DroiteTape());
        assertFalse(clavier.getJoyJ1HautTape());
        assertFalse(clavier.getJoyJ1BasTape());
        assertFalse(clavier.getBoutonJ1ATape());
        assertFalse(clavier.getBoutonJ1BTape());
    }

    @Test
    void testReinitialisation() {
        clavier.reinitialisation();
        assertFalse(clavier.getJoyJ1GaucheEnfoncee());
        assertFalse(clavier.getJoyJ1DroiteEnfoncee());
        assertFalse(clavier.getJoyJ1HautEnfoncee());
        assertFalse(clavier.getJoyJ1BasEnfoncee());
    }
}
