class Helpers {
  static String formatDate(String releaseDate) {
    var split = releaseDate.split('-');
    return "${split[2]}/${split[1]}/${split[0]}";
  }
}
