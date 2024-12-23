import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 화면의 너비를 가져옵니다.
    final screenWidth = MediaQuery.of(context).size.width;

    // 이미지의 가로세로 비율에 따라 높이를 계산합니다.
    final imageHeight = screenWidth * 1.5; // 3:2 비율이므로 1.5를 곱함
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              height: imageHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://image.tmdb.org/t/p/w600_and_h900_bestv2/cjEcqdRdPQJhYre3HUAc5538Gk8.jpg'),
                  fit: BoxFit.cover, // 이미지를 화면에 꽉 채우도록 설정
                ),
              ),
            ),
            Row(
              children: [
                Text('영화제목'),
                Text('개봉일'),
              ],
            ),
            Text('간단설명'),
            Text('러닝타임'),
            Container(
              child: Text('태그라인 리스트뷰'),
            ),
            Text('영화설명'),
            Text('흥행정보'),
            Container(
              child: Text('평점 리스트뷰뷰'),
            ),
            Container(
              child: Text('영화사이미지지 리스트뷰'),
            ),
          ],
        ),
      ),
    );
  }
}
