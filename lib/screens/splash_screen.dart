import 'package:break_recapta/screens/camera_screen.dart';
import 'package:flutter/material.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {

  @override
  void initState() {
    super.initState();
    initData().then((value) => navigateToHomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Stack(children: <Widget>[
      Center(
        child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: Image.asset(
                  "assets/logo.png",
                  height: height * 0.2,
                  color: Colors.white,
                ),
              ),
            )),
      ),
    ]);
  }

  Future initData() async => await Future.delayed(
    const Duration(
      milliseconds: 1500,
    ),
  );

  void navigateToHomeScreen() => Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (BuildContext context) => const CameraScreen(),
    ),
  );
}
