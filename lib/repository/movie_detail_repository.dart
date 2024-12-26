import 'package:movie_information_app/dto/movie_detail_dto.dart';

abstract class MovieDetailRepository {
  Future<MovieDetailDto> getMovieDetail(int movieId);
}
