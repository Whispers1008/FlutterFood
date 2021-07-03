import 'package:flutter/material.dart';
import 'package:flutter_food/constant.dart';
import 'package:flutter_food/screen/detail/detail_screen.dart';
import 'package:flutter_food/screen/widget/rating_bar.dart';

class CardItem extends StatelessWidget {
  final Map item;

  const CardItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        shadowColor: mPrimaryColor,
        elevation: 5, //阴影
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        color: Colors.white, //颜色
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                child: Image.network(
                  item['pic_url'],
                  height: 138,
                  width: 138,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: 138,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        item['title'],
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "By " + item['author'],
                      ),
                      RatingBar(
                        onRatingUpdate: (value) {},
                        count: 5,
                        maxRating: 5,
                        value: 5,
                        selectColor: Colors.orange,
                        size: 12.0,
                        padding: 0,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.timer,
                            color: Colors.black54,
                            size: 18.0,
                          ),
                          SizedBox(
                            width: 6.0,
                          ),
                          Text(
                            item['time_use'],
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              food_item: item,
            ),
          ),
        )
      },
    );
  }
}
