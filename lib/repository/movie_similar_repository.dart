import 'package:movie_information_app/dto/movie_list_dto.dart';

abstract class MovieSimilarRepository {
  Future<List<MovieListDto>> getSimilarList(int id);
}
