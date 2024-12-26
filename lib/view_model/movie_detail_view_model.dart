import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_information_app/entity/movie_detail_entity.dart';
import 'package:movie_information_app/use_case/movie_detail_service.dart';
import 'package:movie_information_app/view_model/provider.dart';

class MovieDetailViewModel extends StateNotifier<MovieDetailEntity?> {
  final MovieDetailService movieDetailService;

  MovieDetailViewModel({required this.movieDetailService}) : super(null);

  Future<void> fetchMovieDetail(int movieId) async {
    try {
      final movieDetail = await movieDetailService.fetchMovieDetail(movieId);
      state = movieDetail;
    } catch (e) {
      throw Exception('Failed to fetch movie details: $e');
    }
  }
}

final movieDetailViewModelProvider =
    StateNotifierProvider<MovieDetailViewModel, MovieDetailEntity?>(
  (ref) => MovieDetailViewModel(
      movieDetailService: ref.watch(movieDetailServiceProvider)),
);
