class TvShowsResponse {
  final int page;
  final List<TvShowTvShowsDB> results;
  final int totalPages;
  final int totalResults;

  TvShowsResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TvShowsResponse.fromJson(Map<String, dynamic> json) =>
      TvShowsResponse(
        page: json["page"],
        results: List<TvShowTvShowsDB>.from(
          json["results"].map((x) => TvShowTvShowsDB.fromJson(x)),
        ),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class TvShowTvShowsDB {
  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalName;
  final String? overview;
  final double popularity;
  final String? posterPath;
  final DateTime? firstAirDate;
  final String name;
  final double voteAverage;
  final int voteCount;

  TvShowTvShowsDB({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    this.firstAirDate,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  factory TvShowTvShowsDB.fromJson(Map<String, dynamic> json) =>
      TvShowTvShowsDB(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        firstAirDate:
            json["first_air_date"] != null &&
                json["first_air_date"].toString().isNotEmpty
            ? DateTime.parse(json["first_air_date"])
            : null,
        name: json["name"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "id": id,

    "original_name": originalName,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "first_air_date":
        "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}",
    "name": name,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}
