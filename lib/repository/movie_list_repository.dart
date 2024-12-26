import 'package:movie_information_app/dto/movie_list_dto.dart';

abstract class MovieListRepository {
  Future<List<MovieListDto>> getMovieList(String movieCategory);
}
