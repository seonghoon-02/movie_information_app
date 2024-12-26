import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_information_app/dto/movie_list_dto.dart';
import 'package:movie_information_app/repository/movie_list_repository.dart';

class MovieListRepositoryImpl implements MovieListRepository {
  final String apiKey = dotenv.env['TMDB_API_TOKEN'].toString();

  final Dio dio = Dio();

  @override
  Future<List<MovieListDto>> getMovieList(String movieCategory) async {
    try {
      final response = await dio.get(
        'https://api.themoviedb.org/3/movie/$movieCategory?language=ko-KR&page=1',
        options: Options(
          headers: {
            'Authorization': apiKey,
            'accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> results = response.data['results'];
        // 각 영화 데이터를 MovieResponseDto로 변환
        return results.map((movieJson) {
          return MovieListDto.fromJson(movieJson);
        }).toList();
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      throw Exception('Failed to load movies: $e');
    }
  }
}
