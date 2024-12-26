import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_information_app/entity/movie_list_entity.dart';
import 'package:movie_information_app/use_case/movie_list_service.dart';
import 'package:movie_information_app/view_model/provider.dart';

// ViewModel 정의
class MovieListViewModel extends StateNotifier<List<MovieListEntity>> {
  final MovieListService movieListService;

  MovieListViewModel({required this.movieListService}) : super([]);

  // 영화 목록을 fetch하는 메서드
  Future<void> fetchMovies(String category) async {
    try {
      final movieList = await movieListService.fetchMovieList(category);
      state = movieList;
    } catch (e) {
      throw Exception('Failed to fetch movie list: $e');
    }
  }
}

// StateNotifierProvider를 사용하여 ViewModel을 등록
final movieListViewModelProvider =
    StateNotifierProvider<MovieListViewModel, List<MovieListEntity>>(
  (ref) {
    final movieListService =
        ref.watch(movieListServiceProvider); // movieListServiceProvider 참조
    return MovieListViewModel(movieListService: movieListService);
  },
);
