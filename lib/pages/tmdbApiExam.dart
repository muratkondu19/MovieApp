import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';

class TmdbApiPage extends StatefulWidget {
  TmdbApiPage({Key? key}) : super(key: key);

  @override
  State<TmdbApiPage> createState() => _TmdbApiPageState();
}

class _TmdbApiPageState extends State<TmdbApiPage> {
  List trendingMovies = [];
  List topRatedMovies = [];
  List tv = [];
  final String apiKey = "8b4da0c95706d4305f05cf1247ee6d14";
  final readAccessToken =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4YjRkYTBjOTU3MDZkNDMwNWYwNWNmMTI0N2VlNmQxNCIsInN1YiI6IjYyNTNmNTgyYWI2ODQ5MDY1NDk4ODkxYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.5nUj8-5FRYb04sr7yF-r9H36x3xwDdlyH1XPH3Vozb8";

  @override
  void initState() {
    loadMovies();
    super.initState();
  }

  loadMovies() async {
    TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apiKey, readAccessToken),
        logConfig: ConfigLogger(showLogs: true, showErrorLogs: true));

    Map trendingResult = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topRatedTesult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map tvResult = await tmdbWithCustomLogs.v3.tv.getPopular();

    setState(() {
      trendingMovies = trendingResult['results'];
      topRatedMovies = topRatedTesult['results'];
      tv = tvResult['results'];
    });
    print(trendingMovies);
    // print(topRatedMovies);
    // print(tv);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
