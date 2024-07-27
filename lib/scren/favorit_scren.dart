import 'package:flutter/material.dart';

class FavoritScren extends StatelessWidget {
  const FavoritScren({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Text(
          'favorit page',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}