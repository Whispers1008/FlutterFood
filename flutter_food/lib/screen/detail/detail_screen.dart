import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food/screen/detail/widget/detail_bar.dart';
import 'package:flutter_food/screen/detail/widget/item_direction.dart';
import 'package:flutter_food/screen/detail/widget/item_ingredient.dart';
import 'package:flutter_food/screen/detail/widget/item_title.dart';

class DetailScreen extends StatefulWidget {
  final Map food_item;

  const DetailScreen({
    Key? key,
    required this.food_item,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DetailScreenState();
  }
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DetailBar(food_item: widget.food_item),
            ItemTitle(title: widget.food_item['title'],author: widget.food_item['author'],),
            SizedBox(
              height: 24,
            ),
            ItemIngredient(
              ingredients: widget.food_item['ingredients'],
            ),
            SizedBox(
              height: 24,
            ),
            ItemDirection(
              directions: widget.food_item['directions'],
            ),
          ],
        ),
      ),
    );
  }
}


