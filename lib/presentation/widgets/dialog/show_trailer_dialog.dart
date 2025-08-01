import 'package:flutter/material.dart';
import 'package:movieflex/presentation/providers/movies/video_movie_provider.dart';
import 'package:movieflex/presentation/widgets/videos/videos_from_movie.dart';

void showTrailerDialog(BuildContext context, int movieId, MediaType type) {
  // final colors = Theme.of(context).colorScheme;
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black87.withOpacity(0.7),
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: const EdgeInsets.all(16),
        backgroundColor: const Color.fromARGB(255, 39, 39, 39),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(
            children: [
              //*Mostar video
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Center(
                    child: VideosFromMovie(movieId: movieId, type: type),
                  ),
                ),
              ),

              //*Boton de Cerrar()
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.8),
                        offset: Offset(2, 3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  tooltip: 'Close',
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
