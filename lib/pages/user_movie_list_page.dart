import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/model/api_service.dart';
import 'package:movies_app/model/movie.dart';
import 'package:movies_app/widgets/custom_card.dart';
import 'package:movies_app/widgets/sliver_appbar.dart';

import 'package:rive/rive.dart';

import '../components/utils.dart';
import '../model/slidable_action.dart';

class UserMovieList extends StatefulWidget {
  const UserMovieList({Key? key}) : super(key: key);

  @override
  State<UserMovieList> createState() => _UserMovieListState();
}

class _UserMovieListState extends State<UserMovieList> {
  ApiService service = ApiService.getInstance();
  List<Movie> movieList = [];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: background,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 15,
          leading: const Icon(Icons.menu),
          title: const Text('Listem'),
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.search),
            ),
          ],
          backgroundColor: secondary,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Beğeniler', icon: Icon(Icons.favorite)),
              Tab(text: 'İzlenenler', icon: Icon(Icons.list)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: getBody()),
            Center(child: Text('CATS')),
          ],
        ),
      ),
    );
  }

  Widget getBody() {
    return FutureBuilder<List<Movie>>(
        future: service.getMyLikeMovie(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              movieList = snapshot.data!;
              return listView();

            default:
              return Center(
                child: Container(
                  padding: EdgeInsets.all(75),
                  child: LinearProgressIndicator(
                    color: secondary,
                  ),
                ),
              );
          }
        });
  }

  Widget listView() {
    return ListView.separated(
      itemCount: movieList.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) => Card(
        elevation: 15,
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            ListTile(
              leading: Image.network(movieList[index].posterLink),
              title: Text(movieList[index].seriesTitle),
              subtitle: Text(
                movieList[index].director,
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
              // trailing: Column(
              //     children: [Icon(Icons.favorite_outline), Icon(Icons.list)]),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                movieList[index].overview,
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                InputChip(
                  avatar: Icon(Icons.star),
                  label: Text(movieList[index].iMDBRating.toString()),
                  backgroundColor: Colors.amber,
                  onSelected: (bool value) {},
                ),
                InputChip(
                  // avatar: Icon(Icons.favorite_outline),
                  label: Text(movieList[index].genre),
                  backgroundColor: Colors.green,
                  onSelected: (bool value) {},
                ),

                InputChip(
                  //avatar: Icon(Icons.list),
                  label: Text(movieList[index].releasedYear.toString()),
                  backgroundColor: primary,
                  onSelected: (bool value) {},
                ),

                // FlatButton(
                //   textColor: const Color(0xFF6200EE),
                //   onPressed: () {
                //     // Perform some action
                //   },
                //   child: const Text('ACTION 1'),
                // ),
                // FlatButton(
                //   textColor: const Color(0xFF6200EE),
                //   onPressed: () {
                //     // Perform some action
                //   },
                //   child: const Text('ACTION 2'),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
