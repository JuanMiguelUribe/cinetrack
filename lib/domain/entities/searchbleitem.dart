class SearchableItem {
  final int id;
  final String title;
  final String posterPath;
  final String type; // 'movie' o 'tv'
  final String overview;
  final double popularity;

  SearchableItem({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.type,
    required this.overview,
    required this.popularity,
  });
}
