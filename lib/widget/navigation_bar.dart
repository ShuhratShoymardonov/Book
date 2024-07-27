import 'package:flutter/material.dart';
import 'package:myflutter_book/scren/home_scren.dart';
import 'package:myflutter_book/scren/Setting_page.dart';
import 'package:myflutter_book/scren/search_scren.dart';
import 'package:myflutter_book/scren/favorit_scren.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Navigations extends StatefulWidget {
  const Navigations({super.key});

  @override
  State<Navigations> createState() => _NavigationsState();
}

class _NavigationsState extends State<Navigations> {
  int _indexx = 0;

  final List<Widget> ScreenList = [
    HomeScreen(),
    SearchScren(),
    FavoritScren(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenList[_indexx],
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: Durations.medium2,
        // buttonBackgroundColor: Colors.white54,
        backgroundColor: Colors.white54,
        color: Colors.grey[300]!,
        // animationDuration: Duration(seconds: 3),
        items: [
          Icon(Icons.home_outlined),
          Icon(Icons.search_outlined),
          Icon(Icons.favorite_outline),
          Icon(Icons.settings_outlined),
        ],
        onTap: (value) {
          setState(() {
            _indexx = value;
          });
        },
      ),
    );
  }
}
