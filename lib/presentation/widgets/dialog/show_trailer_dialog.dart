import 'package:flutter/material.dart';
import 'package:movieflex/presentation/widgets/videos/videos_from_movie.dart';

void showTrailerDialog(BuildContext context, int movieId) {
  final colors = Theme.of(context).colorScheme;
  showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black87.withOpacity(0.7),
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: const EdgeInsets.all(16),
        backgroundColor: colors.surface,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Center(child: VideosFromMovie(movieId: movieId)),
          ),
        ),
      );
    },
  );
}
