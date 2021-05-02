import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';

class MyTextTagFormFiels extends StatefulWidget {
  final String hintText;
  final Function OnRemove;
  final Function onSaved;
  var initialTags;

  MyTextTagFormFiels({
    this.OnRemove,
    this.onSaved,
    this.hintText,
    this.initialTags
  });
  @override
  _MyTextTagFormFielsState createState() => _MyTextTagFormFielsState();
}

class _MyTextTagFormFielsState extends State<MyTextTagFormFiels> {
  @override
  Widget build(BuildContext context) {
    return TextFieldTags(
      tagsStyler: TagsStyler(
          tagTextStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,fontSize: 14),
          tagDecoration: BoxDecoration(
            color: Color(0xFF4990e2),
            borderRadius: BorderRadius.circular(8.0),
          ),
          tagCancelIcon:
          Icon(Icons.cancel, size: 18.0, color: Colors.white),
          tagPadding: const EdgeInsets.all(6.0)),
      textFieldStyler: TextFieldStyler(
        textStyle:TextStyle(fontWeight: FontWeight.bold, color: Colors.white,fontSize: 14) ,
        hintText: widget.hintText,
        helperText:"Add muiltipl",
        helperStyle: TextStyle(fontSize:0),
        textFieldBorder: OutlineInputBorder(borderRadius:BorderRadius.zero,borderSide: BorderSide.none),
        textFieldFocusedBorder:OutlineInputBorder(borderRadius:BorderRadius.zero,borderSide: BorderSide.none) ,
        textFieldDisabledBorder: OutlineInputBorder(borderRadius:BorderRadius.zero,borderSide: BorderSide.none),


      ),
      onTag: (tag) {
        widget.onSaved(tag);
      },
      onDelete: (tag) {
        widget.OnRemove(tag);
      },
      initialTags: widget.initialTags,

    );


  }
}
