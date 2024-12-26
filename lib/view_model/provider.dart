import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_information_app/repository/movie_detail_repository_impl.dart';
import 'package:movie_information_app/repository/movie_list_repository.dart';
import 'package:movie_information_app/repository/movie_list_repository_impl.dart';
import 'package:movie_information_app/use_case/movie_list_service.dart';
import 'package:movie_information_app/use_case/movie_detail_service.dart';
import 'package:movie_information_app/repository/movie_detail_repository.dart';

final movieListRepositoryProvider = Provider<MovieListRepository>((ref) {
  // 여기서 MovieListRepositoryImpl 인스턴스를 반환
  return MovieListRepositoryImpl();
});

final movieListServiceProvider = Provider<MovieListService>((ref) {
  return MovieListService(ref.watch(movieListRepositoryProvider));
});

final movieDetailRepositoryProvider = Provider<MovieDetailRepository>((ref) {
  return MovieDetailRepositoryImpl();
});
final movieDetailServiceProvider = Provider<MovieDetailService>((ref) {
  return MovieDetailService(ref.watch(movieDetailRepositoryProvider));
});
