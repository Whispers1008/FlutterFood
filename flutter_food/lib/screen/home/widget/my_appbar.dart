import 'package:flutter/material.dart';
import 'package:flutter_food/constant.dart';
import 'package:flutter_food/screen/login/login_screen.dart';
import 'package:flutter_food/screen/user/user_screen.dart';

class MyAppbar extends StatelessWidget {
  const MyAppbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 22.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'Hi, ',
                  style: TextStyle(fontSize: 22.0),
                ),
                GestureDetector(
                  child: Text(
                    Global.isLogin ? Global.userName : "注册/登录",
                    style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.indigoAccent,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    if (Global.isLogin) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserScreen()));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    }
                  },
                ),
                Text(
                  ' !',
                  style: TextStyle(fontSize: 22.0),
                ),
              ],
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
      ),
    );
  }
}
