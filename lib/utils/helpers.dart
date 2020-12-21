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
}
