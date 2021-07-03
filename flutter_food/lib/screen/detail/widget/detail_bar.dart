import 'package:cloudbase_auth/cloudbase_auth.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_function/cloudbase_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food/adapter.dart';
import 'package:flutter_food/constant.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailBar extends StatefulWidget{
  final Map food_item;

  const DetailBar({
    Key? key,
    required this.food_item,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DetailBarState();
  }
}

class _DetailBarState extends State<DetailBar>{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Container(
              height: 240,
              width: Adapt.screenW(),
              child: Image.network(
                widget.food_item['pic_url'],
                fit: BoxFit.cover,
              ),
            ),
          ),
          AppBar(
            iconTheme: IconThemeData(color: mPrimaryColor),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          Positioned(
              right: 10,
              top: 220,
              height: 40,
              width: 40,
              child: RawMaterialButton(
                onPressed: () {
                  addPreference();
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text("点赞成功！"),
                        );
                      });
                },
                fillColor: mGrayColor,
                child: SvgPicture.asset(
                  'assets/images/like.svg',
                  width: 20,
                  height: 20,
                ),
                padding: EdgeInsets.all(0.0),
                shape: CircleBorder(),
              ))
        ],
      ),
    );
  }

  Future<void> addPreference() async {
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
    CloudBaseResponse res = await cloudbase.callFunction('add_preference', data);

  }

}