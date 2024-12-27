import 'package:movie_information_app/dto/movie_detail_dto.dart';
import 'package:movie_information_app/entity/movie_detail_entity.dart';
import 'package:movie_information_app/repository/movie_detail_repository.dart';

class MovieDetailService {
  final MovieDetailRepository repository;

  MovieDetailService(this.repository);

  Future<MovieDetailEntity> fetchMovieDetail(int movieId) async {
    // 1. DTO 데이터를 Repository에서 가져옴
    final movieDetailDto = await repository.getMovieDetail(movieId);

    // 2. DTO -> Entity로 변환
    final movieDetailEntity = MovieDetailEntity(
      budget: movieDetailDto.budget,
      genres: movieDetailDto.genres
          .map((genre) => genre.name)
          .toList(), // List<Genre>를 List<String>으로 변환
      id: movieDetailDto.id,
      productionCompanyLogos: movieDetailDto.productionCompanies
          .where((company) =>
              company.logoPath != null) // logoPath가 null이 아닌 경우만 필터링
          .map((company) =>
              'https://image.tmdb.org/t/p/w200${company.logoPath!}')
          .toList(), // null-safe logoPath를 리스트에 추가
      overview: movieDetailDto.overview,
      popularity: movieDetailDto.popularity,
      releaseDate: movieDetailDto.releaseDate,
      revenue: movieDetailDto.revenue,
      runtime: movieDetailDto.runtime,
      tagline: movieDetailDto.tagline,
      title: movieDetailDto.title,
      voteAverage: movieDetailDto.voteAverage,
      voteCount: movieDetailDto.voteCount,
      posterPath: movieDetailDto.posterPath,
    );

    return movieDetailEntity;
  }
}
