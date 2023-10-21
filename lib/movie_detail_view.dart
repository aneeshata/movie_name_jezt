import 'package:flutter/material.dart';
import 'package:movie_name_jezt/movie_name_list_response.dart';

class MovieDetailView extends StatelessWidget {
  final MovieListResponse movieData; // Modify the constructor to accept the data

  MovieDetailView({required this.movieData});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Detail View Page'),
          Text('Titile ${movieData.title}')
        ],
      ),
    );
  }
}
