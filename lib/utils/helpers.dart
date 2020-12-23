import 'package:flutter/cupertino.dart';

class Helpers {
  static String formatDate(String releaseDate) {
    var split = releaseDate.split('-');
    var newReleaseDate = "${split[2]}/${split[1]}/${split[0]}";
    try {
      return newReleaseDate;
    } catch (e) {
      return releaseDate;
    }
  }

  static bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(value.trim());
  }

  static bool validatePassword(String value) {
    return value.trim().length >= 6;
  }

  static String loginAlertDialogMessage(
      TextEditingController _email, TextEditingController _senha) {
    var text;
    if (_email.text.isEmpty &&
        _senha.text.isNotEmpty &&
        validatePassword(_senha.text) == true) {
      text = "Preencha o campo de e-mail!";
    } else if (_email.text.isNotEmpty &&
        _senha.text.isEmpty &&
        validateEmail(_email.text) == true) {
      text = "Preencha o campo de senha!";
    } else if (_email.text.isEmpty && _senha.text.isEmpty) {
      text = "Preencha todos os campos!";
    } else if (validateEmail(_email.text) == true &&
        validatePassword(_senha.text) == false) {
      text = "Senha inválida!";
    } else if (validateEmail(_email.text) == false &&
        validatePassword(_senha.text) == false) {
      text = "E-mail e senha inválidos!";
    } else if (validateEmail(_email.text) == false &&
        validatePassword(_senha.text) == true) {
      text = "E-mail inválido!";
    }
    return text;
  }
}
