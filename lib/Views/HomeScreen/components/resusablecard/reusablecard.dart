import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  final String titles;
  final Color myBackGroundColor;
  final IconData myIcon;
  final Color iconColor;
  final Widget widget;

  ReusableCard(
      {@required this.myBackGroundColor,
      @required this.iconColor,
      @required this.titles,
      @required this.myIcon,
      this.widget});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      child: ListTile(
        leading: CircleAvatar(
          radius: 20.0,
          backgroundColor: myBackGroundColor,
          child: Icon(
            myIcon,
            color: iconColor,
          ),
        ),
        title: Text(
          titles,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: widget,
      ),
    );
  }
}
