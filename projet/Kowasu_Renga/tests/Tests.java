import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;
import MG2D.*;
import MG2D.geometrie.*;

class Kowasu_RengaTest {

    @Test
    void testClavierBorneArcadeCreation() {
        ClavierBorneArcade clavier = new ClavierBorneArcade();
        assertNotNull(clavier);
        assertFalse(clavier.getJoyJ1GaucheEnfoncee());
        assertFalse(clavier.getJoyJ1DroiteEnfoncee());
        assertFalse(clavier.getJoyJ1HautEnfoncee());
        assertFalse(clavier.getJoyJ1BasEnfoncee());
    }

    @Test
    void testPointCreation() {
        Point p = new Point(100, 200);
        assertNotNull(p);
        assertEquals(100, p.getX());
        assertEquals(200, p.getY());
    }

    @Test
    void testCercleCreation() {
        Cercle cercle = new Cercle(Couleur.BLANC, new Point(640, 80), 8, true);
        assertNotNull(cercle);
    }

    @Test
    void testRectangleCreation() {
        int largeur = 1280;
        int hauteur = 720;
        Rectangle rect = new Rectangle(Couleur.BLANC, new Point(0, 0), largeur, hauteur, true);
        assertNotNull(rect);
    }

    @Test
    void testTextureCreation() {
        Texture texture = new Texture("img/background.jpg", new Point(0, 0), 1280, 720);
        assertNotNull(texture);
    }

    @Test
    void testReinitialisation() {
        ClavierBorneArcade clavier = new ClavierBorneArcade();
        clavier.reinitialisation();
        assertFalse(clavier.getBoutonJ1AEnfoncee());
    }
}
