import org.junit.jupiter.api.Test;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import static org.junit.jupiter.api.Assertions.assertTrue;

class GameAssetsTest {
    private static final List<String> GAMES = Arrays.asList(
            "Columns",
            "CursedWare",
            "DinoRail",
            "InitialDrift",
            "JavaSpace",
            "Kowasu_Renga",
            "Minesweeper",
            "OsuTile",
            "PianoTile",
            "Pong",
            "Puissance_X",
            "Snake_Eater",
            "TronGame",
            "ball-blast"
    );

    private static final Set<String> GAMES_WITHOUT_PREVIEW = new HashSet<>(Arrays.asList(
            "Puissance_X"
    ));

    @Test
    void gameFoldersHaveCoreFiles() {
        Path projet = Paths.get("projet");
        assertTrue(Files.isDirectory(projet), "Missing projet directory");

        for (String game : GAMES) {
            Path gameDir = projet.resolve(game);
            assertTrue(Files.isDirectory(gameDir), "Missing game dir: " + game);
            assertTrue(Files.isRegularFile(gameDir.resolve("bouton.txt")), "Missing bouton.txt for " + game);
            assertTrue(Files.isRegularFile(gameDir.resolve("description.txt")), "Missing description.txt for " + game);

            if (!GAMES_WITHOUT_PREVIEW.contains(game)) {
                assertTrue(Files.isRegularFile(gameDir.resolve("photo_small.png")), "Missing photo_small.png for " + game);
            }
        }
    }
}
