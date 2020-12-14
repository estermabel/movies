import 'package:movies/models/results_model.dart';

class Video {
  int id;
  List<Result> results;

  Video({this.id, this.results});

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['results'] != null) {
      results = new List<Result>();
      json['results'].forEach((v) {
        results.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.results != null) {
      data['results'] = this.results;
    }
    return data;
  }
}
