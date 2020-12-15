import 'package:flutter/material.dart';
import 'package:movies/pages/favoritosPage/favoritos_page.dart';
import 'package:movies/pages/homePage/home_page.dart';
import 'package:movies/utils/constants.dart';

class BasePage extends StatefulWidget {
  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int _indiceAtual = 0;
  final List<Widget> _telas = [
    HomePage(),
    FavoritosPage(),
  ];
  void onTabTapped(int index) {
    setState(() {
      _indiceAtual = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _telas[_indiceAtual],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: BLUE,
        selectedIconTheme: kSELECTED_ICON,
        unselectedIconTheme: kUNSELECTED_ICON,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedLabelStyle: TextStyle(
          color: Colors.white,
          decorationColor: Colors.white,
        ),
        onTap: onTabTapped,
        currentIndex: _indiceAtual,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favoritos",
          ),
        ],
      ),
    );
  }
}
