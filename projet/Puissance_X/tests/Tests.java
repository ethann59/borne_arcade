import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class ConfigurationPartieTest {

    @Test
    void testDefaultConfiguration() {
        ConfigurationPartie config = new ConfigurationPartie();
        assertEquals(7, config.getNbColonnes());
        assertEquals(6, config.getNbLignes());
        assertEquals(4, config.getNbPuissance());
    }

    @Test
    void testCustomConfigurationLignesColonnes() {
        ConfigurationPartie config = new ConfigurationPartie(8, 9);
        assertEquals(9, config.getNbColonnes());
        assertEquals(8, config.getNbLignes());
    }

    @Test
    void testCustomConfigurationAvecPuissance() {
        ConfigurationPartie config = new ConfigurationPartie(8, 9, 5);
        assertEquals(9, config.getNbColonnes());
        assertEquals(8, config.getNbLignes());
        assertEquals(5, config.getNbPuissance());
    }

    @Test
    void testCopyConfiguration() {
        ConfigurationPartie config1 = new ConfigurationPartie(5, 6, 2);
        ConfigurationPartie config2 = new ConfigurationPartie(config1);
        assertEquals(config1.getNbColonnes(), config2.getNbColonnes());
        assertEquals(config1.getNbLignes(), config2.getNbLignes());
        assertEquals(config1.getNbPuissance(), config2.getNbPuissance());
    }

    @Test
    void testEstValideDefault() {
        ConfigurationPartie config = new ConfigurationPartie();
        assertFalse(config.estValide());
    }

    @Test
    void testGetNbJoueurs() {
        ConfigurationPartie config = new ConfigurationPartie();
        assertTrue(config.getNbJoueurs() >= 0);
    }
}
