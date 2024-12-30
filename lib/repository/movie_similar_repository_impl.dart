import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_information_app/dto/movie_list_dto.dart';
import 'package:movie_information_app/repository/movie_similar_repository.dart';

class MovieSimilarRepositoryImpl implements MovieSimilarRepository {
  final String apiKey = dotenv.env['TMDB_API_TOKEN'].toString();
  final Dio dio = Dio();

  @override
  Future<List<MovieListDto>> getSimilarList(int id) async {
    try {
      print('Fetching similar movies for movie ID: $id');

      final response = await dio.get(
        'https://api.themoviedb.org/3/movie/${id}/similar?language=ko-KR&page=1',
        options: Options(
          headers: {
            'Authorization': apiKey,
            'accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> results = response.data['results'] ?? [];
        if (results.isEmpty) {
          throw Exception('No similar movies found for ID: $id');
        }

        // 각 영화 데이터를 MovieListDto로 변환
        return results
            .map((movieJson) {
              try {
                return MovieListDto.fromJson(movieJson);
              } catch (e) {
                print('Error parsing movie: $movieJson\nError: $e');
                return null; // 잘못된 데이터 무시
              }
            })
            .whereType<MovieListDto>() // null 데이터를 필터링
            .toList();
      } else {
        throw Exception(
            'Failed to load similar movies: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching similar movies for ID $id: $e');
      throw Exception('Failed to load similar movies: $e');
    }
  }
}
