import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;
import MG2D.*;
import MG2D.geometrie.*;

class EnnemiTest {

    @Test
    void testConstructeurParDefaut() {
        Ennemi ennemi = new Ennemi();
        assertNotNull(ennemi);
        assertNotNull(ennemi.getTextureEnnemi());
        assertEquals(5, ennemi.getVitesse());
    }

    @Test
    void testConstructeurParCopie() {
        Ennemi ennemi1 = new Ennemi();
        Ennemi ennemi2 = new Ennemi(ennemi1);
        assertEquals(5, ennemi2.getVitesse());
        assertNotNull(ennemi2.getTextureEnnemi());
    }

    @Test
    void testConstructeurAvecVitesse() {
        Ennemi ennemi = new Ennemi(10);
        assertNotNull(ennemi);
        assertEquals(10, ennemi.getVitesse());
    }

    @Test
    void testConstructeurAvecPoint() {
        Ennemi ennemi = new Ennemi(new Point(10, 20));
        assertNotNull(ennemi);
        assertNotNull(ennemi.getTextureEnnemi());
    }

    @Test
    void testConstructeurAvecPointEtVitesse() {
        Ennemi ennemi = new Ennemi(new Point(10, 20), 8);
        assertNotNull(ennemi);
        assertEquals(8, ennemi.getVitesse());
    }

    @Test
    void testSetVitesse() {
        Ennemi ennemi = new Ennemi();
        ennemi.setVitesse(15);
        assertEquals(15, ennemi.getVitesse());
    }
}

class JoueurTest {

    @Test
    void testConstructeurParDefaut() {
        Joueur joueur = new Joueur();
        assertNotNull(joueur);
    }

    @Test
    void testConstructeurParCopie() {
        Joueur joueur1 = new Joueur();
        Joueur joueur2 = new Joueur(joueur1);
        assertNotNull(joueur2);
        assertNotNull(joueur2.getTextureJoueur());
    }

    @Test
    void testConstructeurAvecLargeur() {
        Joueur joueur = new Joueur(50);
        assertNotNull(joueur);
    }

    @Test
    void testConstructeurAvecPoint() {
        Joueur joueur = new Joueur(new Point(50, 100));
        assertNotNull(joueur);
    }

    @Test
    void testConstructeurAvecPointEtLargeur() {
        Joueur joueur = new Joueur(new Point(50, 100), 60);
        assertNotNull(joueur);
    }

    @Test
    void testConstructeurAvecPointLargeurHauteur() {
        Joueur joueur = new Joueur(new Point(50, 100), 60, 80);
        assertNotNull(joueur);
    }

    @Test
    void testGetTextureJoueur() {
        Joueur joueur = new Joueur();
        assertNotNull(joueur.getTextureJoueur());
    }

    @Test
    void testEquals() {
        Joueur joueur1 = new Joueur();
        Joueur joueur2 = new Joueur(joueur1);
        assertTrue(joueur1.equals(joueur2));
    }
}
