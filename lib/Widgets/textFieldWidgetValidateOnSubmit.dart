import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hello_mobiles/utils/constant.dart';

class TextFieldWidgetAutoValidateFalse extends StatelessWidget {
  final String labelText;
  final String name;
  final TextInputType inputType;
  final TextEditingController controller;
  final FormFieldValidator<String> validators;

  const TextFieldWidgetAutoValidateFalse(
      {Key key,
      this.labelText,
      this.name,
      this.inputType,
      this.validators,
      this.controller});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 7.0, bottom: 5.0),
      child: FormBuilderTextField(
        name: name,
        decoration: InputDecoration(
          labelText: labelText,
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
        // onChanged: (){},
        // valueTransformer: (text) => num.tryParse(text),
        validator: validators,
        autovalidateMode: AutovalidateMode.disabled,
        keyboardType: inputType,
        controller: controller,
      ),
    );
  }
}
