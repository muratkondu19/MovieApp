import 'package:flutter/material.dart';
import 'package:movies_app/constants.dart';

class CustomMovieCardExoand extends StatefulWidget {
  const CustomMovieCardExoand({
    Key? key,
    required this.thumbNail,
    required this.title,
    required this.userName,
  }) : super(key: key);

  final String thumbNail;
  final String title;
  final String userName;

  @override
  _CustomMovieCardExoandState createState() => _CustomMovieCardExoandState();
}

class _CustomMovieCardExoandState extends State<CustomMovieCardExoand> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width * .6,
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.all(7.0),
      decoration: BoxDecoration(
        color: textWhite,
        borderRadius: BorderRadius.circular(17.0),
        boxShadow: [
          BoxShadow(
            color: textBlack.withOpacity(0.1),
            blurRadius: 10.0,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              SizedBox(
                height: size.width * .7,
                width: size.width * .5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset(
                    widget.thumbNail,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15.0),
          Container(
            padding: const EdgeInsets.only(
              left: 7.0,
              right: 7.0,
            ),
            child: Text(
              widget.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: secondary,
                fontSize: 17.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 15.0),
          Padding(
            padding: const EdgeInsets.only(
              left: 7.0,
              right: 7.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    width: size.width,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.userName,
                      style: const TextStyle(
                        color: secondary,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}

class CustomCourseCardShrink extends StatefulWidget {
  const CustomCourseCardShrink({
    Key? key,
    required this.thumbNail,
    required this.title,
    required this.userName,
  }) : super(key: key);

  final String thumbNail;
  final String title;
  final String userName;

  @override
  _CustomCourseCardShrinkState createState() => _CustomCourseCardShrinkState();
}

class _CustomCourseCardShrinkState extends State<CustomCourseCardShrink> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.width * .2,
      padding: const EdgeInsets.all(15.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: textWhite,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          SizedBox(
            height: size.width * .125,
            width: size.width * .125,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                widget.thumbNail,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 15.0),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: secondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Instructor: ' + widget.userName,
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
