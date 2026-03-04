import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class JeuTest {

    @Test
    void testJeuConstructor() {
        Jeu jeu = new Jeu();
        assertNotNull(jeu);
    }

    @Test
    void testEnnemiConstructor() {
        Ennemi ennemi = new Ennemi(null, 10, 20, 5);
        assertNotNull(ennemi);
        assertEquals(10, ennemi.getVit());
        assertEquals(20, ennemi.getVie());
        assertEquals(5, ennemi.getTraj());
    }

    @Test
    void testEnnemiCopyConstructor() {
        Ennemi ennemi1 = new Ennemi(null, 10, 20, 5);
        Ennemi ennemi2 = new Ennemi(ennemi1);
        assertEquals(10, ennemi2.getVit());
        assertEquals(20, ennemi2.getVie());
        assertEquals(5, ennemi2.getTraj());
    }

    @Test
    void testEnnemiEquals() {
        Ennemi ennemi1 = new Ennemi(null, 10, 20, 5);
        Ennemi ennemi2 = new Ennemi(null, 10, 20, 5);
        assertTrue(ennemi1.equals(ennemi2));

        Ennemi ennemi3 = new Ennemi(null, 20, 30, 10);
        assertFalse(ennemi1.equals(ennemi3));
    }

    @Test
    void testJeu(){
        Jeu jeu = new Jeu();
        assertNotNull(jeu);
    }

    // Add more tests here to cover the other classes and methods
}
