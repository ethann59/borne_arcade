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
    void testConstructeurAvecCheminImage() {
        Ennemi ennemi = new Ennemi("img/car.png");
        assertNotNull(ennemi);
        assertNotNull(ennemi.getTextureEnnemi());
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
    void testConstructeurAvecPointLargeurHauteur() {
        Ennemi ennemi = new Ennemi(new Point(10, 20), 50, 100);
        assertNotNull(ennemi);
        assertNotNull(ennemi.getTextureEnnemi());
    }

    @Test
    void testSetVitesse() {
        Ennemi ennemi = new Ennemi();
        ennemi.setVitesse(15);
        assertEquals(15, ennemi.getVitesse());
    }

    @Test
    void testSetVitesseNegative() {
        Ennemi ennemi = new Ennemi();
        ennemi.setVitesse(-5);
        assertEquals(-5, ennemi.getVitesse());
    }

    @Test
    void testIntersectionAvecEnnemi() {
        Ennemi ennemi = new Ennemi(new Point(0, 0));
        Joueur joueur = new Joueur(new Point(10, 10));
        assertFalse(joueur.intersection(ennemi));
    }

    @Test
    void testIntersectionAvecEnnemiCollision() {
        Ennemi ennemi = new Ennemi(new Point(0, 0));
        Joueur joueur = new Joueur(new Point(5, 5));
        assertTrue(joueur.intersection(ennemi));
    }

    @Test
    void testEquals() {
        Ennemi ennemi1 = new Ennemi();
        Ennemi ennemi2 = new Ennemi(ennemi1);
        assertTrue(ennemi1.equals(ennemi2));
    }

    @Test
    void testEqualsNull() {
        Ennemi ennemi = new Ennemi();
        assertFalse(ennemi.equals(null));
    }

    @Test
    void testEqualsDifferentClass() {
        Ennemi ennemi = new Ennemi();
        assertFalse(ennemi.equals(new Object()));
    }

    @Test
    void testToString() {
        Ennemi ennemi = new Ennemi();
        assertNotNull(ennemi.toString());
    }

    @Test
    void testConstructeurAvecVitesseExtreme() {
        Ennemi ennemi = new Ennemi(-1000);
        assertEquals(-1000, ennemi.getVitesse());
    }

    @Test
    void testConstructeurAvecPointNegatif() {
        Ennemi ennemi = new Ennemi(new Point(-10, -20));
        assertNotNull(ennemi.getTextureEnnemi());
    }

    @Test
    void testConstructeurAvecLargeurHauteurNegatives() {
        Ennemi ennemi = new Ennemi(new Point(0, 0), -50, -100);
        assertNotNull(ennemi.getTextureEnnemi());
    }

    @Test
    void testIntersectionAvecNull() {
        Ennemi ennemi = new Ennemi();
        Joueur joueur = new Joueur();
        assertThrows(NullPointerException.class, () -> joueur.intersection(null));
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
    void testConstructeurAvecTexture() {
        Texture texture = new Texture("img/stickman.png", new Point(0, 0), 50, 100);
        Joueur joueur = new Joueur(texture);
        assertNotNull(joueur);
        assertNotNull(joueur.getTextureJoueur());
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
        Joueur joueur = new Joueur(new Point(50, 100), 50);
        assertNotNull(joueur);
    }

    @Test
    void testConstructeurAvecPointLargeurHauteur() {
        Joueur joueur = new Joueur(new Point(50, 100), 50, 100);
        assertNotNull(joueur);
    }

    @Test
    void testSetTextureJoueur() {
        Joueur joueur = new Joueur();
        Texture texture = new Texture("img/stickman.png", new Point(0, 0), 50, 100);
        joueur.setTextureJoueur(texture);
        assertEquals(texture, joueur.getTextureJoueur());
    }

    @Test
    void testIntersectionAvecNull() {
        Joueur joueur = new Joueur();
        Ennemi ennemi = new Ennemi();
        assertThrows(NullPointerException.class, () -> joueur.intersection(null));
    }

    @Test
    void testIntersectionAvecEnnemi() {
        Joueur joueur = new Joueur(new Point(0, 0));
        Ennemi ennemi = new Ennemi(new Point(5, 5));
        assertTrue(joueur.intersection(ennemi));
    }

    @Test
    void testEquals() {
        Joueur joueur1 = new Joueur();
        Joueur joueur2 = new Joueur(joueur1);
        assertTrue(joueur1.equals(joueur2));
    }

    @Test
    void testEqualsNull() {
        Joueur joueur = new Joueur();
        assertFalse(joueur.equals(null));
    }

    @Test
    void testEqualsDifferentClass() {
        Joueur joueur = new Joueur();
        assertFalse(joueur.equals(new Object()));
    }

    @Test
    void testToString() {
        Joueur joueur = new Joueur();
        assertNotNull(joueur.toString());
    }

    @Test
    void testConstructeurAvecPointNegatif() {
        Joueur joueur = new Joueur(new Point(-50, -100));
        assertNotNull(joueur.getTextureJoueur());
    }

    @Test
    void testConstructeurAvecLargeurHauteurNegatives() {
        Joueur joueur = new Joueur(new Point(0, 0), -50, -100);
        assertNotNull(joueur.getTextureJoueur());
    }
}

class JeuTest {

    @Test
    void testConstructeur() {
        Jeu jeu = new Jeu();
        assertNotNull(jeu);
    }

    @Test
    void testAvancerUnPasDeTemps() {
        Jeu jeu = new Jeu();
        assertDoesNotThrow(() -> jeu.AvancerUnPasDeTemps());
    }

    @Test
    void testGenererDecor() {
        Jeu jeu = new Jeu();
        assertDoesNotThrow(() -> jeu.GenererDecor());
    }

    @Test
    void testGenererEnnemi() {
        Jeu jeu = new Jeu();
        assertDoesNotThrow(() -> jeu.GenererEnnemi());
    }

    @Test
    void testFin() {
        Jeu jeu = new Jeu();
        assertDoesNotThrow(() -> jeu.fin());
    }

    @Test
    void testGetFenetre() {
        Jeu jeu = new Jeu();
        assertNotNull(jeu.getFenetre());
    }

    // Note : tests tronqués lors de la génération automatique.
}
