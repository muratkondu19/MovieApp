import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/model/api_service.dart';
import 'package:movies_app/model/movie.dart';
import 'package:movies_app/widgets/custom_card.dart';
import 'package:movies_app/widgets/sliver_appbar.dart';

import 'package:rive/rive.dart';

import '../components/utils.dart';
import '../model/slidable_action.dart';

class IMDBList extends StatefulWidget {
  IMDBList({Key? key}) : super(key: key);
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  State<IMDBList> createState() => _IMDBListState();
}

class _IMDBListState extends State<IMDBList> {
  ApiService service = ApiService.getInstance();
  List<Movie> movieList = [];
  final user = FirebaseAuth.instance.currentUser!;
  int _selectedDestination = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: background,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 15,
          title: const Text('IMBD Film Listesi'),
          // leading: const Icon(Icons.menu),
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.search),
            ),
          ],
          backgroundColor: secondary,
        ),
        body: getBody(),
        drawer: Row(
          children: [
            Drawer(
              child: ListView(
                padding: const EdgeInsets.only(top: 50),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ListTile(
                      leading: SizedBox(
                        height: spacer,
                        width: spacer,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(user.photoURL!),
                        ),
                      ),
                      title: Text(user.displayName.toString()),
                      subtitle: Text(user.email.toString()),
                    ),
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  ListTile(
                    leading: SizedBox(
                        child: SvgPicture.asset(
                      "assets/svg/home_icon.svg",
                      height: 20,
                    )),
                    title: const Text('Ana Sayfa'),
                    selected: _selectedDestination == 0,
                    onTap: () => selectDestination(0),
                  ),
                  ListTile(
                    leading: SizedBox(
                        child: SvgPicture.asset(
                      "assets/svg/movie-svgrepo-com.svg",
                      height: 20,
                    )),
                    title: const Text('Film Listesi'),
                    selected: _selectedDestination == 1,
                    onTap: () => selectDestination(1),
                  ),
                  ListTile(
                    leading: SizedBox(
                        child: SvgPicture.asset(
                      "assets/svg/list-svgrepo-com.svg",
                      height: 20,
                    )),
                    title: const Text('Listem'),
                    selected: _selectedDestination == 2,
                    onTap: () => selectDestination(2),
                  ),
                  ListTile(
                    leading: SizedBox(
                        child: SvgPicture.asset(
                      "assets/svg/user_icon.svg",
                      height: 20,
                    )),
                    title: const Text('Profil'),
                    selected: _selectedDestination == 2,
                    onTap: () => selectDestination(2),
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Label',
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.bookmark),
                    title: const Text('Item A'),
                    selected: _selectedDestination == 3,
                    onTap: () => selectDestination(3),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }

  Widget getBody() {
    return FutureBuilder<List<Movie>>(
        future: service.getImdbMovie(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              movieList = snapshot.data!;
              return listView();

            default:
              return Center(
                child: Container(
                  padding: const EdgeInsets.all(75),
                  child: const LinearProgressIndicator(
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
          child: Slidable(
            key: Key(movieList[index].key.toString()),
            dismissal: SlidableDismissal(
              child: const SlidableDrawerDismissal(),
              onDismissed: (type) {
                final action = type == SlideActionType.primary
                    ? SlidableAction.list
                    : SlidableAction.liked;
                onDismissed(index, action);
              },
            ),
            actionPane: const SlidableDrawerActionPane(),
            actions: [
              IconSlideAction(
                caption: '??zlenenlere Ekle',
                color: Colors.indigo,
                icon: Icons.list,
                onTap: () =>
                    {Utils.showSnackBar(context, '??zlenenlere eklendi.')},
              )
            ],
            secondaryActions: [
              IconSlideAction(
                caption: 'Be??enilenlere Ekle',
                color: Colors.green,
                icon: Icons.favorite_outline,
                onTap: () async {
                  onDismissed(index, SlidableAction.liked);
                },
              ),
            ],
            child: GestureDetector(
              child: Column(
                children: [
                  ListTile(
                    leading: Image.network(movieList[index].posterLink),
                    title: Text(movieList[index].seriesTitle),
                    subtitle: Text(
                      movieList[index].director,
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                    // trailing: Column(children: [
                    //   Icon(Icons.favorite_outline),
                    //   Icon(Icons.list)
                    // ]),

                    trailing: Column(
                      children: [
                        if (movieList[index].like == true) ...[
                          Icon(
                            Icons.favorite_outline,
                            color: Colors.red,
                          ),
                        ] else ...[
                          Icon(
                            Icons.favorite,
                          ),
                        ],
                      ],
                    ),
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
                        avatar: const Icon(Icons.star),
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
          )),
    );
  }

  Future<void> onDismissed(int index, SlidableAction action) async {
    final item = movieList;
    setState(() => movieList.removeAt(index));

    switch (action) {
      case SlidableAction.liked:
        var model = Movie(
            seriesTitle: movieList[index].seriesTitle,
            posterLink: movieList[index].posterLink,
            releasedYear: movieList[index].releasedYear,
            certificate: movieList[index].certificate,
            runtime: movieList[index].runtime,
            overview: movieList[index].overview,
            metaScore: movieList[index].metaScore,
            noOfVotes: movieList[index].noOfVotes,
            gross: movieList[index].gross,
            star1: movieList[index].star1,
            star2: movieList[index].star2,
            star3: movieList[index].star3,
            star4: movieList[index].star4,
            director: movieList[index].director,
            genre: movieList[index].genre,
            iMDBRating: movieList[index].iMDBRating,
            useruid: user.uid,
            like: true,
            list: false);
        await ApiService.getInstance().likeImdbMovie(model);
        print("like : ${movieList[index].like}");
        Utils.showSnackBar(
            context, '${movieList[index].seriesTitle} be??enilenlere eklendi.');
        break;
      case SlidableAction.share:
        Utils.showSnackBar(context, ' has been shared.');
        break;
      case SlidableAction.list:
        Utils.showSnackBar(context, 'Added to wishlist.');
        break;
      case SlidableAction.delete:
        Utils.showSnackBar(context, ' Be??enilenlerden kald??r??ld??.');

        break;
    }
  }
}
