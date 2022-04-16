import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Upside extends StatelessWidget {
  const Upside({Key? key, required this.imgUrl}) : super(key: key);
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SizedBox(
          width: size.width,
          height: size.height,
          //color: kPrimaryColor,
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Image.asset(
              imgUrl,
              alignment: Alignment.topCenter,
              scale: 4,
            ),
          ),
        ),
        //iconBackButton(context),
        // Positioned(
        //   left: 0,
        //   top: 175,
        //   child: Image.asset("assets/images/captain.png"),
        // ),
        // Positioned(
        //   right: 0,
        //   top: 60,
        //   child: Image.network(
        //     "https://ouch-cdn2.icons8.com/vKz7XNZvZiNKlkUWT2HjP8oNZ8hZ0UblhuF8J6sGRGI/rs:fit:196:112/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvNjg3/LzA3ZDZiZjRmLWFj/OTYtNGRmMy05ZGYz/LTNhNWQzOWI5NGYz/MC5zdmc.png",
        //     scale: 3,
        //   ),
        // ),
      ],
    );
  }
}

iconBackButton(BuildContext context) {
  return IconButton(
    color: Colors.white,
    iconSize: 28,
    icon: const Icon(CupertinoIcons.arrow_left),
    onPressed: () {
      Navigator.pop(context);
    },
  );
}
