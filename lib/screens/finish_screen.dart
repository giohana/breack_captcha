import 'dart:io';

import 'package:break_recapta/components/circular_button.dart';
import 'package:break_recapta/screens/camera_screen.dart';
import 'package:flutter/material.dart';

class FinishScreen extends StatefulWidget {
  const FinishScreen({required this.selectedImage, required this.text, Key? key}) : super(key: key);
  final File? selectedImage;
  final String text;

  @override
  State<FinishScreen> createState() => _FinishScreenState();
}

class _FinishScreenState extends State<FinishScreen> {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: size.height * 0.06),
              width: 150,
              child: Image.asset(
                'assets/logo.png',
                color: Colors.white,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: size.height * 0.03),
            child: Center(
              child: Image.file(
                widget.selectedImage!,
                width: 250,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            widget.text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24
            ),
          ),
          CircularButton(
            label: 'Tentar Novamente',
            icon: const Icon(Icons.replay),
            onPressed: () {
              setState(() {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const CameraScreen(),
                  ),
                );
              });
            },
          ),
        ],
      ),
    );
  }
}
