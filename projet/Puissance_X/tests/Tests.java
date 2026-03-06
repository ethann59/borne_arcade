```java
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.BeforeEach;
import static org.junit.jupiter.api.Assertions.*;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.util.ArrayList;

public class PuissanceXTests {

    private Graphics2D mockGraphics;
    private Entree mockEntree;

    @BeforeEach
    void setUp() {
        BufferedImage image = new BufferedImage(800, 600, BufferedImage.TYPE_INT_ARGB);
        mockGraphics = image.createGraphics();
        mockEntree = new Entree() {
            @Override
            public boolean haut(int dureeTouche) { return false; }
            @Override
            public boolean bas(int dureeTouche) { return false; }
            @Override
            public boolean gauche(int dureeTouche) { return false; }
            @Override
            public boolean droite(int dureeTouche) { return false; }
            @Override
            public boolean entree(int dureeTouche) { return false; }
        };
    }

    // Tests pour Case
    @Test
    void testCaseConstructeur() {
        Case c = new Case();
        assertEquals(0, c.getColonne());
        assertEquals(0, c.getLigne());
        assertFalse(c.estOccupee());
    }

    @Test
    void testCaseConstructeurAvecParametres() {
        Case c = new Case(2, 3);
        assertEquals(2, c.getColonne());
        assertEquals(3, c.getLigne());
        assertFalse(c.estOccupee());
    }

    @Test
    void testCaseOccuper() {
        Case c = new Case();
        c.occuper(new Joueur("Test", Color.RED));
        assertTrue(c.estOccupee());
        assertEquals("Test", c.getJoueur().getNom());
    }

    @Test
    void testCaseLibere() {
        Case c = new Case();
        c.occuper(new Joueur("Test", Color.RED));
        c.libere();
        assertFalse(c.estOccupee());
    }

    // Tests pour ConfigurationPartie
    @Test
    void testConfigurationPartieConstructeurParDefaut() {
        ConfigurationPartie config = new ConfigurationPartie();
        assertEquals(6, config.getNbLignes());
        assertEquals(7, config.getNbColonnes());
        assertEquals(4, config.getNbPuissance());
        assertEquals(0, config.getNbJoueurs());
    }

    @Test
    void testConfigurationPartieConstructeurAvecParametres() {
        ConfigurationPartie config = new ConfigurationPartie(5, 6, 3);
        assertEquals(5, config.getNbLignes());
        assertEquals(6, config.getNbColonnes());
        assertEquals(3, config.getNbPuissance());
        assertEquals(0, config.getNbJoueurs());
    }

    @Test
    void testConfigurationPartieConstructeurCopie() {
        ConfigurationPartie original = new ConfigurationPartie(5, 6, 3);
        original.ajouterJoueur(new Joueur("Joueur1", Color.RED));
        ConfigurationPartie copie = new ConfigurationPartie(original);
        assertEquals(5, copie.getNbLignes());
        assertEquals(6, copie.getNbColonnes());
        assertEquals(3, copie.getNbPuissance());
        assertEquals(1, copie.getNbJoueurs());
    }

    @Test
    void testConfigurationPartieEstValide() {
        ConfigurationPartie config = new ConfigurationPartie();
        assertFalse(config.estValide());
        config.ajouterJoueur(new Joueur("Joueur1", Color.RED));
        assertFalse(config.estValide());
        config.ajouterJoueur(new Joueur("Joueur2", Color.BLUE));
        assertTrue(config.estValide());
    }

    @Test
    void testConfigurationPartieGestionJoueurs() {
        ConfigurationPartie config = new ConfigurationPartie();
        Joueur joueur1 = new Joueur("Joueur1", Color.RED);
        Joueur joueur2 = new Joueur("Joueur2", Color.BLUE);
        config.ajouterJoueur(joueur1);
        config.ajouterJoueur(joueur2);
        assertEquals(2, config.getNbJoueurs());
        assertEquals(joueur1, config.getJoueur(1));
        assertEquals(joueur2, config.getJoueur(2));
        config.retirerJoueur(joueur1);
        assertEquals(1, config.getNbJoueurs());
    }

    // Tests pour ConfigurationJoueurMenu
    @Test
    void testConfigurationJoueurMenuConstructeur() {
        ConfigurationJoueurMenu menu = new ConfigurationJoueurMenu(Color.RED);
        assertEquals(50, menu.getHauteur());
        assertNotNull(menu.nomJoueurActuel);
        assertEquals("Aucun", menu.nomJoueurActuel.getTexte());
        assertEquals(0, menu.getType());
    }

    @Test
    void testConfigurationJoueurMenuSetSelectionne() {
        ConfigurationJoueurMenu menu = new ConfigurationJoueurMenu(Color.RED);
        menu.setSelectionne(true);
        assertTrue(menu.nomJoueurActuel.estGras());
        menu.setSelectionne(false);
        assertFalse(menu.nomJoueurActuel.estGras());
    }

    @Test
    void testConfigurationJoueurMenuMettreAJour() {
        ConfigurationJoueurMenu menu = new ConfigurationJoueurMenu(Color.RED);
        // Simuler basEnfonce = true
        Entree mockEntreeBas = new Entree() {
            @Override
            public boolean haut(int dureeTouche) { return false; }
            @Override
            public boolean bas(int dureeTouche) { return true; }
            @Override
            public boolean gauche(int dureeTouche) { return false; }
            @Override
            public boolean droite(int dureeTouche) { return false; }
            @Override
            public boolean entree(int dureeTouche) { return false; }
        };
        menu.mettreAJour(mockEntreeBas);
        assertEquals(1, menu.getType());
        assertEquals("Joueur normal", menu.nomJoueurActuel.getTexte());
    }

    // Tests pour BoutonItem (abstrait)
    // Pas de tests spécifiques car c'est une classe abstraite

    // Tests pour TexteItem
    @Test
    void testTexteItemConstructeur() {
        TexteItem item = new TexteItem("Test", "Monospaced", 20);
        assertEquals("Test", item.getTexte());
        assertEquals("Monospaced", item.getFont());
        assertEquals(20, item.taillePolice);
    }

    @Test
    void testTexteItemSetters() {
        TexteItem item = new TexteItem("Test", "Monospaced", 20);
        item.setTexte("Nouveau texte");
        item.setFont("Arial");
        item.setTaillePolice(15);
        assertEquals("Nouveau texte", item.getTexte());
        assertEquals("Arial", item.getFont());
        assertEquals(15, item.taillePolice);
    }

    // Tests pour Menu
    @Test
    void testMenuConstructeur() {
        Menu menu = new Menu(50);
        assertEquals(50, menu.getHauteur());
        assertEquals(0, menu.getNbElements());
    }

    @Test
    void testMenuAjoutElement() {
        Menu menu = new Menu(50);
        TexteItem item = new TexteItem("Test", "Monospaced", 20);
        menu.ajouter(item);
        assertEquals(1, menu.getNbElements());
        assertEquals(item, menu.getElement(0));
    }

    @Test
    void testMenuAjoutEspaceVide() {
        Menu menu = new Menu(50);
        menu.ajouterEspaceVide();
        assertEquals(1, menu.getNbElements());
        assertTrue(menu.getElement(0) instanceof TexteItem);
    }

    @Test
    void testMenuSelectionner() {
        Menu menu = new Menu(50);
        TexteItem item1 = new TexteItem("Item1", "Monospaced", 20);
        TexteItem item2 = new TexteItem("Item2", "Monospaced", 20);
        menu.ajouter(item1);
        menu.ajouter(item2);
        menu.selectionner(1);
        assertEquals(1, menu.getIndiceSelection());
    }

    // Tests pour Joueur
    @Test
    void testJoueurConstructeur() {
        Joueur joueur = new Joueur("Test", Color.RED);
        assertEquals("Test", joueur.getNom());
        assertEquals(Color.RED, joueur.getCouleur());
        assertEquals(0, joueur.getNbVictoires());
    }

    @Test
    void testJoueurIncrementerVictoire() {
        Joueur joueur = new Joueur("Test", Color.RED);
        joueur.incrementerVictoire();
        assertEquals(1, joueur.getNbVictoires());
        joueur.incrementerVictoire();
        assertEquals(2, joueur.getNbVictoires());
    }

    @Test
    void testJoueurGetType() {
        Joueur joueur = new Joueur("Test", Color.RED);
        assertEquals(0, joueur.getType());
        joueur.setType(3);
        assertEquals(3, joueur.getType());
    }

    // Note : tests tronqués lors de la génération automatique.
}
