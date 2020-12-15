import 'package:flutter/material.dart';
import 'package:movies/pages/favoritosPage/favoritos_bloc.dart';
import 'package:movies/utils/components/appBar_item.dart';
import 'package:movies/utils/constants.dart';

class FavoritosPage extends StatefulWidget {
  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> {
  @override
  void initState() {
    super.initState();
    debugPrint("ENTRANDO NA TELA DE FAVORITOS");
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("SAINDO DA TELA DE FAVORITOS");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar("Favoritos"),
      body: Container(
        color: DARK_BLUE,
        child: ListView(
          children: [],
        ),
      ),
    );
  }
}
