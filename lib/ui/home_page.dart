import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_information_app/ui/detail_page.dart';
import 'package:movie_information_app/view_model/movie_list_view_model.dart';

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 각각의 카테고리 데이터를 구독
    final popularMovies =
        ref.watch(movieListViewModelProvider('popular')); //인기순
    final nowMovies =
        ref.watch(movieListViewModelProvider('now_playing')); //현재상영중
    final topMovies =
        ref.watch(movieListViewModelProvider('top_rated')); //평점높은순
    final comingMovies =
        ref.watch(movieListViewModelProvider('upcoming')); //개봉예정

    // 화면의 너비를 가져옵니다.
    final screenWidth = MediaQuery.of(context).size.width;

    // 이미지의 가로세로 비율에 따라 높이를 계산합니다.
    final imageHeight = screenWidth * 1.5; // 3:2 비율이므로 1.5를 곱함

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              Text(
                '가장 인기있는',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              // AsyncValue 상태를 확인하고, 각각에 맞는 UI를 표시
              popularMovies.when(
                data: (movies) {
                  // 데이터가 로드되었을 때 UI
                  return GestureDetector(
                    //**********임시 이동코드
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DetailPage()),
                      );
                    },
                    child: Container(
                      height: imageHeight,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(movies[0].posterPath),
                          fit: BoxFit.cover, // 이미지를 화면에 꽉 채우도록 설정
                        ),
                      ),
                    ),
                  );
                },
                loading: () {
                  // 로딩 중일 때 UI
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
                error: (error, stackTrace) {
                  // 에러 발생 시 UI
                  return Center(
                    child: Text('Error: $error'),
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '현재 상영중',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              nowMovies.when(
                data: movieListView,
                loading: () {
                  // 로딩 중일 때 UI
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
                error: (error, stackTrace) {
                  // 에러 발생 시 UI
                  return Center(
                    child: Text('Error: $error'),
                  );
                },
              ),

              SizedBox(
                height: 10,
              ),
              Text(
                '인기순',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),

              popularMovies.when(
                data: (movies) => movieListView(movies, showNumbers: true),
                loading: () {
                  // 로딩 중일 때 UI
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
                error: (error, stackTrace) {
                  // 에러 발생 시 UI
                  return Center(
                    child: Text('Error: $error'),
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '평점 높은순',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              topMovies.when(
                data: movieListView,
                loading: () {
                  // 로딩 중일 때 UI
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
                error: (error, stackTrace) {
                  // 에러 발생 시 UI
                  return Center(
                    child: Text('Error: $error'),
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '개봉예정',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              comingMovies.when(
                data: movieListView,
                loading: () {
                  // 로딩 중일 때 UI
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
                error: (error, stackTrace) {
                  // 에러 발생 시 UI
                  return Center(
                    child: Text('Error: $error'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget movieListView(List movies, {bool showNumbers = false}) {
    return Container(
      height: 180,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Container(
                height: 180,
                width: showNumbers ? 150 : 130,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    alignment: showNumbers
                        ? Alignment.centerRight
                        : Alignment.centerLeft, // 조건에 따라 정렬 변경
                    image: NetworkImage(movies[index].posterPath),
                    fit: BoxFit.fitHeight, // 이미지를 화면에 꽉 채우도록 설정
                  ),
                  borderRadius: BorderRadius.circular(8), // 이미지 모서리 둥글게 설정
                ),
              ),
              if (showNumbers) // 숫자를 표시 여부를 결정
                Positioned(
                  top: 70, // 숫자의 Y축 위치를 조정
                  left: 0, // 숫자의 X축 위치를 조정
                  child: Text(
                    '${index + 1}', // 숫자를 표시 (1부터 시작)
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 90,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
