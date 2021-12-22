import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Color buttonColor;
  final Color textColor;
  final Color borderColor;
  final Function onPressed;
  final String buttonName;
  final double borderRadius;

  const ButtonWidget(
      {Key key,
      this.buttonColor,
      this.textColor,
      this.borderColor,
      this.onPressed,
      this.buttonName,
      this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(
              12.0,
            ),
            child: FlatButton(
              disabledColor: Colors.grey,
              color: buttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                side: BorderSide(color: borderColor),
              ),
              onPressed: onPressed,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  buttonName,
                  style: TextStyle(color: textColor),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
