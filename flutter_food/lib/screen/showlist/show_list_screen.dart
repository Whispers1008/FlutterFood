import 'package:cloudbase_auth/cloudbase_auth.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_function/cloudbase_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food/constant.dart';
import 'package:flutter_food/screen/showlist/widget/card_item.dart';
import 'package:flutter_food/screen/widget/rating_bar.dart';

class ShowListScreen extends StatefulWidget {
  String menu_tag;

  ShowListScreen({
    Key? key,
    required this.menu_tag,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ShowListScreenState();
  }
}

class _ShowListScreenState extends State<ShowListScreen> {
  List cardList = [];

  Widget showList() {
    if (cardList != null && cardList.length != 0) {
      List<Widget> tiles = [];
      Widget content;
      for (var item in cardList) {
        tiles.add(
          CardItem(item: item)
        );
      }
      content = new Column(
        children: tiles,
      );
      return content;
    } else {
      return Center(child: Text("正在加载数据，请稍等..."));
    }
  }

  @override
  void initState() {
    super.initState();
    setCardList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Best For You",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: mBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: showList(),
      ),
    );
  }

  Future<void> setCardList() async {
    CloudBaseCore core = CloudBaseCore.init({
      'env': 'hello-cloudbase-9gmoljho0dd9d4c1',
      'appAccess': {'key': '16dfe8b235270b12ea329d1e89c70b03', 'version': '1'}
    });
    // 匿名登录
    CloudBaseAuth auth = CloudBaseAuth(core);

    // 获取登录状态
    CloudBaseAuthState authState = await auth.getAuthState();

    // 唤起匿名登录
    if (authState == null) {
      await auth.signInAnonymously().then((success) {
        print('success');
        // 登录成功
      }).catchError((err) {
        print("err");
        // 登录失败
      });
    }

    CloudBaseFunction cloudbase = CloudBaseFunction(core);

    CloudBaseResponse res =
        await cloudbase.callFunction('get_recipes', {'name':widget.menu_tag,'size': 20});

    print(res.data['data']);
    setState(() {
      cardList = res.data['data'];
    });
  }
}

