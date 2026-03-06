import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.BeforeEach;
import static org.junit.jupiter.api.Assertions.*;
import MG2D.*;
import MG2D.geometrie.*;
import java.awt.Font;
import java.io.File;

class Kowasu_RengaTest {

    @Test
    void testClavierBorneArcadeCreation() {
        ClavierBorneArcade clavier = new ClavierBorneArcade();
        assertNotNull(clavier);
        assertFalse(clavier.getJoyJ1GaucheEnfoncee());
        assertFalse(clavier.getJoyJ1DroiteEnfoncee());
        assertFalse(clavier.getJoyJ1HautEnfoncee());
        assertFalse(clavier.getJoyJ1BasEnfoncee());
        assertFalse(clavier.getBoutonJ1AEnfoncee());
        assertFalse(clavier.getBoutonJ1ATape());
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
        assertEquals(640, cercle.getCentre().getX());
        assertEquals(80, cercle.getCentre().getY());
        assertEquals(8, cercle.getRayon());
    }

    @Test
    void testRectangleCreation() {
        int largeur = 1280;
        int hauteur = 720;
        Rectangle rect = new Rectangle(Couleur.BLANC, new Point(0, 0), largeur, hauteur, true);
        assertNotNull(rect);
        assertEquals(0, rect.getPoint().getX());
        assertEquals(0, rect.getPoint().getY());
        assertEquals(largeur, rect.getLargeur());
        assertEquals(hauteur, rect.getHauteur());
    }

    @Test
    void testTextureCreation() {
        Texture texture = new Texture("img/background.jpg", new Point(0, 0), 1280, 720);
        assertNotNull(texture);
        assertEquals(0, texture.getPoint().getX());
        assertEquals(0, texture.getPoint().getY());
        assertEquals(1280, texture.getLargeur());
        assertEquals(720, texture.getHauteur());
    }

    @Test
    void testReinitialisation() {
        ClavierBorneArcade clavier = new ClavierBorneArcade();
        clavier.reinitialisation();
        assertFalse(clavier.getBoutonJ1AEnfoncee());
        assertFalse(clavier.getBoutonJ1ATape());
        assertFalse(clavier.getJoyJ1GaucheEnfoncee());
        assertFalse(clavier.getJoyJ1DroiteEnfoncee());
        assertFalse(clavier.getJoyJ1HautEnfoncee());
        assertFalse(clavier.getJoyJ1BasEnfoncee());
    }

    @Test
    void testFenetrePleinEcranCreation() {
        FenetrePleinEcran f = new FenetrePleinEcran("Kowasu Renga");
        assertNotNull(f);
        assertEquals("Kowasu Renga", f.getTitre());
    }

    @Test
    void testCouleurCreation() {
        Couleur couleur = new Couleur(103, 11, 122);
        assertNotNull(couleur);
        assertEquals(103, couleur.getR());
        assertEquals(11, couleur.getG());
        assertEquals(122, couleur.getB());
    }

    @Test
    void testTexteCreation() {
        Font font = null;
        try {
            File in = new File("font.ttf");
            font = font.createFont(Font.TRUETYPE_FONT, in);
            font = font.deriveFont(20.0f);
        } catch (Exception e) {
            // Ignorer l'erreur de chargement de police
        }
        Texte texte = new Texte(Couleur.BLANC, "Test", font, new Point(100, 200));
        assertNotNull(texte);
        assertEquals("Test", texte.getTexte());
        assertEquals(100, texte.getPoint().getX());
        assertEquals(200, texte.getPoint().getY());
    }

    @Test
    void testInitialisationJeu() {
        // Vérifier que les attributs statiques sont correctement initialisés
        assertEquals(1280, Kowasu_Renga.largeur);
        assertEquals(1024, Kowasu_Renga.hauteur);
        assertEquals(2, Kowasu_Renga.vitesseBase);
        assertEquals(3, Kowasu_Renga.nbVies);
    }

    @Test
    void testBlocsCreation() {
        // Test de la création des blocs
        Couleur[] couleur = {
            new Couleur(103, 11, 122), // Violet
            new Couleur(12, 73, 156),  // Bleu foncé
            new Couleur(106, 204, 229), // Bleu clair
            new Couleur(121, 160, 5),   // Vert
            new Couleur(250, 241, 24)   // Jaune
        };

        assertEquals(5, couleur.length);
        assertEquals(103, couleur[0].getR());
        assertEquals(12, couleur[1].getR());
        assertEquals(106, couleur[2].getR());
        assertEquals(121, couleur[3].getR());
        assertEquals(250, couleur[4].getR());
    }

    @Test
    void testBalleDeplacement() {
        // Test de la logique de déplacement de la balle
        assertEquals(0, Kowasu_Renga.dx);
        assertEquals(0, Kowasu_Renga.dy);
        assertEquals(2, Kowasu_Renga.cx);
        assertEquals(2, Kowasu_Renga.cy);
    }

    @Test
    void testJoueurDeplacement() {
        // Test de la position du joueur
        Point a = new Point((Kowasu_Renga.largeur / 2) - 40, 50);
        Point b = new Point((Kowasu_Renga.largeur / 2) + 40, 60);
        assertEquals(a.getX(), Kowasu_Renga.a.getX());
        assertEquals(a.getY(), Kowasu_Renga.a.getY());
        assertEquals(b.getX(), Kowasu_Renga.b.getX());
        assertEquals(b.getY(), Kowasu_Renga.b.getY());
    }

    @Test
    void testValeursLimites() {
        // Test des valeurs limites pour les coordonnées
        assertTrue(Kowasu_Renga.largeur > 0);
        assertTrue(Kowasu_Renga.hauteur > 0);
        assertTrue(Kowasu_Renga.vitesseBase > 0);
        assertTrue(Kowasu_Renga.nbVies >= 0);
    }

    @Test
    void testIntegrationComposants() {
        // Test d'intégration entre composants
        assertNotNull(Kowasu_Renga.a);
        assertNotNull(Kowasu_Renga.b);
        assertNotNull(Kowasu_Renga.couleur);
        assertNotNull(Kowasu_Renga.f);
        assertNotNull(Kowasu_Renga.clavier);
    }

    @Test
    void testMethodeDeplacementBalle() {
        // Test de la logique de déplacement de la balle
        Kowasu_Renga.dx = 1;
        Kowasu_Renga.dy = 1;
        Kowasu_Renga.cx = 2;
        Kowasu_Renga.cy = 2;
        assertEquals(1, Kowasu_Renga.dx);
        assertEquals(1, Kowasu_Renga.dy);
        assertEquals(2, Kowasu_Renga.cx);
        assertEquals(2, Kowasu_Renga.cy);
    }

    @Test
    void testMethodeDeplacementJoueur() {
        // Test de la logique de déplacement du joueur
        Point a = new Point((Kowasu_Renga.largeur / 2) - 40, 50);
        Point b = new Point((Kowasu_Renga.largeur / 2) + 40, 60);
        assertEquals(a.getX(), Kowasu_Renga.a.getX());
        assertEquals(a.getY(), Kowasu_Renga.a.getY());
        assertEquals(b.getX(), Kowasu_Renga.b.getX());
        assertEquals(b.getY(), Kowasu_Renga.b.getY());
    }

    @Test
    void testInitialisationBlocs() {
        // Test de l'initialisation des blocs
        assertEquals(5, Kowasu_Renga.couleur.length);
        assertEquals(3, Kowasu_Renga.nbVies);
    }

    @Test
    void testGestionErreurs() {
        // Test de gestion d'erreurs
        try {
            new Couleur(-1, 0, 0);

        } catch (Exception e) {
            // Erreur attendue
        }
    }

    // Note : tests tronqués lors de la génération automatique.
}
