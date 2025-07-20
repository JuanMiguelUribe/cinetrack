import 'package:cinetrack/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MovieHorizontalListView extends StatelessWidget {
  final List<Movie> movies;
  final String? title;
  final String? subtitle;
  final VoidCallback? loadNextPage;
  const MovieHorizontalListView(required List<Movie> movies, {
    super.key,
    required this.movies,
    this.title,
    this.subtitle, this.loadNextPage,
  });
  String getFormattedDate() {
    final now = DateTime.now();
    final formatter = DateFormat('EEEE, d MMMM', 'es_ES');
    String fecha = formatter.format(now);
    return fecha[0].toUpperCase() + fecha.substring(1); // Capitalizar
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(title!, style: Theme.of(context).textTheme.titleLarge),
        if (subtitle != null)
          Text(subtitle!, style: Theme.of(context).textTheme.labelMedium),
        // Si quieres mostrar la fecha en vez de un subtitle personalizado:
        Text(getFormattedDate(), style: Theme.of(context).textTheme.labelSmall),
        // Aquí iría la lógica de mostrar los ítems horizontalmente
      ],
    );
  }
}
