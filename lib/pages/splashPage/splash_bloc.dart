import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movies/utils/customSharedPreferences.dart';

class SplashBloc {
  final StreamController<bool> _splashController = StreamController();
  Stream<bool> get splashStream => _splashController.stream;
  Sink<bool> get splashSink => _splashController.sink;

  Future getUsuarioLogin() async {
    await CustomSharedPreferences.readUsuario().then((response) async {
      splashSink.add(response);
      debugPrint(response.toString());
    });
  }

  dispose() {
    _splashController.close();
  }
}
