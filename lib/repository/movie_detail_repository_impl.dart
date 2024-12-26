import 'package:dio/dio.dart';
import 'package:movie_information_app/dto/movie_detail_dto.dart';
import 'package:movie_information_app/repository/movie_detail_repository.dart';

class MovieDetailRepositoryImpl implements MovieDetailRepository {
  final String apiKey = String.fromEnvironment('TMDB_API_TOKEN');
  final String baseUrl = 'https://api.themoviedb.org/3/movie/';
  final Dio dio = Dio();

  @override
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
