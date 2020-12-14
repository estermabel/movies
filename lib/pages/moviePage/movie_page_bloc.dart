import 'dart:async';

import 'package:movies/api/video_repository.dart';
import 'package:movies/models/video_model.dart';

class MovieBloc {
  final VideoRepository repository;
  StreamController<Video> _videoController = StreamController();
  Stream<Video> get videoStream => _videoController.stream;
  Sink<Video> get videoSink => _videoController.sink;

  MovieBloc(this.repository);

  getVideo(int movieId) async {
    var response = await repository.getVideo(movieId);
    if (response != null) {
      videoSink.add(response);
    }
  }

  dispose() {
    _videoController.close();
  }
}
