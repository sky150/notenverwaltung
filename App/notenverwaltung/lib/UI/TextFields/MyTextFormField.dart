import 'package:flutter/material.dart';
import 'package:notenverwaltung/global.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final Function validator;
  final Function onSaved;
  final Function onChanged;
  final TextAlign textAlign;
  final String labelText;
  final bool autocorrect;

  MyTextFormField({
    this.onChanged,
    this.controller,
    this.labelText,
    this.validator,
    this.onSaved,
    this.textAlign,
    this.autocorrect,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(kDefaultPadding),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          hoverColor: kPrimaryColor,
          focusColor: kPrimaryColor,
          fillColor: kPrimaryColor,
          //contentPadding: EdgeInsets.all(10.0),
          //border: InputBorder.none,
          //filled: true,
          //fillColor: Colors.grey[200],
        ),
        validator: validator,
        onSaved: onSaved,
        onChanged: onChanged,
        textAlign: textAlign,
        autocorrect: autocorrect,
      ),
    );
  }
}

class MyTextArea extends StatelessWidget {
  final TextEditingController controller;
  final Function onSaved;
  final String labelText;
  final Function onChanged;

  MyTextArea({this.controller, this.labelText, this.onSaved, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(kDefaultPadding),
      child: TextFormField(
        controller: controller,
        maxLines: 4,
        decoration: InputDecoration(
          labelText: labelText,
          //contentPadding: EdgeInsets.all(15.0),
          //border: InputBorder.none,
          //filled: true,
          //fillColor: Colors.grey[200],
        ),
        onSaved: onSaved,
        onChanged: onChanged,
      ),
    );
  }
}