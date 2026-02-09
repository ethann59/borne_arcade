import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import MG2D.geometrie.Point;
import MG2D.geometrie.Rectangle;
import MG2D.geometrie.Texture;


public class BoiteImage extends Boite{

    Texture image;

    BoiteImage(Rectangle rectangle, String image) {
	super(rectangle);
	this.image = new Texture(resolvePreviewPath(image), new Point(760, 648));
    }

    public Texture getImage() {
	return this.image;
    }

    public void setImage(String chemin) {
    this.image.setImg(resolvePreviewPath(chemin));
    //this.image.setTaille(400, 320);
    }

    private static String resolvePreviewPath(String basePath) {
    Path preview = Paths.get(basePath, "photo_small.png");
    if (Files.isRegularFile(preview)) {
        return preview.toString();
    }
    return Paths.get("img", "bouton2.png").toString();
    }

}
