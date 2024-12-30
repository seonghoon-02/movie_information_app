import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_information_app/entity/movie_list_entity.dart';
import 'package:movie_information_app/use_case/movie_list_service.dart';
import 'package:movie_information_app/use_case/movie_similar_service.dart';
import 'package:movie_information_app/view_model/provider.dart';

// ViewModel 정의
class MovieSimilarViewModel
    extends StateNotifier<AsyncValue<List<MovieListEntity>>> {
  final MovieSimilarService movieSimilarService;

  MovieSimilarViewModel({required this.movieSimilarService})
      : super(AsyncValue.loading());

  // 영화 목록을 fetch하는 메서드
  Future<void> fetchSimilarMovies(int id) async {
    try {
      final movieList = await movieSimilarService.fetchSimilarList(id);
      state = AsyncValue.data(movieList);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace); // stackTrace 추가
    }
  }
}

// StateNotifierProvider를 사용하여 ViewModel을 등록
final movieSimilarViewModelProvider = StateNotifierProvider.family<
    MovieSimilarViewModel, AsyncValue<List<MovieListEntity>>, int>(
  (ref, id) {
    final movieSimilarService = ref.watch(movieSimilarServiceProvider);
    final viewModel =
        MovieSimilarViewModel(movieSimilarService: movieSimilarService);
    print('dddddddddddd');

    // ViewModel 초기화: 카테고리 데이터를 로드
    viewModel.fetchSimilarMovies(id);
    print('eeeeeeeeeeeeee');

    return viewModel;
  },
);
