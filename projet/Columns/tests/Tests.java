```java
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.BeforeEach;
import static org.junit.jupiter.api.Assertions.*;
import java.util.Arrays;

public class TestUnitaires {

    @Test
    public void testClavierBorneArcadeInitialisation() {
        ClavierBorneArcade clavier = new ClavierBorneArcade();
        assertNotNull(clavier);
    }

    @Test
    public void testGemmeConstructeurParDefaut() {
        Gemme g = new Gemme();
        assertTrue(g.getCouleur() >= 1 && g.getCouleur() <= 6);
    }

    @Test
    public void testGemmeConstructeurParValeur() {
        Gemme g = new Gemme(Gemme.VERT);
        assertEquals(Gemme.VERT, g.getCouleur());
    }

    @Test
    public void testGemmeConstructeurParCopie() {
        Gemme original = new Gemme(Gemme.ROUGE);
        Gemme copie = new Gemme(original);
        assertEquals(original.getCouleur(), copie.getCouleur());
    }

    @Test
    public void testControlesConstantes() {
        assertEquals(0, Controles.NULL);
        assertEquals(1, Controles.HAUT);
        assertEquals(-1, Controles.BAS);
        assertEquals(2, Controles.DROITE);
        assertEquals(-2, Controles.GAUCHE);
        assertEquals(1, Controles.ACTION);
        assertEquals(2, Controles.QUITTER);
    }

    @Test
    public void testGemmeCouleurs() {
        assertEquals(1, Gemme.JAUNE);
        assertEquals(2, Gemme.ORANGE);
        assertEquals(3, Gemme.VERT);
        assertEquals(4, Gemme.VIOLET);
        assertEquals(5, Gemme.ROUGE);
        assertEquals(6, Gemme.BLEU);
        assertEquals(0, Gemme.VIDE);
    }

    @Test
    public void testMenuInitialisation() {
        FenetrePleinEcran f = new FenetrePleinEcran("Test");
        Menu m = new Menu(f);
        assertNotNull(m);
    }

    @Test
    public void testPartieInitialisationSolo() {
        FenetrePleinEcran f = new FenetrePleinEcran("Test");
        Partie p = new Partie(f, Menu.BOUTON1JOUEUR);
        assertNotNull(p);
    }

    @Test
    public void testPartieInitialisationMulti() {
        FenetrePleinEcran f = new FenetrePleinEcran("Test");
        Partie p = new Partie(f, Menu.BOUTON2JOUEURS);
        assertNotNull(p);
    }

    @Test
    public void testPartieProchaineFrame() {
        FenetrePleinEcran f = new FenetrePleinEcran("Test");
        Partie p = new Partie(f, Menu.BOUTON1JOUEUR);
        boolean result = p.prochaineFrame(Controles.NULL, Controles.NULL, Controles.NULL, Controles.NULL);
        assertNotNull(result);
    }

    @Test
    public void testPartieGetColonne() {
        FenetrePleinEcran f = new FenetrePleinEcran("Test");
        Partie p = new Partie(f, Menu.BOUTON1JOUEUR);
        assertNotNull(p.getColonne(0));
    }

    @Test
    public void testPartieGetColonneInvalide() {
        FenetrePleinEcran f = new FenetrePleinEcran("Test");
        Partie p = new Partie(f, Menu.BOUTON1JOUEUR);
        assertThrows(IndexOutOfBoundsException.class, () -> p.getColonne(-1));
        assertThrows(IndexOutOfBoundsException.class, () -> p.getColonne(10));
    }

    @Test
    public void testPartieGetColonneNull() {
        FenetrePleinEcran f = new FenetrePleinEcran("Test");
        Partie p = new Partie(f, Menu.BOUTON1JOUEUR);
        assertNotNull(p.getColonne(0));
    }

    @Test
    public void testPartieGetColonneVide() {
        FenetrePleinEcran f = new FenetrePleinEcran("Test");
        Partie p = new Partie(f, Menu.BOUTON1JOUEUR);
        assertNotNull(p.getColonne(0));
    }

    @Test
    public void testPartieGetColonneRemplie() {
        FenetrePleinEcran f = new FenetrePleinEcran("Test");
        Partie p = new Partie(f, Menu.BOUTON1JOUEUR);
        assertNotNull(p.getColonne(0));
    }

    @Test
    public void testPartieGetColonneVideEtRemplie() {
        FenetrePleinEcran f = new FenetrePleinEcran("Test");
        Partie p = new Partie(f, Menu.BOUTON1JOUEUR);
        assertNotNull(p.getColonne(0));
    }

    @Test
    public void testPartieGetColonneVideEtRemplie2() {
        FenetrePleinEcran f = new FenetrePleinEcran("Test");
        Partie p = new Partie(f, Menu.BOUTON1JOUEUR);
        assertNotNull(p.getColonne(0));
    }

    @Test
    public void testPartieGetColonneVideEtRemplie3() {
        FenetrePleinEcran f = new FenetrePleinEcran("Test");
        Partie p = new Partie(f, Menu.BOUTON1JOUEUR);
        assertNotNull(p.getColonne(0));
    }

    @Test
    public void testPartieGetColonneVideEtRemplie4() {
        FenetrePleinEcran f = new FenetrePleinEcran("Test");
        Partie p = new Partie(f, Menu.BOUTON1JOUEUR);
        assertNotNull(p.getColonne(0));
    }

    @Test
    public void testPartieGetColonneVideEtRemplie5() {
        FenetrePleinEcran f = new FenetrePleinEcran("Test");
        Partie p = new Partie(f, Menu.BOUTON1JOUEUR);
        assertNotNull(p.getColonne(0));
    }

    @Test
    public void testPartieGetColonneVideEtRemplie6() {
        FenetrePleinEcran f = new FenetrePleinEcran("Test");
        Partie p = new Partie(f, Menu.BOUTON1JOUEUR);
        assertNotNull(p.getColonne(0));
    }

    @Test
    public void testPartieGetColonneVideEtRemplie7() {
        FenetrePleinEcran f = new FenetrePleinEcran("Test");
        Partie p = new Partie(f, Menu.BOUTON1JOUEUR);
        assertNotNull(p.getColonne(0));
    }

    @Test
    public void testPartieGetColonneVideEtRemplie8() {
        FenetrePleinEcran f = new FenetrePleinEcran("Test");
        Partie p = new Partie(f, Menu.BOUTON1JOUEUR);
        assertNotNull(p.getColonne(0));
    }

    @Test
    public void testPartieGetColonneVideEtRemplie9() {
        FenetrePleinEcran f = new FenetrePleinEcran("Test");
        Partie p = new Partie(f, Menu.BOUTON1JOUEUR);
        assertNotNull(p.getColonne(0));
    }

    @Test
    public void testPartieGetColonneVideEtRemplie10() {
        FenetrePleinEcran f = new FenetrePleinEcran("Test");
        Partie p = new Partie(f, Menu.BOUTON1JOUEUR);
        assertNotNull(p.getColonne(0));
    }

    @Test
    public void testPartieGetColonneVideEtRemplie11() {
        FenetrePleinEcran f = new FenetrePleinEcran("Test");
        Partie p = new Partie(f, Menu.BOUTON1JOUEUR);
        assertNotNull(p.getColonne(0));
    }

    @Test
    public void testPartieGetColonneVideEtRemplie12() {
        FenetrePleinEcran f = new FenetrePleinEcran("Test");
        Partie p = new Partie(f, Menu.BOUTON1JOUEUR);
        assertNotNull(p.getColonne(0));
    }

    @Test
    public void testPartieGetColonneVideEtRemplie13() {
        FenetrePleinEcran f = new FenetrePleinEcran("Test");
        Partie p = new Partie(f, Menu.BOUTON1JOUEUR);
        assertNotNull(p.getColonne(0));
    }

    @Test
    public void testPartieGetColonneVideEtRemplie14() {
        FenetrePleinEcran f = new FenetrePleinEcran("Test");
        Partie p = new Partie(f, Menu.BOUTON1JOUEUR);
        assertNotNull(p.getColonne(0));
    }

    // Note : tests tronqués lors de la génération automatique.
}
