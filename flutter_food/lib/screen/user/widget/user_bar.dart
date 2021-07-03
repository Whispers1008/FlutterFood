import 'package:flutter/material.dart';
import 'package:flutter_food/constant.dart';
import 'package:flutter_food/screen/home/home_screen.dart';

class UserBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserBarState();
  }
}

class _UserBarState extends State<UserBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 28, right: 28),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            Global.userName,
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
          ),
          RaisedButton(
            onPressed: () {
              setState(() {
                Global.isLogin = false;
                Global.userName = "登录/注册";
              });
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  HomeScreen()), (Route<dynamic> route) => false);
            },
            child: Text("退出登录"),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/images/user.png',
              width: 60,
              height: 60,
            ),
          ),
        ],
      ),
    );
  }
}
