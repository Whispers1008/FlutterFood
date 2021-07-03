// ignore: import_of_legacy_library_into_null_safe
import 'package:cloudbase_auth/cloudbase_auth.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_function/cloudbase_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food/constant.dart';
import 'package:flutter_food/screen/widget/rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FoodItem extends StatefulWidget {
  final Map food_item;
  final bool check;

  const FoodItem({
    Key? key,
    required this.food_item,
    this.check = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FoodItemState();
  }

}

class _FoodItemState extends State<FoodItem> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 168,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: widget.check
                  ? mPrimaryColor.withOpacity(0.3)
                  : mPrimaryColor.withOpacity(0.03),
              offset: Offset(0, 10),
              blurRadius: 10,
              spreadRadius: 1.5,
            )
          ]),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.network(
              widget.food_item["pic_url"],
              width: 138,
              height: 138,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width:140,
                  child: Text(
                    widget.food_item['title'],
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
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
                          widget.food_item['time_use'],
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 6.0,
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
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: mPrimaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: GestureDetector(
                    child: SvgPicture.asset(
                      'assets/images/car.svg',
                      width: 18,
                      height: 18,
                    ),
                    onTap: () {
                      collectRecipe();
                      // 目前只是实现点击有反应

                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> collectRecipe() async {
    CloudBaseCore core = CloudBaseCore.init({
      'env': 'hello-cloudbase-9gmoljho0dd9d4c1',
      'appAccess': {'key': '19e089b73f596c14dc6aed441867cb83', 'version': '1'}
    });

    // 匿名登录
    CloudBaseAuth auth = CloudBaseAuth(core);
    CloudBaseAuthState authState = await auth.getAuthState();

    if (authState == null) {
      await auth.signInAnonymously();
    }

    CloudBaseFunction cloudbase = CloudBaseFunction(core);

    // 请求参数
    Map<String, dynamic> data = {'name': Global.userName, 'item':widget.food_item};
    CloudBaseResponse res = await cloudbase.callFunction('collect', data);

    if(res.data['err']==-1){
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text("收藏失败"),
        ),
      );
    }else{
      print(res);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('收藏成功！'),
          );
        },
      );
    }
  }
}
