import 'package:flutter/material.dart';
import 'package:movie_information_app/ui/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(), //다크모드 기본 설정
      home: HomePage(),
    );
  }
}