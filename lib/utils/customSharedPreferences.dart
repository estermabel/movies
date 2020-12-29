import 'package:flutter/material.dart';
import 'package:movies/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomSharedPreferences {
  //Salva os Favoritos
  static save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  //Get os Favoritos
  static read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    var result = prefs.getString(key);
    return result;
  }

  //Salva se o usuário está ou não logado
  static saveUsuario(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(kUsuarioLogin, value);
  }

  //Verifica se o usuário está logado
  static readUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    var result = (prefs.getBool(kUsuarioLogin) ?? false);
    return result;
  }

  //Salva se o usuário quer utilizar biometria
  static saveUsuarioBiometria(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(kUsuarioBiometria, value);
  }

  //Verifica se o usuário quer utilizar biometria
  static readUsuarioBiometria() async {
    final prefs = await SharedPreferences.getInstance();
    var result = (prefs.getBool(kUsuarioBiometria) ?? false);
    return result;
  }

  //Salva se o usuário já viu o onBoarding
  static saveUsuarioOnBoarding(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(kUsuarioOnBoarding, value);
  }

  //Verifica se o usuário já viu o onBoarding
  static readUsuarioOnBoarding() async {
    final prefs = await SharedPreferences.getInstance();
    var result = (prefs.getBool(kUsuarioOnBoarding) ?? false);
    return result;
  }
}
