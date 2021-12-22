import 'package:flutter/material.dart';
import 'package:hello_mobiles/utils/constant.dart';

class ProfileCartMenu extends StatelessWidget {
  const ProfileCartMenu({
    Key key,
    @required this.text,
    @required this.icon,
    this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final Function onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1.0),
      child: Card(
        color: Colors.white,
        elevation: 0.1,
        child: ListTile(
          leading: Icon(icon, color: appColor),
          title: Text(text),
          onTap: onPressed,
        ),
      ),
    );
  }
}

// FlatButton(
//         padding: EdgeInsets.all(20),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         color: Colors.grey[80],
//         onPressed: onPressed,
//         child: Row(
//           children: [
//             Icon(icon),
//             SizedBox(width: 20),
//             Expanded(child: Text(text)),
//             Icon(Icons.arrow_forward_ios),
//           ],
//         ),
//       ),
