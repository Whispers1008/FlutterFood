import 'package:flutter/material.dart';
import 'package:flutter_food/constant.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActionMenu extends StatefulWidget{
  final String imageUrl;
  int check;
  final int flag;


  ActionMenu({
    Key? key,
    required this.imageUrl,
    required this.flag,
    this.check = 1,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ActionMenuState();
  }

}

class _ActionMenuState extends State<ActionMenu> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 68,
      height: 68,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: (widget.check == widget.flag) ? mPrimaryColor : Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: (widget.check == widget.flag)
                  ? mPrimaryColor.withOpacity(0.5)
                  : mPrimaryColor.withOpacity(0.03),
              offset: Offset(0, 10),
              blurRadius: 10,
              spreadRadius: 1.5,
            ),
          ]),
      child: SvgPicture.asset(
        widget.imageUrl,
        color: (widget.check == widget.flag) ? Colors.white : mPrimaryColor,
      ),
    );
  }
}