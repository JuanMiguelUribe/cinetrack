class SearchableItem {
  final int id;
  final String title;
  final String posterPath;
  final String type; // 'movie' o 'tv'

  SearchableItem({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.type,
  });
}
