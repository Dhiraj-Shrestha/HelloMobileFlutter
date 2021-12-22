import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hello_mobiles/utils/constant.dart';

class PasswordField extends StatefulWidget {
  final obsscureText;
  final name;
  final labelText;
  final onTap;
  final validators;
  final controller;

  const PasswordField(
      {Key key,
      this.obsscureText,
      this.name,
      this.labelText,
      this.onTap,
      this.validators,
      this.controller})
      : super(key: key);
  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool show;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 7.0, bottom: 5.0),
      child: FormBuilderTextField(
        name: widget.name,
        obscureText: widget.obsscureText,
        onChanged: (value) {
          widget.controller.text.length > 1 ? show = true : show = false;
          setState(() {});
        },
        decoration: InputDecoration(
          suffixIcon: show == true
              ? IconButton(
                  onPressed: widget.onTap,
                  icon: Icon(
                    widget.obsscureText == true
                        ? Icons.visibility
                        : Icons.visibility_off,
                    size: 18.0,
                  ))
              : null,
          labelText: widget.labelText,
          focusColor: appColor,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0.2, color: appColor),
            borderRadius: new BorderRadius.circular(12.0),
          ),
          fillColor: appColor,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(12.0),
            borderSide: new BorderSide(),
          ),
        ),
        validator: widget.validators,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: widget.controller,
      ),
    );
  }
}
