import 'package:flutter/material.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/widgets/custom_search_field.dart';
import 'package:rive/rive.dart';

class SilverBar extends StatefulWidget {
  const SilverBar({
    Key? key,
    required this.appbarText,
  }) : super(key: key);

  final String appbarText;

  @override
  State<SilverBar> createState() => _SilverBarState();
}

class _SilverBarState extends State<SilverBar> {
  @override
  Widget build(BuildContext context) {
    TabController _tabController;

    return SliverAppBar(
      pinned: true,
      snap: false,
      floating: true,
      expandedHeight: 150.0,
      elevation: 20,
      backgroundColor: secondary,

      flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text(
            widget.appbarText,
            style: const TextStyle(
                color: textWhite,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontFamily: fontFamiy),
          ),
          background: Column(
            children: [
              // const RiveAnimation.asset(
              //     'assets/animation/1423-2780-lights.riv'),
              Padding(
                padding: const EdgeInsets.only(top: 50, right: 30, left: 30),
                child: CustomSearchField(
                  hintField: "Aramak için tıklayınız...",
                  backgroundColor: background,
                ),
              )
            ],
          )),
      // bottom: AppBar(
      //   title: Container(
      //     height: 45,
      //     child: TextField(
      //       decoration: InputDecoration(
      //           border: OutlineInputBorder(), hintText: 'Enter a search term'),
      //     ),
      //   ),
      // ),
    );
  }
}
