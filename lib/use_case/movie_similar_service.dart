import 'package:movie_information_app/dto/movie_list_dto.dart';
import 'package:movie_information_app/entity/movie_list_entity.dart';
import 'package:movie_information_app/repository/movie_similar_repository.dart';

class MovieSimilarService {
  final MovieSimilarRepository movieSimilarRepository;

  MovieSimilarService(this.movieSimilarRepository);

  Future<List<MovieListEntity>> fetchSimilarList(int id) async {
    // DTO 데이터를 Repository에서 가져옴
    final movieSimilarDtos = await movieSimilarRepository.getSimilarList(id);

    // DTO -> Entity로 변환
    final movieSimilarEntities = movieSimilarDtos.map((dto) {
      return MovieListEntity(
        id: dto.id,
        posterPath: dto.posterPath,
      );
    }).toList();

    return movieSimilarEntities;
  }
}
