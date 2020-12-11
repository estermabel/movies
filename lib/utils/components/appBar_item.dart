import 'package:flutter/material.dart';

import '../constants.dart';

AppBar myAppBar() {
  return AppBar(
    title: Text(
      "Movies",
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: BLUE,
  );
}
