import 'package:flutter/material.dart';
import 'package:movie_information_app/ui/detail_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 화면의 너비를 가져옵니다.
    final screenWidth = MediaQuery.of(context).size.width;

    // 이미지의 가로세로 비율에 따라 높이를 계산합니다 (예: 2:3 비율).
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
              GestureDetector(
                //**********임시 이동코드
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DetailPage()));
                },
                child: Container(
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
              Container(
                height: 180,
                width: double.infinity,
                // child: ListView.builder(itemBuilder: itemBuilder),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '인기순순',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 180,
                width: double.infinity,
                // child: ListView.builder(itemBuilder: itemBuilder),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '평점 높은순순',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 180,
                width: double.infinity,
                // child: ListView.builder(itemBuilder: itemBuilder),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '개봉예정정',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 180,
                width: double.infinity,
                // child: ListView.builder(itemBuilder: itemBuilder),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
