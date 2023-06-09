import 'dart:io';
import 'package:image/image.dart' as img;

class ErosionImage{
  File? applyErosion(File? imageFile) {
    if (imageFile == null) {
      return null;
    }

    final bytes = imageFile.readAsBytesSync();
    final image = img.decodeImage(bytes);

    if (image == null) {
      return null;
    }

    final width = image.width;
    final height = image.height;
    final erodedImage = img.Image(width, height);

    for (var y = 0; y < height; y++) {
      for (var x = 0; x < width; x++) {
        final pixel = image.getPixel(x, y);
        final alpha = img.getAlpha(pixel);
        final red = img.getRed(pixel);
        final green = img.getGreen(pixel);
        final blue = img.getBlue(pixel);

        if (red == 0 && green == 0 && blue == 0 &&
            img.getRed(image.getPixel(x - 1, y)) == 0 &&
            img.getRed(image.getPixel(x + 1, y)) == 0 &&
            img.getRed(image.getPixel(x, y - 1)) == 0 &&
            img.getRed(image.getPixel(x, y + 1)) == 0) {
          erodedImage.setPixel(x, y, img.getColor(0, 0, 0, alpha));
        } else {
          erodedImage.setPixel(x, y, img.getColor(255, 255, 255, alpha));
        }
      }
    }
    final tempDir = Directory.systemTemp;
    final tempPath = '${tempDir.path}/smoothed_image.png';

    final outputBytes = img.encodePng(erodedImage);
    final outputFile = File(tempPath);
    outputFile.writeAsBytesSync(outputBytes);

    return outputFile;
  }
}
