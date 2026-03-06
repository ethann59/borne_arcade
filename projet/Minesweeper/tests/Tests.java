```java
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.BeforeEach;
import static org.junit.jupiter.api.Assertions.*;
import java.util.ArrayList;
import java.util.Arrays;

public class MinesweeperTests {

    @Test
    public void testBasicLevelInitialization() {
        Basic basic = new Basic();
        assertEquals(Constants.width, basic.getWidth());
        assertEquals(Constants.height, basic.getHeight());
        assertEquals(Constants.nbBombs, basic.getNbBombs());
        assertEquals(Constants.sizeTile, basic.getSizeTile());
        assertEquals(Constants.screenWidth, basic.getWidthWindow());
        assertEquals(Constants.screenHeight, basic.getHeightWindow());
    }

    @Test
    public void testBasicOnClickReturnsMinesweeperView() {
        Basic basic = new Basic();
        assertNotNull(basic.onClick());
    }

    @Test
    public void testBoardInitialization() {
        int width = 10;
        int height = 10;
        int nbBombs = 15;
        Board board = new Board(width, height, nbBombs);

        assertEquals(width, board.getWidth());
        assertEquals(height, board.getHeight());
        assertEquals(nbBombs, board.getNbBombs());
        assertEquals(width * height, board.getTiles().size());
    }

    @Test
    public void testBoardGetCase() {
        Board board = new Board(5, 5, 5);
        Tile tile = board.getCase(2, 3);
        assertNotNull(tile);
        assertEquals(2, tile.getX());
        assertEquals(3, tile.getY());
    }

    @Test
    public void testBoardGetCaseOutOfBounds() {
        Board board = new Board(5, 5, 5);
        Tile tile = board.getCase(10, 10);
        assertNull(tile);
    }

    @Test
    public void testBombInitialization() {
        Bomb bomb = new Bomb(3, 4);
        assertTrue(bomb.getMasked());
        assertFalse(bomb.getFlag());
        assertEquals(3, bomb.getX());
        assertEquals(4, bomb.getY());
    }

    @Test
    public void testBombInitializationWithAllParameters() {
        Bomb bomb = new Bomb(1, 2, false, true);
        assertFalse(bomb.getMasked());
        assertTrue(bomb.getFlag());
        assertEquals(1, bomb.getX());
        assertEquals(2, bomb.getY());
    }

    @Test
    public void testBombDiscover() {
        Bomb bomb = new Bomb(1, 1);
        bomb.discover(null);
        assertFalse(bomb.getMasked());
    }

    @Test
    public void testBombSwitchFlag() {
        Bomb bomb = new Bomb(1, 1);
        bomb.switchFlag(null);
        assertTrue(bomb.getFlag());
        bomb.switchFlag(null);
        assertFalse(bomb.getFlag());
    }

    @Test
    public void testBombDisplay() {
        Bomb bomb = new Bomb(1, 1);
        bomb.setMasked(true);
        bomb.setFlag(true);
        // Test output would require capturing System.out
        // For now, just ensure method doesn't throw exception
        assertDoesNotThrow(() -> bomb.display());
    }

    @Test
    public void testBombNeighbour() {
        Bomb bomb = new Bomb(1, 1);
        assertEquals(0, bomb.neighbour(null));
    }

    @Test
    public void testBombAddNeighbour() {
        Bomb bomb = new Bomb(1, 1);
        assertEquals(1, bomb.addNeighbour());
    }

    @Test
    public void testBombEndGameMine() {
        Bomb bomb = new Bomb(1, 1);
        assertTrue(bomb.endGameMine());
        bomb.setMasked(false);
        assertFalse(bomb.endGameMine());
    }

    @Test
    public void testBombEndGameWin() {
        Bomb bomb = new Bomb(1, 1);
        assertFalse(bomb.endGameWin());
        bomb.setMasked(false);
        assertTrue(bomb.endGameWin());
    }

    @Test
    public void testBoardAction() {
        Board board = new Board(5, 5, 5);
        int sizeTile = 32;
        Button button = new Button() {
            @Override
            public void display() {}
            @Override
            public void actionButton(Tile c, Board board) {
                c.discover(board);
            }
            @Override
            public Texture selection(int sizeTile, int width, int height) {
                return null;
            }
        };
        board.action(32, 32, button, sizeTile);
        // Verify that a tile was discovered
        assertFalse(board.getDiscoveredTiles().isEmpty());
    }

    @Test
    public void testBoardEndGameMine() {
        Board board = new Board(5, 5, 5);
        assertFalse(board.endGameMine());
    }

    @Test
    public void testBoardEndGameWin() {
        Board board = new Board(5, 5, 5);
        assertFalse(board.endGameWin());
    }

    @Test
    public void testBoardNeighbourhood() {
        Board board = new Board(5, 5, 5);
        assertDoesNotThrow(() -> board.neighbourhood());
    }

    @Test
    public void testClassicThemeToString() {
        Classic classic = new Classic();
        assertEquals("classic", classic.toString());
    }

    @Test
    public void testClassicThemeGetBomb() {
        Classic classic = new Classic();
        assertEquals("classic/Minesweeper_bomb.png", classic.getBomb());
    }

    @Test
    public void testClassicThemeGetFlag() {
        Classic classic = new Classic();
        assertEquals("classic/Minesweeper_flag.png", classic.getFlag());
    }

    @Test
    public void testClassicThemeGetFlagTrue() {
        Classic classic = new Classic();
        assertEquals("classic/Minesweeper_flag.png", classic.getFlagTrue());
    }

    @Test
    public void testClassicThemeGetDig() {
        Classic classic = new Classic();
        assertEquals("classic/Minesweeper_questionmark.png", classic.getDig());
    }

    @Test
    public void testClassicThemeGetDigTrue() {
        Classic classic = new Classic();
        assertEquals("classic/Minesweeper_questionmark.png", classic.getDigTrue());
    }

    @Test
    public void testClassicThemeGetTileMasked() {
        Classic classic = new Classic();
        assertEquals("classic/Minesweeper_unopened_square.png", classic.getTileMasked());
    }

    @Test
    public void testClassicThemeGetTileDiscovered() {
        Classic classic = new Classic();
        assertEquals("classic/Minesweeper_0.png", classic.getTileDiscovered(0));
        assertEquals("classic/Minesweeper_3.png", classic.getTileDiscovered(3));
    }

    @Test
    public void testClassicThemeGetQuit() {
        Classic classic = new Classic();
        assertEquals("classic/Minesweeper_cross.png", classic.getQuit());
    }

    @Test
    public void testClassicThemeGetRestart() {
        Classic classic = new Classic();
        assertEquals("classic/Minesweeper_arrow.png", classic.getRestart());
    }

    @Test
    public void testClassicThemeGetBackground() {
        Classic classic = new Classic();
        assertEquals("assets/classic/Minesweeper_background.png", classic.getBackground());
    }

    @Test
    public void testClassicThemeGetWin() {
        Classic classic = new Classic();
        assertEquals("classic/Minesweeper_win.png", classic.getWin());
    }

    @Test
    public void testClassicThemeGetLose() {
        Classic classic = new Classic();
        assertEquals("classic/Minesweeper_lose.png", classic.getLose());
    }

    @Test
    public void testClassicThemeGetLevelEasy() {
        Classic classic = new Classic();
        assertEquals("classic/Level_easy.png", classic.getLevelEasy());
    }

    @Test
    public void testClassicThemeGetLevelMedium() {
        Classic classic = new Classic();
        assertEquals("classic/Level_medium.png", classic.getLevelMedium());
    }

    @Test
    public void testClassicThemeGetLevelHard() {
        Classic classic = new Classic();
        assertEquals("classic/Level_hard.png", classic.getLevelHard());
    }

    @Test
    public void testBoardWithZeroBombs() {
        Board board = new Board(5, 5, 0);
        assertEquals(0, board.getNbBombs());
        assertEquals(25, board.getTiles().size());
    }

    @Test
    public void testBoardWithMaxBombs() {
        Board board = new Board(5, 5, 25);
        assertEquals(25, board.getNbBombs());
        assertEquals(25, board.getTiles().size());
    }

    @Test
    public void testBoardWithMoreBombsThanTiles() {
        Board board = new Board(3, 3, 10);
        assertEquals(10, board.getNbBombs());
        assertEquals(9, board.getTiles().size());
    }

    @Test
    public void testBoardAddToDiscoveredTiles() {
        Board board = new Board(5, 5, 5);
        Tile tile = board.getTiles().get(0);
        board.getDiscoveredTiles().add(tile);
        assertEquals(1, board.getDiscoveredTiles().size());
    }

    @Test
    public void testEmptyBoard() {
        Board board = new Board(0, 0, 0);
        assertEquals(0, board.getNbBombs());
        assertEquals(0, board.getTiles().size());
    }

    // Note : tests tronqués lors de la génération automatique.
}
