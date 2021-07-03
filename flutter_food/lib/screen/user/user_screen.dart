import 'package:cloudbase_auth/cloudbase_auth.dart';
import 'package:cloudbase_core/cloudbase_core.dart';
import 'package:cloudbase_function/cloudbase_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food/constant.dart';
import 'package:flutter_food/screen/user/widget/card_item.dart';
import 'package:flutter_food/screen/user/widget/user_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserScreenState();
  }
}

class _UserScreenState extends State<UserScreen>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late TabController _tabController;

  List collectionList = [];
  List preferenceList = [];

  Map dataMap = {"收藏":[],"笔记":[],"点赞":[]};

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(initialScrollOffset: 0.0);
    _tabController = TabController(length: 2, vsync: this);

    // 获取用户收藏和喜欢列表
    setListData();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            pinned: true,
            floating: true,
            expandedHeight: 250,
            backgroundColor: mBackgroundColor,
            iconTheme: IconThemeData(color: mPrimaryColor),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: UserBar(),
            ),
            bottom: TabBar(
              controller: _tabController,
              labelColor: mPrimaryColor,
              unselectedLabelColor: Colors.black,
              indicatorColor: mPrimaryColor,
              tabs: [
                Tab(
                  text: "收藏",
                ),
                Tab(
                  text: "点赞",
                ),
              ],
            ),
          )
        ];
      },
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildListView("收藏"),
          _buildListView("点赞"),
        ],
      ),
    ));
  }

  Widget _buildListView(String s) {
    if(dataMap[s].length!=0){
      return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(dataMap[s][index]['title'].toString()+dataMap[s].length.toString()),
            child: Container(
              child: ListTile(
                  title: CardItem(item: dataMap[s][index],)
              ),
            ),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              child: ListTile(
                leading: Icon(
                  Icons.delete,
                  color:Colors.white,
                ),
                trailing:Icon(
                  Icons.delete,
                  color:Colors.white,
                ),
              ),
            ),
            onDismissed: (direction){
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('${dataMap[s][index]['title']}卡片移出列表')));
              setState(() {
                dataMap[s].removeAt(index);
              });

            },
          );
        },
        separatorBuilder: (BuildContext context, int index) => Divider(
          color: Colors.transparent,
          height: 1,
        ),
        itemCount: dataMap[s].length,
      );
    }else{
      return Text("空空如也");
    }
  }

  Future<void> setListData() async {
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

    CloudBaseResponse res_col = await cloudbase
        .callFunction('get_collections', {'name': Global.userName});
    CloudBaseResponse res_pre = await cloudbase
        .callFunction('get_preference', {'name': Global.userName});

    print(res_col.data['data']);

    setState(() {
      collectionList = res_col.data['data'];
      preferenceList = res_pre.data['data'];
      dataMap['收藏'] = collectionList;
      dataMap['点赞'] = preferenceList;
    });
  }


}
