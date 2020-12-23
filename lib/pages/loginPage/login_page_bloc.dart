import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movies/utils/customSharedPreferences.dart';

class LoginBloc {
  final StreamController<bool> _loginController = StreamController();
  Stream<bool> get loginStream => _loginController.stream;
  Sink<bool> get loginSink => _loginController.sink;

  Future getUsuarioBiometria() async {
    await CustomSharedPreferences.readUsuarioBiometria().then((response) async {
      loginSink.add(response);
      debugPrint(response.toString());
    });
  }

  dispose() {
    _loginController.close();
  }
}
