import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_information_app/dto/movie_list_dto.dart';
import 'package:movie_information_app/repository/movie_list_repository.dart';
import 'package:movie_information_app/use_case/movie_list_service.dart';

class MockMovieRepository extends Mock implements MovieListRepository {}

void main() {
  late MockMovieRepository mockRepository;
  late MovieListService movieService;

  setUp(() {
    mockRepository = MockMovieRepository();
    movieService = MovieListService(mockRepository);
  });

  test('fetchMovies returns movie list', () async {
    // Arrange
    when(() => mockRepository.getMovieList('popular')).thenAnswer((_) async => [
          MovieListDto(
            adult: false,
            backdropPath: '/path.jpg',
            genreIds: [28, 12],
            id: 12345,
            originalLanguage: 'en',
            originalTitle: 'Test Movie',
            overview: 'This is a test movie.',
            popularity: 9.8,
            posterPath: '/poster.jpg',
            releaseDate: DateTime.now(),
            title: 'Test Movie',
            video: false,
            voteAverage: 8.5,
            voteCount: 1000,
          ),
        ]);

    // Act
    final movies = await movieService.fetchMovies('popular');

    // Assert
    expect(movies, isNotEmpty);
    expect(movies.first.id, 12345);
  });
}
