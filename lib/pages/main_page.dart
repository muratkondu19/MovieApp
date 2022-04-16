import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/pages/dashboard.dart';
import 'package:movies_app/pages/imdb_list.dart';
import 'package:movies_app/pages/profile_page.dart';
import 'package:movies_app/pages/tmdb_page.dart';
import 'package:movies_app/pages/user_like_list.dart';
import 'package:movies_app/pages/user_movie_list_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: getFooter(),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: [
        Dashboard(),
        TMDBList(),
        //IMDBList(),
        UserMovieList(),
        ProfilePage(),
      ],
    );
  }

  Widget getFooter() {
    List items = [
      "assets/svg/home_icon.svg",
      "assets/svg/movie-svgrepo-com.svg",
      "assets/svg/list-svgrepo-com.svg",
      "assets/svg/user_icon.svg"
    ];
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 70,
      decoration: BoxDecoration(color: secondary, boxShadow: [
        BoxShadow(
            color: textWhite.withOpacity(0.12),
            blurRadius: 30,
            offset: const Offset(0, -10))
      ]),
      child: Padding(
        padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(items.length, (index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    pageIndex = index;
                  });
                },
                child: Column(
                  children: [
                    SvgPicture.asset(
                      items[index],
                      height: 17.5,
                      color: pageIndex == index ? textWhite : textBlack,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    pageIndex == index
                        ? AnimatedContainer(
                            duration: const Duration(microseconds: 500),
                            height: 5,
                            width: 20,
                            decoration: BoxDecoration(
                                color: textWhite,
                                borderRadius: BorderRadius.circular(100)),
                          )
                        : Container()
                  ],
                ),
              );
            })),
      ),
    );
  }
}
