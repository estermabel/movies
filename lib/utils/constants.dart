import 'package:flutter/material.dart';
import 'package:movies/models/movie_model.dart';

//#1d2d50
const Color DARK_BLUE = Color.fromRGBO(29, 45, 80, 1);
//#133b5c
const Color BLUE = Color.fromRGBO(29, 59, 92, 1);
//#1e5f74
const Color LIGHT_BLUE = Color.fromRGBO(30, 95, 116, 1);
//#fcdab7
const Color SALMON = Color.fromRGBO(252, 218, 183, 1);

const kBASE_URL = "https://api.themoviedb.org/3";

const kCHAVE = "b110ece4de4ab7fee86d41cdad01500f";

const kUsuarioLogin = "usuarioLogin";

const IconThemeData kSELECTED_ICON = IconThemeData(
  color: SALMON,
  size: 40,
);

const IconThemeData kUNSELECTED_ICON = IconThemeData(
  color: LIGHT_BLUE,
  size: 35,
);
