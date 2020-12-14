import 'package:dio/dio.dart';
import 'package:movies/models/movie_model.dart';
import 'package:movies/models/video_model.dart';
import 'package:movies/utils/constants.dart';
import 'package:movies/utils/customDio.dart';

class VideoRepository {
  final CustomDio _dio = CustomDio();

  Future<Video> getVideo(int id) async {
    var _getVideo = "$kBASE_URL/movie/$id/videos";
    var parametros = {"api_key": kCHAVE, "language": "en-US", "page": 1};
    try {
      Response response =
          await _dio.get(_getVideo, queryParameters: parametros);
      var video = response.data;
      return Video.fromJson(video);
    } catch (error) {
      print(error);
      return null;
    }
  }
}
