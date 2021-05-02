import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextFormField extends StatefulWidget {
  TextInputType inputType;
  Function onSaved;
  bool isPassword;
  String hintText;
  TextAlign mTextAlign;
  bool enabled;

  TextEditingController controller;
  MyTextFormField({this.inputType, this.onSaved, this.isPassword, this.hintText,this.mTextAlign,this.enabled,this.controller});

  @override
  _MyTextFormFieldState createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  TextField(
      enabled: widget.enabled,
      textAlign: widget.mTextAlign,
      controller: widget.controller!=null?widget.controller:null,
      style: TextStyle(fontSize: 16),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(bottom: 10.0),
        border: InputBorder.none,
        hintText: widget.hintText,
      ),

      onChanged: (text) {
        setState(() {
          widget.onSaved(text);
        });

      },
      keyboardType:widget.inputType,
      obscureText:widget.isPassword,
    );
  }
}
