import 'package:flutter/material.dart';

import '../constants.dart';

AppBar myAppBar(String title) {
  return AppBar(
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: BLUE,
  );
}
