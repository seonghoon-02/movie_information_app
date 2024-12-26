import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_information_app/entity/movie_list_entity.dart';
import 'package:movie_information_app/use_case/movie_list_service.dart';
import 'package:movie_information_app/view_model/provider.dart';

// ViewModel 정의
class MovieListViewModel
    extends StateNotifier<AsyncValue<List<MovieListEntity>>> {
  final MovieListService movieListService;

  MovieListViewModel({required this.movieListService})
      : super(AsyncValue.loading());

  // 영화 목록을 fetch하는 메서드
  Future<void> fetchMovies(String category) async {
    try {
      final movieList = await movieListService.fetchMovieList(category);
      state = AsyncValue.data(movieList);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace); // stackTrace 추가
    }
  }
}

// StateNotifierProvider를 사용하여 ViewModel을 등록
final movieListViewModelProvider = StateNotifierProvider.family<
    MovieListViewModel, AsyncValue<List<MovieListEntity>>, String>(
  (ref, category) {
    final movieListService = ref.watch(movieListServiceProvider);
    final viewModel = MovieListViewModel(movieListService: movieListService);

    // ViewModel 초기화: 카테고리 데이터를 로드
    viewModel.fetchMovies(category);

    return viewModel;
  },
);
