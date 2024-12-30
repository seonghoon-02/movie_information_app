<h1  align="center">
<p  align="center">영화 정보 앱

</h1>
</p>

## 프로젝트 개요

### 클린 아키텍처를 기반으로 TMDB API 데이터 가져오기

### Hero 위젯을 사용해 애니메이션 적용하기

#### 💡 '영화 정보 앱'은 제작하면서 flutter 심화 과정을 익히기 위해 만들어졌습니다.

## 팀원 구성

| **고성훈** |

### 프로젝트 일정

24/12/24~24/12/30

### 사용 기술

| Riverpod | Dotenv | TMDB API | DIO | inappwebview | 클린 아키텍쳐 |

## 주요 기능

| 홈 화면                  | 상세 화면                  |
| ------------------------ | -------------------------- |
| 인기순 영화 리스트       | 선택한 영화 상세 정보 화면 |
| 현재 상영 영화 리스트    | 영화 줄거리                |
| 평점 높은 순 영화 리스트 | 흥행 정보                  |
| 개봉 예정 영화 리스트    | 비슷한 영화 리스트         |

## 사용한 API

- 현재 상영중 리스트 : [https://developer.themoviedb.org/reference/movie-now-playing-list](https://developer.themoviedb.org/reference/movie-now-playing-list)
- 인기순 리스트 : [https://developer.themoviedb.org/reference/movie-popular-list](https://developer.themoviedb.org/reference/movie-popular-list)
- 평점 높은순 리스트 : [https://developer.themoviedb.org/reference/movie-top-rated-list](https://developer.themoviedb.org/reference/movie-top-rated-list)
- 개봉 예정 리스트 : [https://developer.themoviedb.org/reference/movie-upcoming-list](https://developer.themoviedb.org/reference/movie-upcoming-list)
- 영화 상세 정보 : [https://developer.themoviedb.org/reference/movie-details](https://developer.themoviedb.org/reference/movie-details)
- 비슷한 영화 리스트 : [https://developer.themoviedb.org/reference/movie-similar](https://developer.themoviedb.org/reference/movie-similar)

<br/>

## TroubleShooting

#### listview 사이즈 초과 이슈

1. 문제 정의

- 페이지를 이동할 때 hero위젯을 사용하여 애니매이션을 구현하는데 오류 발생 .

2. 사실 수집

- 히어로 위젯은 tag의 유일성이 중요함

3. 원인 추론

- api에서 전달 받은 영화 각각의 id를 이용하여 개선하면 될 것으로 생각

4. 조사 방법 결정

- 구글 검색, 챗gpt 이용, 튜터님께 문의

5. 조사 방법 구현

- id 값으로 tag 구성 → 효과 없음

- id + 문자열로 tag 구성 → 효과 없음

- 제일 큰 이미지와 리스트 이미지를 분리하여 디테일 페이지를 2파일로 만듬.

  tag를 큰이미지만 id를 사용하지 않음 →

  큰 이미지를 통해 들어갈 때만 오류 생기지 않음

- tag를 카테고리 + id로 구성. 메인 화면 전체에 중복 값 없도록 수정 → 정상 작동

6. 결과 관찰

- 상세페이지에서 메인페이지로 돌아올 때에만 문제 생길거라 예상했으나

  메인페이지에서 상세페이지로 갈 때에도 태그 중복 오류가 발생한 것을 확인.

- 정확한지는 모르겠으나 히어로 위젯 동작 시 해당 페이지의 태그를 전체 확인하는 것으로 생각됨.
