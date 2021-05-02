import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:firebase/firebase.dart' as fb;
import 'package:soughted/Data/model/MentorProfileData.dart';
import 'package:soughted/Data/model/ProfileData.dart';
import 'package:soughted/main.dart';
import 'package:cached_network_image/cached_network_image.dart';


class itemCard extends StatefulWidget {
  var newDataList;
  itemCard(this.newDataList);

  @override
  _itemCardState createState() => _itemCardState();
}

class _itemCardState extends State<itemCard> {
  String item;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var profile =(widget.newDataList as ProfileData).personl.profile_path;
    return Container(
      color:Colors.white,
      width: 200,
      height: 50,
      child: Container(
        padding: EdgeInsets.all(5),
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                widget.newDataList.personl.profile_path==null?Container(
                  child:CircleAvatar(
                    radius: 30.0,
                    backgroundColor: Colors.brown.shade800,
                    child:Text(widget.newDataList.personl.firestName.substring(0, 1).toUpperCase()),
                  )
                ):Container(
                  height: 50,
                  width: 50,
                  child: CachedNetworkImage(
                    imageUrl: widget.newDataList.personl.profile_path,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black,
                        ),
                        image: DecorationImage(image: imageProvider, fit: BoxFit.fill,),
                      ),
                    ),
                    placeholder: (context, url) => Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Flexible(
                  child: Container(
alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(widget.newDataList.personl.firestName, overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
                        Text(widget.newDataList.personl.occupation, overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
                        Text(widget.newDataList.personl.mentorship!=null?widget.newDataList.personl.mentorship:"-" ,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
                      ],
                    ),
                    padding: EdgeInsets.all(5),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,bottom: 5),
              child: Row(children: [
                Container(
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image(
                      image: AssetImage('assets/dashbord2.png',),
                      fit: BoxFit.fill,
                    ),
                  ),
                  width: 25,
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(loadEducation(widget.newDataList.educational), overflow: TextOverflow.ellipsis,),
                ),
              ],),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(children: [
                Container(
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image(
                      image: AssetImage('assets/dashbord3.png',),
                      fit: BoxFit.fill,
                    ),
                  ),
                  width: 30,
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(loadwork(widget.newDataList.work), overflow: TextOverflow.ellipsis,),
                ),
              ],),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(children: [
                Container(
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image(
                      image: AssetImage('assets/dashbord1.png',),
                      fit: BoxFit.fill,
                    ),
                  ),
                  width: 25,
                  height: 25,
                ),
                Container(padding: const EdgeInsets.only(left: 10),
                    width:138,child: Text(widget.newDataList.personl.city, overflow: TextOverflow.ellipsis,)),
              ],),
            ),

          ],
        ),
      ),
    );
  }

  String loadEducation(educational) {
    String s="";
    educational.forEach((element) {
      if(s==""){
        s=element.university;
      }else{
        s+=",${element.university}";
      }
    });
    return s;
  }

  String loadwork(work) {
    String s="";
    work.forEach((element) {
      if(s==""){
        s=element.company;
      }else{
        s+=",${element.company}";
      }
    });
    return s;
  }
}
