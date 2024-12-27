import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_information_app/view_model/movie_detail_view_model.dart';

class DetailPage extends ConsumerWidget {
  final int id;

  DetailPage({required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieDetailAsync = ref.watch(movieDetailViewModelProvider(id));
    final screenWidth = MediaQuery.of(context).size.width;
    final imageHeight = screenWidth * 1.5;

    return Scaffold(
      body: SafeArea(
        child: movieDetailAsync.when(
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Text('에러 발생: $error'),
          ),
          data: (movieDetail) {
            if (movieDetail == null) {
              return Center(
                child: Text('영화 정보를 가져올 수 없습니다.'),
              );
            }

            return SingleChildScrollView(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Hero(
                  tag: id,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: imageHeight,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(movieDetail.posterPath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    movieDetail.title ?? '제목 없음',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(width: 16),
                                Text(
                                  '개봉일: ${movieDetail.releaseDate ?? '정보 없음'}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              '${movieDetail.tagline ?? '정보 없음'}',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              '${movieDetail.runtime ?? '정보 없음'} 분',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 55,
                              alignment: Alignment.centerLeft,
                              width: double.infinity,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: movieDetail.genres.map((genre) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 5, top: 5, right: 3),
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                        ),
                                        child: Text(
                                          genre,
                                          style: TextStyle(
                                              fontSize: 16, color: Colors.blue),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 7),
                              child: Text(
                                '${movieDetail.overview ?? '설명이 없습니다.'}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              '흥행 정보',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 80,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  boxOfficeInfomationUi(
                                      '평점', '${movieDetail.voteAverage}'),
                                  boxOfficeInfomationUi(
                                      '평점투표수', '${movieDetail.voteCount}'),
                                  boxOfficeInfomationUi(
                                      '인기점수', '${movieDetail.popularity}'),
                                  boxOfficeInfomationUi(
                                      '예산', '\$${movieDetail.budget}'),
                                  boxOfficeInfomationUi(
                                      '수익', '\$${movieDetail.revenue}'),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
                            SizedBox(
                              height: 129,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    movieDetail.productionCompanyLogos.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8, right: 10),
                                    child: Container(
                                      height: 129,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(movieDetail
                                              .productionCompanyLogos[index]),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Padding boxOfficeInfomationUi(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, top: 5, right: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.white,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(flex: 1, child: Text(value)),
            Flexible(flex: 1, child: Text(title)),
          ],
        ),
      ),
    );
  }
}
