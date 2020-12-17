import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomSharedPreferences {
  static save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    debugPrint("SALVOU");
  }

  static read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    var result = prefs.getString(key);
    return result;
  }

  static deleteElement(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static deleteList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
