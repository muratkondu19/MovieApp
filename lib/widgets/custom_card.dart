import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final dynamic title;
  final dynamic subtitle;
  final String imageURL;

  const CustomCard(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.imageURL})
      : assert(imageURL != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      child: ListTile(
        title: Text(
          title.toString(),
        ),
        subtitle: Text(subtitle.toString()),
        trailing: imagePlace,
      ),
    );
  }

  Widget get imagePlace {
    return imageURL.isEmpty
        ? Container(
            width: 100,
            child: Placeholder(),
          )
        : Image.network(imageURL.toString());
  }
}
