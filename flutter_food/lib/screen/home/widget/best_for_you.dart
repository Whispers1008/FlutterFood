import 'package:cloudbase_auth/cloudbase_auth.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_function/cloudbase_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food/constant.dart';
import 'package:flutter_food/screen/detail/detail_screen.dart';
import 'package:flutter_food/screen/home/widget/food_item.dart';
import 'package:flutter_food/screen/showlist/show_list_screen.dart';

class BestForYou extends StatefulWidget {
  String menu_tag;
  BestForYou({
    Key? key,
    required this.menu_tag,
  }) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return _BestForYou();
  }
}

class _BestForYou extends State<BestForYou> {
  Map quickActionMap = {};

  @override
  void initState() {
    super.initState();
    // 初始化获取列表数据
    setFoodList();
  }

  @override


  List<Widget> showList() {
    if (quickActionMap[widget.menu_tag] != null && quickActionMap[widget.menu_tag].length != 0) {
      return <Widget>[
        GestureDetector(
          child: FoodItem(
            food_item:quickActionMap[widget.menu_tag][0],
            check: true,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(
                  food_item: quickActionMap[widget.menu_tag][0],
                ),
              ),
            );
          },
        ),
        SizedBox(
          width: 24.0,
        ),
        GestureDetector(
          child: FoodItem(
            food_item: quickActionMap[widget.menu_tag][1],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(
                  food_item: quickActionMap[widget.menu_tag][1],
                ),
              ),
            );
          },
        ),
        SizedBox(
          width: 24.0,
        ),
        GestureDetector(
          child: FoodItem(
            food_item: quickActionMap[widget.menu_tag][2],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(
                  food_item: quickActionMap[widget.menu_tag][2],
                ),
              ),
            );
          },
        ),
      ];
    } else {
      return <Widget>[Text("正在加载，请稍等")];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Best For You',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                child: Text(
                  'See More',
                  style: TextStyle(
                    color: mPrimaryColor,
                    fontSize: 14.0,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShowListScreen(menu_tag: widget.menu_tag,),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 28.0, vertical: 14.0),
            child: Row(children: showList()),
          ),
        ),
      ],
    );
  }

  Future<void> setFoodList() async {
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

    CloudBaseResponse res = await cloudbase
        .callFunction('get_recipes', {'name': 'recipes', 'size': 3});
    CloudBaseResponse res_baked = await cloudbase
        .callFunction('get_recipes', {'name': 'bakedFood', 'size': 3});
    CloudBaseResponse res_jiachang = await cloudbase
        .callFunction('get_recipes', {'name': 'jiachang', 'size': 3});
    CloudBaseResponse res_juice = await cloudbase
        .callFunction('get_recipes', {'name': 'juice', 'size': 3});
    CloudBaseResponse res_western = await cloudbase
        .callFunction('get_recipes', {'name': 'westernFood', 'size': 3});

    setState(() {
      quickActionMap = {
        'food':res.data['data'],
        'bakedFood': res_baked.data['data'],
        'jiachang': res_jiachang.data['data'],
        'juice':res_juice.data['data'],
        'westernFood':res_western.data['data']
      };
    });
  }
}
