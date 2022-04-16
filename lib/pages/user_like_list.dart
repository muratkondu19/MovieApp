import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/widgets/sliver_appbar.dart';

import 'package:rive/rive.dart';

import '../components/utils.dart';
import '../model/slidable_action.dart';

class UserLikeList extends StatefulWidget {
  const UserLikeList({Key? key}) : super(key: key);

  @override
  State<UserLikeList> createState() => _UserLikeListState();
}

class _UserLikeListState extends State<UserLikeList> {
  List<String> titles = ["List 1", "List 2", "List 3"];
  final subtitles = [
    "Here is list 1 subtitle",
    "Here is list 2 subtitle",
    "Here is list 3 subtitle"
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: background,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 15,
          title: const Text('IMBD Film Listesi'),
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.search),
            ),
          ],
          backgroundColor: secondary,
        ),
        body: getBody(),
      ),
    );
  }

  Widget getBody() {
    return CustomScrollView(slivers: [
      // SilverBar(
      //   appbarText: "Beğeni Listem",
      // ),
      // const SliverToBoxAdapter(
      //   child: SizedBox(
      //     height: 20,
      //     child: Center(
      //       child: Text('Scroll to see the SliverAppBar in effect.'),
      //     ),
      //   ),
      // ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Card(
                  elevation: 6,
                  child: Slidable(
                    key: Key(titles.toString()),
                    dismissal: SlidableDismissal(
                      child: SlidableDrawerDismissal(),
                      onDismissed: (type) {
                        final action = type == SlideActionType.primary
                            ? SlidableAction.liked
                            : SlidableAction.delete;
                        onDismissed(index, action);
                      },
                    ),
                    child: buildListTile(titles),
                    actionPane: const SlidableDrawerActionPane(),
                    //SlidableDrawerActionPane()
                    //SlidableStrechActionPane()
                    //SlidableScrollActionPane()
                    //SlidableDrawerActionPane()

                    actionExtentRatio: 0.25,
                    //actionExtentRatio: 0.1,
                    //actionExtentRatio: 0.5,
                    actions: [
                      IconSlideAction(
                        caption: 'İzlenenlere Ekle',
                        color: Colors.indigo,
                        icon: Icons.list,
                        onTap: () => onDismissed(index, SlidableAction.list),
                      )
                    ],
                    secondaryActions: [
                      IconSlideAction(
                        caption: 'İzleneceklere Ekle',
                        color: Colors.green,
                        icon: Icons.favorite_outline,
                        onTap: () => onDismissed(index, SlidableAction.share),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
          childCount: 20,
        ),
      )
    ]);
  }

  void onDismissed(int index, SlidableAction action) {
    final item = titles;
    //setState(() => titles.removeAt(index));

    switch (action) {
      case SlidableAction.liked:
        Utils.showSnackBar(context, '${titles} has been ordered.');
        break;
      case SlidableAction.share:
        Utils.showSnackBar(context, '${titles} has been shared.');
        break;
      case SlidableAction.list:
        Utils.showSnackBar(context, 'Added to wishlist.');
        break;
      case SlidableAction.delete:
        Utils.showSnackBar(context, '${titles} has been deleted.');
        break;
    }
  }

  Widget buildListTile(titles) => Column(
        children: <Widget>[
          GestureDetector(
            child: Row(
              children: [
                Hero(
                  tag: const Icon(Icons.star),
                  child: Container(
                    height: 150,
                    width: 100,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        topLeft: Radius.circular(5),
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          "https://images.unsplash.com/photo-1547721064-da6cfb341d50",
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  height: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'TİTLE',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 240,
                        child: Text(
                          'TEXT',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}
