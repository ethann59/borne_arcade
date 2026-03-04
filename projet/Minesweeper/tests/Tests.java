import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;
import MG2D.geometrie.Texture;
import java.util.ArrayList;

class BasicTest {

    private Basic basic;

    @BeforeEach
    void setUp() {
        basic = new Basic();
    }

    @Test
    void testGetWidth() {
        assertEquals(Constants.width, basic.getWidth());
    }

    @Test
    void testGetHeight() {
        assertEquals(Constants.height, basic.getHeight());
    }

    @Test
    void testGetNbBombs() {
        assertEquals(Constants.nbBombs, basic.getNbBombs());
    }

    @Test
    void testGetSizeTile() {
        assertEquals(Constants.sizeTile, basic.getSizeTile());
    }

    @Test
    void testGetWidthWindow() {
        assertEquals(Constants.screenWidth, basic.getWidthWindow());
    }

    @Test
    void testGetHeightWindow() {
        assertEquals(Constants.screenHeight, basic.getHeightWindow());
    }
}

class BoardTest {

    private Board board;

    @BeforeEach
    void setUp() {
        board = new Board(9, 9, 10);
    }

    @Test
    void testGetWidth() {
        assertEquals(9, board.getWidth());
    }

    @Test
    void testGetHeight() {
        assertEquals(9, board.getHeight());
    }

    @Test
    void testGetNbBombs() {
        assertEquals(10, board.getNbBombs());
    }

    @Test
    void testGetTiles() {
        assertEquals(81, board.getTiles().size());
    }

    @Test
    void testGetDiscoveredTiles() {
        assertEquals(0, board.getDiscoveredTiles().size());
    }

    @Test
    void testAddDiscoveredTile() {
        board.addDiscoveredTile(board.getTiles().get(0));
        assertEquals(1, board.getDiscoveredTiles().size());
    }

    @Test
    void testClearDiscoveredTiles() {
        board.addDiscoveredTile(board.getTiles().get(0));
        board.clearDiscoveredTiles();
        assertEquals(0, board.getDiscoveredTiles().size());
    }

    @Test
    void testGetCase() {
        Tile c = board.getCase(0, 0);
        assertNotNull(c);
        assertEquals(0, c.getX());
        assertEquals(0, c.getY());
    }

    @Test
    void testNeighbourhood() {
        board.neighbourhood();
        assertNotNull(board.getTiles());
    }

    @Test
    void testEndGameMine() {
        assertFalse(board.endGameMine());
    }

    @Test
    void testEndGameWin() {
        assertFalse(board.endGameWin());
    }
}

class BombTest {

    private Board board;
    private Bomb bomb;

    @BeforeEach
    void setUp() {
        board = new Board(9, 9, 10);
        bomb = new Bomb(0, 0);
    }

    @Test
    void testGetMasked() {
        assertTrue(bomb.getMasked());
    }

    @Test
    void testGetFlag() {
        assertFalse(bomb.getFlag());
    }

    @Test
    void testGetX() {
        assertEquals(0, bomb.getX());
    }

    @Test
    void testGetY() {
        assertEquals(0, bomb.getY());
    }

    @Test
    void testSetMasked() {
        bomb.setMasked(false);
        assertFalse(bomb.getMasked());
    }

    @Test
    void testSetFlag() {
        bomb.setFlag(true);
        assertTrue(bomb.getFlag());
    }

    @Test
    void testSwitchFlag() {
        bomb.setFlag(true);
        bomb.switchFlag(board);
        assertFalse(bomb.getFlag());
    }

    @Test
    void testDiscover() {
        bomb.discover(board);
        assertTrue(bomb.getMasked());
    }
}
