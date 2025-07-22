import 'package:flutter/material.dart';

class MovieScreen extends StatelessWidget {
  final String movieId;
  static const name = "movie-screen";
  const MovieScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('MovieId $movieId')));
  }
}
