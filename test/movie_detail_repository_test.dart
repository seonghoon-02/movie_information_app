import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_information_app/dto/movie_detail_dto.dart';
import 'package:movie_information_app/repository/movie_detail_repository.dart';
import 'package:movie_information_app/use_case/movie_service.dart';

class MockMovieDetailRepository extends Mock implements MovieDetailRepository {}

void main() {
  late MockMovieDetailRepository mockRepository;
  late MovieDetailService movieDetailService;

  setUp(() {
    mockRepository = MockMovieDetailRepository();
    movieDetailService = MovieDetailService(mockRepository);
  });

  test('fetchMovieDetail returns movie details', () async {
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
    );

    when(() => mockRepository.getMovieDetail(movieId))
        .thenAnswer((_) async => mockResponse);

    // Act
    final movieDetail = await movieDetailService.fetchMovieDetail(movieId);

    // Assert
    expect(movieDetail.id, movieId);
    expect(movieDetail.title, 'Test Movie');
    expect(movieDetail.overview, 'This is a test movie.');
    expect(movieDetail.genres, isNotEmpty);
    expect(movieDetail.genres.first.name, 'Action');
    expect(
        movieDetail.productionCompanies.first.name, 'Test Production Company');
    expect(movieDetail.runtime, 120);
    expect(movieDetail.voteAverage, 8.5);
  });
}
