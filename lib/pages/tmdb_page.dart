import 'package:flutter/material.dart';
import 'package:movies_app/components/utils.dart';
import 'package:movies_app/constants.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TMDBList extends StatefulWidget {
  TMDBList({Key? key}) : super(key: key);

  @override
  State<TMDBList> createState() => _TMDBListState();
}

class _TMDBListState extends State<TMDBList> {
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
    return Scaffold(
        //backgroundColor: background,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 15,
          title: const Text('TMDB Film Listesi'),
          // leading: const Icon(Icons.menu),
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.search),
            ),
          ],
          backgroundColor: secondary,
        ),
        body: getBody());
  }

  Widget getBody() {
    return StaggeredGridView.countBuilder(
        staggeredTileBuilder: (index) => StaggeredTile.fit(1),
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        itemCount: trendingMovies.length,
        itemBuilder: (context, index) {
          return buildImageCard(index);
        });
  }

  Widget buildImageCard(int index) {
    return GestureDetector(
      onTap: () {
        showGeneralDialog(
            context: context,
            barrierLabel: "Barrier",
            barrierDismissible: true,
            barrierColor: Colors.black.withOpacity(0.5),
            transitionDuration: Duration(milliseconds: 700),
            pageBuilder: (_, __, ___) {
              return Center(
                child: Container(
                  height: 450,
                  child: SizedBox.expand(
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: SizedBox(
                              height: 250,
                              child: Image.network(
                                'https://image.tmdb.org/t/p/w500' +
                                    trendingMovies[index]['poster_path'],
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.arrow_drop_down_circle),
                            title: Text(trendingMovies[index]['title']),
                            subtitle: Text(
                              'Secondary Text',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  // Respond to button press
                                },
                                icon: Icon(Icons.add, size: 10),
                                label: Text("Beğen"),
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  // Respond to button press
                                },
                                icon: Icon(Icons.add, size: 10),
                                label: Text("İzlendi"),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                ),
              );
            },
            transitionBuilder: (_, anim, __, child) {
              Tween<Offset> tween;
              if (anim.status == AnimationStatus.reverse) {
                tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
              } else {
                tween = Tween(begin: Offset(1, 0), end: Offset.zero);
              }

              return SlideTransition(
                position: tween.animate(anim),
                child: FadeTransition(
                  opacity: anim,
                  child: child,
                ),
              );
            });
      },
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          margin: EdgeInsets.all(8),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Column(
                children: [
                  Image.network(
                    'https://image.tmdb.org/t/p/w500' +
                        trendingMovies[index]['poster_path'],
                    fit: BoxFit.contain,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      trendingMovies[index]['title'] != null
                          ? trendingMovies[index]['title']
                          : 'Null',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
