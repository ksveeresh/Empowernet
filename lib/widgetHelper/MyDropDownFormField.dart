import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDropDownFormField extends StatefulWidget {
  List<String> itemList;
  Function onSaved;
  bool enabled;
  String selecteddropdownValue;
  MyDropDownFormField({this.itemList, this.onSaved,this.enabled,this.selecteddropdownValue});

  @override
  _MyDropDownFormFieldState createState() => _MyDropDownFormFieldState();
}

class _MyDropDownFormFieldState extends State<MyDropDownFormField> {
  String dropdownValue;
  @override
  void initState() {
    super.initState();
    dropdownValue= widget.selecteddropdownValue==""? widget.selecteddropdownValue :widget.itemList[0];
  }
@override
  void didUpdateWidget(covariant MyDropDownFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
setState(() {
  
});
}
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child:DropdownButton<String>(

        value: dropdownValue,
        iconDisabledColor: Colors.black,
        onChanged: widget.enabled?(String newValue) {
          setState(() {
            dropdownValue=newValue;
            widget.onSaved(newValue);
          });
        }:null,
        items:widget.itemList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
