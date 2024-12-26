import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_information_app/dto/movie_detail_dto.dart';
import 'package:movie_information_app/repository/movie_detail_repository.dart';

class MovieDetailRepositoryImpl implements MovieDetailRepository {
  final String apiKey = dotenv.env['TMDB_API_TOKEN'].toString();
  final Dio dio = Dio();

  @override
  Future<MovieDetailDto> getMovieDetail(int movieId) async {
    try {
      final response = await dio.get(
        'https://api.themoviedb.org/3/movie/$movieId',
        queryParameters: {'language': 'ko-KR'},
        options: Options(
          headers: {
            'Authorization': apiKey,
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
