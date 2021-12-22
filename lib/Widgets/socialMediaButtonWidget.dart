import 'package:flutter/material.dart';

class SocialMediaButtonWidget extends StatelessWidget {
  final Color buttonColor;
  final Color iconColor;
  final IconData icon;

  final Function onPressed;

  const SocialMediaButtonWidget(
      {Key key,
      @required this.buttonColor,
      @required this.icon,
      @required this.iconColor,
      @required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 12.0),
        child: FlatButton(
          onPressed: onPressed,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: buttonColor,
          child: Icon(icon, color: iconColor),
        ),
      ),
    );
  }
}
