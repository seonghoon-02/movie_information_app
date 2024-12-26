import 'package:movie_information_app/dto/movie_detail_dto.dart';
import 'package:movie_information_app/dto/movie_list_dto.dart';
import 'package:movie_information_app/repository/movie_detail_repository.dart';
import 'package:movie_information_app/repository/movie_list_repository.dart';

class MovieService {
  final MovieListRepository movieRepository;

  MovieService(this.movieRepository);

  Future<List<MovieListDto>> fetchMovies(String category) async {
    return await movieRepository.getMovieList(category);
  }
}

class MovieDetailService {
  final MovieDetailRepository repository;

  MovieDetailService(this.repository);

  Future<MovieDetailDto> fetchMovieDetail(int movieId) {
    return repository.getMovieDetail(movieId);
  }
}
