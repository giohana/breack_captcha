import 'dart:io';

import 'package:break_recapta/components/circular_button.dart';
import 'package:break_recapta/controller/erosion.dart';
import 'package:break_recapta/controller/threshold.dart';
import 'package:break_recapta/controller/smoothing.dart';
import 'package:break_recapta/screens/finish_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final picker = ImagePicker();
  File? _selectedImage;
  bool finish = false;


  getImage(ImageSource src) async {
    final pickedFile = await picker.pickImage(source: src);
    if (pickedFile != null) {
      var cropped = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxHeight: 700,
          maxWidth: 700,
          compressFormat: ImageCompressFormat.jpg,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Camera',
            ),
            IOSUiSettings(
              title: 'Camera',
            )
          ]);
      setState(() {
        _selectedImage = File(cropped!.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: size.height * 0.06),
            width: 250,
            child: Image.asset(
              'assets/logo.png',
              color: Colors.white,
            ),
          ),
          _selectedImage == null ? bodyImageNotSelected() : bodyImageSelected()
        ],
      ),
    );
  }

  Widget bodyImageNotSelected() {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: size.height * 0.1),
          child: const Text(
            'Exporte uma imagem ou tire uma foto:',
            style: TextStyle(color: Colors.white),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CircularButton(
              label: 'Câmera',
              icon: const Icon(Icons.add_a_photo) ,
                onPressed: () {
                  getImage(ImageSource.camera);
                }
            ),
            CircularButton(
              label: 'Galeria',
              icon: const Icon(Icons.add_photo_alternate),
              onPressed: () {
                getImage(ImageSource.gallery);
              },
            ),
          ],
        )
      ],
    );
  }

  Widget bodyImageSelected() {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: size.height * 0.03),
          child: Center(
            child: Image.file(
              _selectedImage!,
              width: 250,
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: size.height * 0.03),
          child: const Text('Continuar com imagem selecionada?',
            style: TextStyle(color: Colors.white),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CircularButton(
                label: 'Confirmar',
                icon: const Icon(Icons.check) ,
                onPressed: () async {
                  var imageSmoothing = SmoothingImage().applySmoothing(_selectedImage);
                  var imageThreshold = ThresholdImage().applyThreshold(imageSmoothing);
                  var imageErosion = ErosionImage().applyErosion(imageThreshold);
                  const text = '';
                   setState(() {
                     _selectedImage = imageErosion;
                   });

                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FinishScreen(
                      selectedImage: _selectedImage,
                      text: text.toString(),
                    )),
                  );
                }
            ),
            CircularButton(
              label: 'Tentar Novamente',
              icon: const Icon(Icons.replay),
              onPressed: () {
                setState(() {
                  _selectedImage = null;
                });
              },
            ),
          ],
        )
      ],
    );
  }
}
