import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class MyCountryFormField extends StatefulWidget {
  Function onSaved;
  bool enabled;
  String titleText;
  MyCountryFormField({this.onSaved,this.enabled,this.titleText});

  @override
  _MyCountryFormFieldState createState() => _MyCountryFormFieldState();
}

class _MyCountryFormFieldState extends State<MyCountryFormField> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(widget.enabled==true) {
          showCountryPicker(
            context: context,
            showPhoneCode: false,
            onSelect: (Country country) {
              setState(() {
                widget.onSaved(country);
                widget.titleText = country.name;
              });
            },
          );
        }
      },
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.titleText,style: TextStyle(fontSize: 16,color: Colors.white),),
          Icon(Icons.arrow_drop_down,color: Colors.white,)
        ],),
    );
  }



}

