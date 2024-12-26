class Genre {
  final int id;
  final String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      name: json['name'],
    );
  }
}

class ProductionCompany {
  final int id;
  final String name;
  final String? logoPath;
  final String originCountry;

  ProductionCompany({
    required this.id,
    required this.name,
    this.logoPath,
    required this.originCountry,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) {
    return ProductionCompany(
      id: json['id'],
      name: json['name'],
      logoPath: json['logo_path'],
      originCountry: json['origin_country'],
    );
  }
}

class MovieDetailDto {
  final bool adult;
  final String backdropPath;
  final List<Genre> genres;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final List<ProductionCompany> productionCompanies;
  final String releaseDate;
  final int revenue;
  final int runtime;
  final List<String> spokenLanguages;
  final String status;
  final String tagline;
  final String title;
  final double voteAverage;
  final int voteCount;
  final int budget; // budget 필드 추가

  MovieDetailDto({
    required this.adult,
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
    required this.budget,
  });

  factory MovieDetailDto.fromJson(Map<String, dynamic> json) {
    var genresList = (json['genres'] as List)
        .map((e) => Genre.fromJson(e))
        .toList(); // Genre 객체로 변환
    var productionCompaniesList = (json['production_companies'] as List)
        .map((e) => ProductionCompany.fromJson(e))
        .toList(); // ProductionCompany 객체로 변환
    var spokenLanguagesList = List<String>.from(json['spoken_languages']
        .map((language) => language['name'])); // List<String>으로 변환

    return MovieDetailDto(
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      genres: genresList,
      id: json['id'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: json['popularity'].toDouble(),
      posterPath: json['poster_path'],
      productionCompanies: productionCompaniesList,
      releaseDate: json['release_date'],
      revenue: json['revenue'],
      runtime: json['runtime'],
      spokenLanguages: spokenLanguagesList,
      status: json['status'],
      tagline: json['tagline'],
      title: json['title'],
      voteAverage: json['vote_average'].toDouble(),
      voteCount: json['vote_count'],
      budget: json['budget'],
    );
  }
}
