import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.BeforeEach;
import static org.junit.jupiter.api.Assertions.*;
import MG2D.geometrie.*;
import java.util.ArrayList;

public class JavaSpaceTests {

    private Bonus bonus1, bonus2;
    private Ennemi ennemi1, ennemi2;
    private Boss boss1;
    private ClavierBorneArcade clavier;
    private Jeu jeu;

    @BeforeEach
    public void setUp() {
        bonus1 = new Bonus();
        bonus2 = new Bonus(new Texture("./img/ennemie/ennemie1/1.png", new Point(0,0)), 1, 100);
        ennemi1 = new Ennemi();
        ennemi2 = new Ennemi(new Texture("./img/ennemie/ennemie1/1.png", new Point(0,0)), 5, 10, 2);
        boss1 = new Boss();
        clavier = new ClavierBorneArcade();
        jeu = new Jeu();
    }

    // Tests Bonus
    @Test
    public void testBonusDefaultConstructor() {
        assertNotNull(bonus1.getTex());
        assertEquals(0, bonus1.getNumBonus());
        assertEquals(0, bonus1.getDuree());
    }

    @Test
    public void testBonusParameterConstructor() {
        assertEquals(1, bonus2.getNumBonus());
        assertEquals(100, bonus2.getDuree());
        assertNotNull(bonus2.getTex());
    }

    @Test
    public void testBonusSetters() {
        bonus1.setNumBonus(5);
        bonus1.setDuree(200);
        assertEquals(5, bonus1.getNumBonus());
        assertEquals(200, bonus1.getDuree());
    }

    @Test
    public void testBonusEquals() {
        Bonus bonus3 = new Bonus(new Texture("./img/ennemie/ennemie1/1.png", new Point(0,0)), 1, 100);
        assertTrue(bonus2.equals(bonus3));
        assertFalse(bonus1.equals(bonus2));
    }

    @Test
    public void testBonusToString() {
        assertNotNull(bonus1.toString());
    }

    // Tests Ennemi
    @Test
    public void testEnnemiDefaultConstructor() {
        assertNotNull(ennemi1.getTex());
        assertEquals(0, ennemi1.getVit());
        assertEquals(0, ennemi1.getVie());
        assertEquals(0, ennemi1.getTraj());
    }

    @Test
    public void testEnnemiParameterConstructor() {
        assertEquals(5, ennemi2.getVit());
        assertEquals(10, ennemi2.getVie());
        assertEquals(2, ennemi2.getTraj());
        assertNotNull(ennemi2.getTex());
    }

    @Test
    public void testEnnemiCopyConstructor() {
        Ennemi ennemiCopy = new Ennemi(ennemi2);
        assertEquals(ennemi2.getVit(), ennemiCopy.getVit());
        assertEquals(ennemi2.getVie(), ennemiCopy.getVie());
        assertEquals(ennemi2.getTraj(), ennemiCopy.getTraj());
        assertTrue(ennemi2.getTex().equals(ennemiCopy.getTex()));
    }

    @Test
    public void testEnnemiSetters() {
        ennemi1.setVit(15);
        ennemi1.setVie(20);
        ennemi1.setTraj(3);
        assertEquals(15, ennemi1.getVit());
        assertEquals(20, ennemi1.getVie());
        assertEquals(3, ennemi1.getTraj());
    }

    @Test
    public void testEnnemiEquals() {
        Ennemi ennemi3 = new Ennemi(new Texture("./img/ennemie/ennemie1/1.png", new Point(0,0)), 5, 10, 2);
        assertTrue(ennemi2.equals(ennemi3));
        assertFalse(ennemi1.equals(ennemi2));
    }

    @Test
    public void testEnnemiToString() {
        assertNotNull(ennemi1.toString());
    }

    // Tests Boss
    @Test
    public void testBossDefaultConstructor() {
        assertNotNull(boss1.getTex());
        assertEquals(0, boss1.getVit());
        assertEquals(0, boss1.getVie());
        assertEquals(0, boss1.getTraj());
    }

    @Test
    public void testBossParameterConstructor() {
        Boss boss2 = new Boss(new Texture("./img/ennemie/boss/0.png", new Point(0,0)), 10, 50, 5);
        assertEquals(10, boss2.getVit());
        assertEquals(50, boss2.getVie());
        assertEquals(5, boss2.getTraj());
        assertNotNull(boss2.getTex());
    }

    @Test
    public void testBossSetters() {
        boss1.setVit(15);
        boss1.setVie(60);
        boss1.setTraj(4);
        assertEquals(15, boss1.getVit());
        assertEquals(60, boss1.getVie());
        assertEquals(4, boss1.getTraj());
    }

    @Test
    public void testBossEquals() {
        Boss boss2 = new Boss(new Texture("./img/ennemie/boss/0.png", new Point(0,0)), 10, 50, 5);
        Boss boss3 = new Boss(new Texture("./img/ennemie/boss/0.png", new Point(0,0)), 10, 50, 5);
        assertTrue(boss2.equals(boss3));
        assertFalse(boss1.equals(boss2));
    }

    @Test
    public void testBossToString() {
        assertNotNull(boss1.toString());
    }

    // Tests ClavierBorneArcade
    @Test
    public void testClavierBorneArcadeConstructor() {
        assertNotNull(clavier);
    }

    // Tests Jeu
    @Test
    public void testJeuConstants() {
        assertEquals(1280, Jeu.LARGEUR);
        assertEquals(1024, Jeu.HAUTEUR);
        assertEquals(1, Jeu.PHASESHOOT);
        assertEquals(2, Jeu.PHASEBOSS);
        assertEquals(50, Jeu.VIEBOSS);
        assertEquals(1500, Jeu.TEMPSPHASE);
    }

    @Test
    public void testJeuConstructor() {
        assertNotNull(jeu);
        assertNotNull(jeu.fen);
        assertNotNull(jeu.cla);
        assertEquals(Jeu.PHASESHOOT, jeu.phase);
    }

    @Test
    public void testJeuGenerateMenu() {
        // Test that menu generation doesn't throw exceptions
        assertDoesNotThrow(() -> jeu.generateMenu());
    }

    // Tests de cas limites
    @Test
    public void testBonusExtremeValues() {
        Bonus extremeBonus = new Bonus(new Texture("./img/ennemie/ennemie1/1.png", new Point(0,0)), Integer.MAX_VALUE, Integer.MAX_VALUE);
        assertEquals(Integer.MAX_VALUE, extremeBonus.getNumBonus());
        assertEquals(Integer.MAX_VALUE, extremeBonus.getDuree());
    }

    @Test
    public void testEnnemiExtremeValues() {
        Ennemi extremeEnnemi = new Ennemi(new Texture("./img/ennemie/ennemie1/1.png", new Point(0,0)), Integer.MAX_VALUE, Integer.MAX_VALUE, Integer.MAX_VALUE);
        assertEquals(Integer.MAX_VALUE, extremeEnnemi.getVit());
        assertEquals(Integer.MAX_VALUE, extremeEnnemi.getVie());
        assertEquals(Integer.MAX_VALUE, extremeEnnemi.getTraj());
    }

    @Test
    public void testJeuInitialization() {
        assertNotNull(jeu.tabEnn);
        assertNotNull(jeu.tabTirJou);
        assertNotNull(jeu.tabTirEnn);
        assertNotNull(jeu.tabBonus);
        assertNotNull(jeu.tabAnimationIntersection);
        assertNotNull(jeu.boss);
    }

    // Tests d'intégration
    @Test
    public void testBonusEnnemiInteraction() {
        // Test that Bonus and Ennemi can coexist in arrays
        ArrayList<Bonus> bonusList = new ArrayList<>();
        ArrayList<Ennemi> ennemiList = new ArrayList<>();
        
        bonusList.add(bonus1);
        bonusList.add(bonus2);
        ennemiList.add(ennemi1);
        ennemiList.add(ennemi2);
        
        assertEquals(2, bonusList.size());
        assertEquals(2, ennemiList.size());
    }

    @Test
    public void testJeuInitializationWithConstants() {
        assertNotNull(Jeu.TEXTIR);
        assertNotNull(Jeu.TEXVAISSEAU);
        assertNotNull(Jeu.TEXBOSS);
        assertNotNull(Jeu.TEXENN);
        assertEquals(4, Jeu.TEXTIR.length);
        assertEquals(4, Jeu.TEXVAISSEAU.length);
        assertEquals(4, Jeu.TEXENN.length);
    }
}
