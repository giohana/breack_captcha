import 'dart:io';

import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';

class ExtractText{
  Future<String> extractTextFromImage(File imageFile) async {
    final result = await FlutterTesseractOcr.extractText(imageFile.path);
    return result.toString();
  }
}