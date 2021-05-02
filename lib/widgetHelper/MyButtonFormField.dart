import 'package:flutter/material.dart';

class MyButtonFormField extends StatefulWidget {
  Function onPressed;
  double width;
  String btn_name;
  Color color;
  Color fontcolor;
  MyButtonFormField({this.onPressed, this.width,this.btn_name,this.color,this.fontcolor});

  @override
  _MyButtonFormFieldState createState() => _MyButtonFormFieldState();
}

class _MyButtonFormFieldState extends State<MyButtonFormField> {
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(

      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: widget.color,
        textColor: widget.fontcolor,
        onPressed:widget.onPressed,
        child: Text(widget.btn_name),
      )
    );
  }
}
