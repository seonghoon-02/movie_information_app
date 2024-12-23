import 'package:dio/dio.dart';
import 'package:movie_information_app/dto/movie_detail_dto.dart';

class MovieDetailRepository {
  final String apiKey = String.fromEnvironment('TMDB_API_TOKEN');
  final String baseUrl = 'https://api.themoviedb.org/3/movie/';
  final Dio dio = Dio();

  // 영화 상세 정보를 가져오는 메소드
  Future<MovieDetailDto> getMovieDetail(int movieId) async {
    try {
      final response = await dio.get(
        '$baseUrl$movieId',
        queryParameters: {'language': 'ko-KR'},
        options: Options(
          headers: {
            'Authorization': 'Bearer $apiKey',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return MovieDetailDto.fromJson(response.data);
      } else {
        throw Exception('Failed to load movie details');
      }
    } catch (e) {
      throw Exception('Failed to load movie details: $e');
    }
  }
}
