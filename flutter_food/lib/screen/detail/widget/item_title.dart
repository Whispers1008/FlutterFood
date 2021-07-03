import 'package:flutter/material.dart';

class ItemTitle extends StatelessWidget {
  final String title;
  final String author;

  const ItemTitle({
    Key? key,
    required this.title, required this.author,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget>[
              Text(
                "By $author",
              )
            ]
          )
        ],
      ),
    );
  }
}