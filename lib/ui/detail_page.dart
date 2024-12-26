import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_information_app/view_model/movie_detail_view_model.dart';

class DetailPage extends ConsumerWidget {
  final int id;

  DetailPage({required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ViewModel의 상태를 가져옵니다.
    final movieDetailAsync = ref.watch(movieDetailViewModelProvider(id));

    // 화면의 너비를 가져옵니다.
    final screenWidth = MediaQuery.of(context).size.width;

    // 이미지의 가로세로 비율에 따라 높이를 계산합니다.
    final imageHeight = screenWidth * 1.5; // 3:2 비율이므로 1.5를 곱함

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: movieDetailAsync.when(
            loading: () => Center(child: CircularProgressIndicator()), // 로딩 상태
            error: (error, stackTrace) {
              // 콘솔에 에러 로그 출력
              debugPrint('Error occurred: $error');
              debugPrint('StackTrace: $stackTrace');
              return Center(
                child: Text('에러 발생: $error'),
              );
            }, // 에러 상태
            data: (movieDetail) {
              if (movieDetail == null) {
                return Center(
                  child: Text('영화 정보를 가져올 수 없습니다.'),
                );
              }

              // 데이터가 로드되었을 때 UI
              return ListView(
                children: [
                  Container(
                    height: imageHeight,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(movieDetail.posterPath ??
                            'https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2Fb4W7bP%2FbtsKVcAKEGd%2FIE8FTHqrB7cxySJs9cWF3k%2Fimg.jpg'),
                        fit: BoxFit.cover, // 이미지를 화면에 꽉 채우도록 설정
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movieDetail.title ?? '제목 없음',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '개봉일: ${movieDetail.releaseDate ?? '정보 없음'}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 16),
                        Text(
                          '간단 설명: ${movieDetail.overview ?? '설명이 없습니다.'}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 16),
                        Text(
                          '러닝타임: ${movieDetail.runtime ?? '정보 없음'} 분',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 16),
                        Text(
                          '태그라인: ${movieDetail.tagline ?? '정보 없음'}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 16),
                        Text(
                          '흥행 정보: \$${movieDetail.revenue ?? 0}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
