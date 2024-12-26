import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_information_app/dto/movie_detail_dto.dart';
import 'package:movie_information_app/entity/movie_detail_entity.dart';
import 'package:movie_information_app/repository/movie_detail_repository.dart';
import 'package:movie_information_app/use_case/movie_detail_service.dart';

class MockMovieDetailRepository extends Mock implements MovieDetailRepository {}

void main() {
  late MockMovieDetailRepository mockRepository;
  late MovieDetailService movieDetailService;

  setUp(() {
    mockRepository = MockMovieDetailRepository();
    movieDetailService = MovieDetailService(mockRepository);
  });

  test('fetchMovieDetail returns movie details as MovieDetailEntity', () async {
    // Arrange
    final movieId = 12345;
    final mockResponse = MovieDetailDto(
      adult: false,
      backdropPath: '/backdrop.jpg',
      genres: [
        Genre(id: 28, name: 'Action'),
        Genre(id: 12, name: 'Adventure'),
      ],
      id: movieId,
      originalLanguage: 'en',
      originalTitle: 'Test Original Title',
      overview: 'This is a test movie.',
      popularity: 9.8,
      posterPath: '/poster.jpg',
      productionCompanies: [
        ProductionCompany(
          id: 1,
          name: 'Test Production Company',
          logoPath: '/logo.png',
          originCountry: 'US',
        ),
      ],
      releaseDate: '2024-12-25',
      revenue: 1000000,
      runtime: 120,
      spokenLanguages: ['English'],
      status: 'Released',
      tagline: 'Test Tagline',
      title: 'Test Movie',
      voteAverage: 8.5,
      voteCount: 1000,
      budget: 310000000, // budget 추가
    );

    when(() => mockRepository.getMovieDetail(movieId))
        .thenAnswer((_) async => mockResponse);

    // Act
    final movieDetailEntity =
        await movieDetailService.fetchMovieDetail(movieId);

    // Assert
    expect(movieDetailEntity.id, movieId);
    expect(movieDetailEntity.title, 'Test Movie');
    expect(movieDetailEntity.overview, 'This is a test movie.');
    expect(movieDetailEntity.genres, isNotEmpty);
    expect(movieDetailEntity.genres.first, 'Action'); // String으로 변환된 장르 확인
    expect(movieDetailEntity.productionCompanyLogos.first, '/logo.png');
    expect(movieDetailEntity.runtime, 120);
    expect(movieDetailEntity.voteAverage, 8.5);
    expect(movieDetailEntity.budget, 310000000); // budget이 제대로 변환되었는지 확인
  });
}
