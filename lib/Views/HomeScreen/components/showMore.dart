import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_mobiles/utils/constant.dart';

Widget showMore(
    {IconData icon, String suffixText, String prefixText, Function onTap}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 18),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Row(
            children: [
              Icon(
                icon,
                color: appColor,
                size: 24.0,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                suffixText,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Text(
            prefixText,
            style: TextStyle(color: appColor),
          ),
        )
      ],
    ),
  );
}
