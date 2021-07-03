import 'package:flutter/material.dart';
import 'package:flutter_food/constant.dart';

class ItemDirection extends StatelessWidget {
  final List directions;

  const ItemDirection({
    Key? key,
    required this.directions,
  }) : super(key: key);

  // 步骤
  Widget buildList() {
    int count = 1;
    List<Widget> tiles = [];
    Widget content;
    for (var item in directions) {
      tiles.add(Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              count.toString(),
              style: TextStyle(
                color: mOrangeColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            width: 20,
            height: 20,
          ),
          Expanded(
            child: Text(
              item,
            ),
          ),
        ],
      ));
      if (count <= directions.length) {
        tiles.add(
          SizedBox(
            height: 14,
          ),
        );
      }
      count++;
    }
    content = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: tiles,
    );
    return content;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Text(
              "步骤",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: mPrimaryColor,
              ),
            ),
          ),
          buildList(),
        ],
      ),
    );
  }
}