import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_information_app/entity/movie_detail_entity.dart';
import 'package:movie_information_app/use_case/movie_detail_service.dart';
import 'package:movie_information_app/view_model/provider.dart';

class MovieDetailViewModel
    extends StateNotifier<AsyncValue<MovieDetailEntity?>> {
  final MovieDetailService movieDetailService;

  MovieDetailViewModel({required this.movieDetailService})
      : super(const AsyncValue.loading());

  Future<void> fetchMovieDetail(int movieId) async {
    try {
      state = const AsyncValue.loading(); // 로딩 상태로 변경
      final movieDetail = await movieDetailService.fetchMovieDetail(movieId);
      state = AsyncValue.data(movieDetail); // 데이터 로드 성공
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current); // 에러 상태로 변경
      print(e);
    }
  }
}

final movieDetailViewModelProvider = StateNotifierProvider.family<
    MovieDetailViewModel, AsyncValue<MovieDetailEntity?>, int>(
  (ref, movieId) {
    final movieDetailService = ref.watch(movieDetailServiceProvider);
    final viewModel =
        MovieDetailViewModel(movieDetailService: movieDetailService);
    viewModel.fetchMovieDetail(movieId); // 데이터 요청
    return viewModel;
  },
);
