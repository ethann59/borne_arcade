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
    void testInitialState() {
        assertFalse(clavier.getJoyJ1GaucheEnfoncee());
        assertFalse(clavier.getJoyJ1DroiteEnfoncee());
        assertFalse(clavier.getJoyJ1HautEnfoncee());
        assertFalse(clavier.getJoyJ1BasEnfoncee());
    }

    @Test
    void testBoutonsInitialState() {
        assertFalse(clavier.getBoutonJ1AEnfoncee());
        assertFalse(clavier.getBoutonJ1BEnfoncee());
        assertFalse(clavier.getBoutonJ1CEnfoncee());
        assertFalse(clavier.getBoutonJ1XEnfoncee());
        assertFalse(clavier.getBoutonJ1YEnfoncee());
        assertFalse(clavier.getBoutonJ1ZEnfoncee());
    }

    @Test
    void testJoyJ1TapeInitialState() {
        assertFalse(clavier.getJoyJ1GaucheTape());
        assertFalse(clavier.getJoyJ1DroiteTape());
        assertFalse(clavier.getJoyJ1HautTape());
        assertFalse(clavier.getJoyJ1BasTape());
    }

    @Test
    void testBoutonsTapeInitialState() {
        assertFalse(clavier.getBoutonJ1ATape());
        assertFalse(clavier.getBoutonJ1BTape());
        assertFalse(clavier.getBoutonJ1CTape());
        assertFalse(clavier.getBoutonJ1XTape());
        assertFalse(clavier.getBoutonJ1YTape());
        assertFalse(clavier.getBoutonJ1ZTape());
    }

    @Test
    void testReinitialisation() {
        clavier.reinitialisation();
        assertFalse(clavier.getJoyJ1GaucheEnfoncee());
        assertFalse(clavier.getJoyJ1DroiteEnfoncee());
        assertFalse(clavier.getBoutonJ1AEnfoncee());
    }
}
