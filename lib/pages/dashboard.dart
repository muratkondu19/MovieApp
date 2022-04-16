import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/widgets/clipper.dart';
import 'package:movies_app/widgets/custom_heading.dart';
import 'package:movies_app/widgets/custom_movie_card.dart';
import 'package:movies_app/widgets/custom_promotion_card.dart';
import 'package:movies_app/widgets/custom_search_field.dart';
import 'package:movies_app/widgets/custom_title.dart';

class Dashboard extends StatelessWidget {
  Dashboard({Key? key}) : super(key: key);
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: background,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    final user = FirebaseAuth.instance.currentUser!;

    //).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              ClipPath(
                clipper: BottomClipper(),
                child: Container(
                  //width: size.width,
                  height: 300,
                  decoration: const BoxDecoration(color: secondary),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: appPadding, right: appPadding),
                child: Column(
                  children: [
                    const SizedBox(
                      height: spacer + 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomHeading(
                          title: "Selam " + user.displayName!,
                          subTitle: user.email!,
                          color: textWhite,
                        ),
                        SizedBox(
                          height: spacer,
                          width: spacer,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(user.photoURL!),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: spacer,
                    ),
                    const CustomSearchField(
                      hintField: "Aramak için tıklayınız...",
                      backgroundColor: background,
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: spacer,
          ),
          const CustomPromotionCard(),
          const SizedBox(
            height: spacer,
          ),
          const Padding(
            padding: EdgeInsets.only(right: appPadding, left: appPadding),
            child: CustomTitle(title: 'Öne Çıkanlar'),
          ),
          const SizedBox(
            height: smallSpacer,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: appPadding, top: 10, bottom: 30),
              child: Row(
                children: List.generate(4, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: CustomMovieCardExoand(
                      thumbNail: "assets/images/mrrobot.jpg",
                      title: 'Title',
                      userName: user.displayName!,
                    ),
                  );
                }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
