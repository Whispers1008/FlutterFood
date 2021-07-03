import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food/screen/home/widget/action_menu.dart';
import 'package:flutter_food/screen/home/widget/best_for_you.dart';
import 'package:flutter_food/screen/home/widget/my_appbar.dart';
import 'package:flutter_food/screen/home/widget/user_text.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }

}

class _HomeScreenState extends State<HomeScreen> {
  String menu_tag = "food";
  int check = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MyAppbar(),
            SizedBox(
              height: 24,
            ),
            UserText(),
            SizedBox(
              height: 40.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Quick Action',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        child: ActionMenu(
                          imageUrl: 'assets/images/jiachang.svg',
                          check: check,
                          flag: 1,
                        ),
                        onTap: ()=>{
                          setState((){
                            menu_tag = 'jiachang';
                            check = 1;
                          })
                        },
                      ),
                      GestureDetector(
                        child: ActionMenu(
                          imageUrl: 'assets/images/western.svg',
                          check: check,
                          flag: 2,
                        ),
                        onTap: ()=>{
                          setState((){
                            menu_tag = 'westernFood';
                            check = 2;
                          })
                        },
                      ),
                      GestureDetector(
                        child: ActionMenu(
                          imageUrl: 'assets/images/bakedFood.svg',
                          check: check,
                          flag: 3,
                        ),
                        onTap: ()=>{
                          setState((){
                            menu_tag = 'bakedFood';
                            check = 3;
                          })
                        },
                      ),
                      GestureDetector(
                        child: ActionMenu(
                          imageUrl: 'assets/images/juice.svg',
                          check: check,
                          flag: 4,
                        ),
                        onTap: ()=>{
                          setState((){
                            menu_tag = 'juice';
                            check = 4;
                          })
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            BestForYou(menu_tag: menu_tag,),
            SizedBox(
              height: 40.0,
            ),
          ],
        ),
      ),
    );
  }
}


