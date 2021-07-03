import 'package:flutter/material.dart';
import 'package:flutter_food/constant.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemIngredient extends StatelessWidget {
  final List ingredients;

  const ItemIngredient({
    Key? key,
    required this.ingredients,
  }) : super(key: key);

  // 食材
  Widget buildGrid() {
    List<Widget> tiles = [];
    Widget content;
    for (var item in ingredients) {
      tiles.add(Row(
        children: [
          SvgPicture.asset(
            'assets/images/dot.svg',
            width: 16,
            height: 16,
          ),
          Text(item),
        ],
      ));
    }
    content = new GridView.count(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      mainAxisSpacing: 1.0,
      crossAxisCount: 2,
      children: tiles,
      childAspectRatio: 20 / 2,
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
              "食材",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: mPrimaryColor,
              ),
            ),
          ),
          buildGrid(),
        ],
      ),
    );
  }
}