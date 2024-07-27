import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:myflutter_book/scren/login_scren.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class SpleshScren extends StatelessWidget {
  const SpleshScren({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.center,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 2, 69, 124),
              Color.fromARGB(255, 2, 69, 124),
              Color.fromARGB(255, 4, 20, 34),
            ],
          ),
        ),
        child: AnimatedSplashScreen(
          backgroundColor: Colors.transparent,
          splash: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Read&Learn",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              // SizedBox(height: 5),
              LottieBuilder(
                lottie: AssetLottie(
                  "asets/animatsi/Animation - 1721363445689.json",
                ),
                height: 300,
                width: 300,
              ),
            ],
          ),
          nextScreen: const LoginScreen(),
          splashIconSize: 400,
          // animationDuration: Duration(seconds: 5),
        ),
      ),
    );
  }
}
