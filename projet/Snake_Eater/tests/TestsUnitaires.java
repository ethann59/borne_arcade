import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.BeforeEach;
import static org.junit.jupiter.api.Assertions.*;
import java.util.ArrayList;
import MG2D.Fenetre;
import MG2D.geometrie.Point;
import MG2D.geometrie.Carre;
import MG2D.Couleur;

public class TestsUnitaires {

    @Test
    public void testLigneHighScoreConstructeurParDefaut() {
        LigneHighScore ligne = new LigneHighScore();
        assertEquals("AAA", ligne.getNom());
        assertEquals(0, ligne.getScore());
    }

    @Test
    public void testLigneHighScoreConstructeurParametre() {
        LigneHighScore ligne = new LigneHighScore("ABC", 100);
        assertEquals("ABC", ligne.getNom());
        assertEquals(100, ligne.getScore());
    }

    @Test
    public void testLigneHighScoreConstructeurParametreNomTropLong() {
        LigneHighScore ligne = new LigneHighScore("ABCD", 100);
        assertEquals("AAA", ligne.getNom());
        assertEquals(100, ligne.getScore());
    }

    @Test
    public void testLigneHighScoreConstructeurParametreScoreNegatif() {
        LigneHighScore ligne = new LigneHighScore("ABC", -10);
        assertEquals("ABC", ligne.getNom());
        assertEquals(0, ligne.getScore());
    }

    @Test
    public void testLigneHighScoreConstructeurCopie() {
        LigneHighScore original = new LigneHighScore("XYZ", 500);
        LigneHighScore copie = new LigneHighScore(original);
        assertEquals("XYZ", copie.getNom());
        assertEquals(500, copie.getScore());
    }

    @Test
    public void testLigneHighScoreConstructeurString() {
        LigneHighScore ligne = new LigneHighScore("ABC-100");
        assertEquals("ABC", ligne.getNom());
        assertEquals(100, ligne.getScore());
    }

    @Test
    public void testLigneHighScoreConstructeurStringInvalide() {
        LigneHighScore ligne = new LigneHighScore("ABC");
        assertEquals("AAA", ligne.getNom());
        assertEquals(0, ligne.getScore());
    }

    @Test
    public void testLigneHighScoreToString() {
        LigneHighScore ligne = new LigneHighScore("DEF", 200);
        assertEquals("DEF-200", ligne.toString());
    }

    @Test
    public void testPommeConstructeur() {
        Point point = new Point(100, 100);
        Pomme pomme = new Pomme(point);
        assertNotNull(pomme.getC());
        assertFalse(pomme.getEtat());
    }

    @Test
    public void testPommeSetEtat() {
        Point point = new Point(100, 100);
        Pomme pomme = new Pomme(point);
        pomme.setEtat(true);
        assertTrue(pomme.getEtat());
    }

    @Test
    public void testNourritureConstructeur() {
        Fenetre fenetre = new Fenetre("Test", 1000, 800);
        Nourriture nourriture = new Nourriture(fenetre);
        assertNotNull(nourriture.getPomme());
        assertFalse(nourriture.getPomme().isEmpty());
    }

    @Test
    public void testNourritureJeu() {
        Fenetre fenetre = new Fenetre("Test", 1000, 800);
        Nourriture nourriture = new Nourriture(fenetre);
        Pomme pomme = nourriture.getPomme().get(0);
        pomme.setEtat(true);
        nourriture.jeu();
        assertEquals(2, nourriture.getPomme().size());
    }

    @Test
    public void testNourritureEffacer() {
        Fenetre fenetre = new Fenetre("Test", 1000, 800);
        Nourriture nourriture = new Nourriture(fenetre);
        assertNotNull(nourriture.getPomme());
        nourriture.effacer();
        assertEquals(1, nourriture.getPomme().size());
    }

    @Test
    public void testNouvellePommePosition() {
        Fenetre fenetre = new Fenetre("Test", 1000, 800);
        Nourriture nourriture = new Nourriture(fenetre);
        Pomme pomme = nourriture.getPomme().get(0);
        Point position = pomme.getC().getPoint();
        assertTrue(position.getX() >= 60 && position.getX() <= 960);
        assertTrue(position.getY() >= 60 && position.getY() <= 700);
    }

    @Test
    public void testCarreConstructeur() {
        Point point = new Point(100, 100);
        Carre carre = new Carre(Couleur.ROUGE, point, 30, true);
        assertNotNull(carre);
    }

    @Test
    public void testLigneHighScoreGetters() {
        LigneHighScore ligne = new LigneHighScore("TEST", 1000);
        assertEquals("TEST", ligne.getNom());
        assertEquals(1000, ligne.getScore());
    }

    @Test
    public void testLigneHighScoreSetters() {
        LigneHighScore ligne = new LigneHighScore();
        ligne.getNom();
        ligne.getScore();
    }

    @Test
    public void testNourritureGetPomme() {
        Fenetre fenetre = new Fenetre("Test", 1000, 800);
        Nourriture nourriture = new Nourriture(fenetre);
        ArrayList<Pomme> pommes = nourriture.getPomme();
        assertNotNull(pommes);
        assertFalse(pommes.isEmpty());
    }

    @Test
    public void testPommeGetC() {
        Point point = new Point(100, 100);
        Pomme pomme = new Pomme(point);
        Carre carre = pomme.getC();
        assertNotNull(carre);
    }

    @Test
    public void testNourritureNouvellePomme() {
        Fenetre fenetre = new Fenetre("Test", 1000, 800);
        Nourriture nourriture = new Nourriture(fenetre);
        int tailleInitiale = nourriture.getPomme().size();
        nourriture.jeu();
        assertTrue(nourriture.getPomme().size() >= tailleInitiale);
    }

    @Test
    public void testLigneHighScoreConstructeurStringAvecSeparateur() {
        LigneHighScore ligne = new LigneHighScore("ABC-100");
        assertEquals("ABC", ligne.getNom());
        assertEquals(100, ligne.getScore());
    }

    @Test
    public void testLigneHighScoreConstructeurStringSansSeparateur() {
        LigneHighScore ligne = new LigneHighScore("ABC");
        assertEquals("AAA", ligne.getNom());
        assertEquals(0, ligne.getScore());
    }

    @Test
    public void testLigneHighScoreConstructeurStringAvecSeparateurInvalide() {
        LigneHighScore ligne = new LigneHighScore("ABC-100-200");
        assertEquals("AAA", ligne.getNom());
        assertEquals(0, ligne.getScore());
    }

    @Test
    public void testLigneHighScoreConstructeurStringAvecScoreInvalide() {
        LigneHighScore ligne = new LigneHighScore("ABC-abc");
        assertEquals("AAA", ligne.getNom());
        assertEquals(0, ligne.getScore());
    }

    @Test
    public void testLigneHighScoreConstructeurStringAvecScoreNegatif() {
        LigneHighScore ligne = new LigneHighScore("ABC--100");
        assertEquals("AAA", ligne.getNom());
        assertEquals(0, ligne.getScore());
    }

    @Test
    public void testLigneHighScoreConstructeurStringAvecNomTropLong() {
        LigneHighScore ligne = new LigneHighScore("ABCD-100");
        assertEquals("AAA", ligne.getNom());
        assertEquals(100, ligne.getScore());
    }

    @Test
    public void testLigneHighScoreConstructeurStringAvecNomVide() {
        LigneHighScore ligne = new LigneHighScore("-100");
        assertEquals("AAA", ligne.getNom());
        assertEquals(100, ligne.getScore());
    }

    @Test
    public void testLigneHighScoreConstructeurStringAvecScoreZero() {
        LigneHighScore ligne = new LigneHighScore("ABC-0");
        assertEquals("ABC", ligne.getNom());
        assertEquals(0, ligne.getScore());
    }

    @Test
    public void testLigneHighScoreConstructeurStringAvecScoreGrand() {
        LigneHighScore ligne = new LigneHighScore("XYZ-999999");
        assertEquals("XYZ", ligne.getNom());
        assertEquals(999999, ligne.getScore());
    }

    // Note : tests tronqués lors de la génération automatique.
}
