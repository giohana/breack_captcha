import 'dart:io';
import 'package:image/image.dart' as img;

class SmoothingImage{
  File? applySmoothing(File? selectedImage) {
    if (selectedImage == null) return null;

    final bytes = selectedImage.readAsBytesSync();
    final image = img.decodeImage(bytes);

    if (image != null) {
      final smoothedImage = img.gaussianBlur(image, 4);
      final encodedImage = img.encodePng(smoothedImage);

      final tempDir = Directory.systemTemp;
      final tempPath = '${tempDir.path}/smoothed_image.png';

      final file = File(tempPath);
      file.writeAsBytesSync(encodedImage);

      return file;
    }

    return null;
  }
}