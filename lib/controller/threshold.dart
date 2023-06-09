import 'dart:io';

import 'package:image/image.dart' as img;

class ThresholdImage{
  File? applyThreshold(File? imageFile) {
    if (imageFile == null) {
      return null;
    }

    final bytes = imageFile.readAsBytesSync();
    final image = img.decodeImage(bytes);

    if (image == null) {
      return null;
    }

    // Definir o valor de limiar (0 a 255)
    const threshold = 165;

    final grayscaleImage = img.grayscale(image);
    final thresholdedImage = img.Image.from(grayscaleImage);

    int createRgb(int r, int g, int b) {
      return img.getColor(r, g, b, 255);
    }

    for (var y = 0; y < thresholdedImage.height; y++) {
      for (var x = 0; x < thresholdedImage.width; x++) {
        final pixel = thresholdedImage.getPixel(x, y);
        final red = img.getRed(pixel);
        final green = img.getGreen(pixel);
        final blue = img.getBlue(pixel);
        final average = (red + green + blue) ~/ 3;

        if (average < threshold) {
          thresholdedImage.setPixel(x, y, createRgb(0, 0, 0)); // Pixel preto
        } else {
          thresholdedImage.setPixel(x, y, createRgb(255, 255, 255)); // Pixel branco
        }
      }
    }
    final tempDir = Directory.systemTemp;
    final tempPath = '${tempDir.path}/threshold_image.png';

    final outputBytes = img.encodePng(thresholdedImage);
    final outputFile = File(tempPath);
    outputFile.writeAsBytesSync(outputBytes);

    return outputFile;
  }
}

