import 'package:movie_information_app/dto/movie_list_dto.dart';
import 'package:movie_information_app/entity/movie_list_entity.dart';
import 'package:movie_information_app/repository/movie_list_repository.dart';

class MovieListService {
  final MovieListRepository movieListRepository;

  MovieListService(this.movieListRepository);

  Future<List<MovieListEntity>> fetchMovies(String category) async {
    // DTO 데이터를 Repository에서 가져옴
    final movieListDtos = await movieListRepository.getMovieList(category);

    // DTO -> Entity로 변환
    final movieListEntities = movieListDtos.map((dto) {
      return MovieListEntity(
        id: dto.id,
        posterPath: dto.posterPath,
      );
    }).toList();

    return movieListEntities;
  }
}
