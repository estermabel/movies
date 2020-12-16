import 'dart:convert';
import 'package:movies/models/movie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomSharedPreferences {
  save(String key, Movie movie) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(movie));
  }

  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key)) as Map<String, dynamic>;
  }

  delete(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
