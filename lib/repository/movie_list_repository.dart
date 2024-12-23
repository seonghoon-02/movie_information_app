import 'package:dio/dio.dart';
import 'package:movie_information_app/dto/movie_response_dto.dart';

class MovieListRepository {
  final String apiKey = String.fromEnvironment('TMDB_API_TOKEN');
  final String baseUrl = 'https://api.themoviedb.org/3/movie/';
  final Dio dio = Dio();

  // 영화 목록을 가져오는 메소드 (카테고리 값을 외부에서 받아옴)
  Future<List<MovieResponseDto>> getMovieList(String movieCategory) async {
    try {
      final response = await dio.get(
        '$baseUrl$movieCategory?language=ko-KR&page=1',
        options: Options(
          headers: {
            'Authorization': 'Bearer $apiKey',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> results = response.data['results'];

        // 각 영화 데이터를 MovieResponseDto로 변환
        return results.map((movieJson) {
          return MovieResponseDto.fromJson(movieJson);
        }).toList();
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      throw Exception('Failed to load movies: $e');
    }
  }
}
