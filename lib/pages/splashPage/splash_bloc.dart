import 'dart:async';

import 'package:movies/utils/customSharedPreferences.dart';

class SplashBloc {
  final StreamController<bool> _splashController = StreamController();
  Stream<bool> get splashStream => _splashController.stream;
  Sink<bool> get splashSink => _splashController.sink;

  Future getUsuarioLogin() async {
    await CustomSharedPreferences.readUsuario().then((read) async {
      if (read != null) {
        var usuario = read;
        splashSink.add(usuario);
      } else {
        splashSink.add(false);
      }
    });
  }

  dispose() {
    _splashController.close();
  }
}
