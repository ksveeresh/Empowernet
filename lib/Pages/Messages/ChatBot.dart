

import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soughted/Data/model/EncryptModel.dart';
import 'package:soughted/Data/model/SendMessage.dart';
import 'package:soughted/Data/model/TimeAgo.dart';
import 'package:soughted/main.dart';
import 'package:path_provider/path_provider.dart';


class ChatBot extends StatefulWidget {
  dynamic item;

  ChatBot(this.item);

  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  bool record=false;
  bool botom_view =false;
  bool invite_view =false;
  Timer _timer;
  double _counter = 0;
  TextEditingController sendMessage = TextEditingController();
  List<SendMessage> SupportpopList = [];
  ScrollController _scrollController = new ScrollController();
  DatabaseReference ref;

  Stream<int> timerStream;
  StreamSubscription<int> timerSubscription;

  String mTime;

  Stopwatch _stopwatch;
  FlutterAudioRecorder recordings;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stopwatch = Stopwatch();
    widget.item;
    final FirebaseDatabase database = FirebaseDatabase(app: app);
    ref = database.reference();
    ref.child('Messages').child(widget.item["status"]!=3?widget.item["data"].friends_request_id:widget.item["data"].Group_id).onValue.listen((e) {
      var datasnapshot = e.snapshot.value;
      if(datasnapshot!=null){
        (datasnapshot as Map).forEach((key, value) {
          var i = SupportpopList.any((element) =>
          (element as SendMessage).date_time == (SendMessage.fromJson(jsonDecode(EncryptModel().Decryptedata(value))) as SendMessage).date_time);
          if (!i) {
            SupportpopList.insert(0, SendMessage.fromJson(jsonDecode(EncryptModel().Decryptedata(value))));
          } else {
            print("item exisit");
          }
        });
        if (mounted) {
          setState(() {
            Timer(Duration(milliseconds: 1), () =>
                _scrollController.animateTo(
                    0.0, duration: Duration(milliseconds: 1),
                    curve: Curves.linear));
          });
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFd0e2f2),
      appBar: AppBar(
        backgroundColor:Color(0xFF4b91e3),
        automaticallyImplyLeading: false, // Don't show the leading button
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Container(

                padding: EdgeInsets.all(5),
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
            widget.item["status"]!=3?Container(
              width: 40.0,
              height: 40.0,
              padding: EdgeInsets.all(5),
              child: CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.brown.shade800,
                child: Text(widget.item["data"].sender_name!=model.personl.firestName?(widget.item["data"].sender_name).substring(0, 1).toUpperCase():(widget.item["data"].receiver_name).substring(0, 1).toUpperCase()),
              ),
            ):Container(
                width: 40.0,
                height: 40.0,
                padding: EdgeInsets.all(5),
                child: CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Colors.brown.shade800,
                  child: Icon(Icons.group,
                      color: Colors.white),
                )
            ),
            Text(
              widget.item["status"]!=3?
              widget.item["data"].sender_name!=model.personl.firestName?widget.item["data"].sender_name:widget.item["data"].receiver_name:widget.item["data"].Group_name,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),

        actions: [
          Image(
            image: AssetImage('assets/call_img.png',),
            width: 30,
            height: 30,
          ),
          SizedBox(
            width: 10,
          ),
          Image(
            image: AssetImage('assets/video_img.png',),
            width: 30,
            height: 30,
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                padding: new EdgeInsets.all(8.0),
                reverse: true,
                itemBuilder: (BuildContext context, int index) {
                  return ListItem(dataList: SupportpopList[index],);
                },
                itemCount: SupportpopList.length,
                controller: _scrollController,
              ),
            ),
            Container(
              height: botom_view==true?150:invite_view==true?200:49,
              child: Column(
                mainAxisAlignment:MainAxisAlignment.spaceAround ,
                children: [
                  Container(height: 45,color:Color(0xFFa0c5e8),child: Row(
                    children: [
                      GestureDetector(
                        onTap:(){
                          setState(() {
                            invite_view=invite_view==false?true:false;
                            botom_view=false;
                          });
                        } ,
                        child: Container(
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Image(
                              image: AssetImage('assets/event_img.png',),
                              fit: BoxFit.fill,
                            ),
                          ),
                          width: 30,
                          height: 30,
                          margin: EdgeInsets.only(left: 5,right: 5),
                        ),
                      ),
                      GestureDetector(
                        onTap:(){
                          setState(() {
                            botom_view=botom_view==false?true:false;
                            invite_view=false;
                          });
                        } ,
                        child: Container(
                          margin: EdgeInsets.only(left: 5,right: 5),
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Image(
                              image: AssetImage('assets/button_add.png',),
                              fit: BoxFit.fill,
                            ),
                          ),
                          width: 30,
                          height: 30,
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          if (_stopwatch.isRunning) {
                            _stopwatch.stop();
                            _timer.cancel();
                            _stopwatch.reset();
                            record=false;
                            setState(() {});

                          } else {
                            _stopwatch.start();
                            record=true;
                            _timer = new Timer.periodic(new Duration(milliseconds: 30), (timer) {

                              setState(() {
                                RecordAdieo(widget.item["data"]);
                              });
                            });
                          }
                          // RecordAdieo(widget.item["data"]);
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 5,right: 5),
                          child: record==false?AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Image(
                              image: AssetImage('assets/mic_img.png',),
                              fit: BoxFit.fill,
                            ),
                          ): Icon(Icons.close),
                          width: 30,
                          height: 30,

                        ),
                      ),
                      Expanded(
                        child:record==false?Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.only(left: 5),
                          decoration: new BoxDecoration(
                              color: Color(0xFFd0e2f2),
                              borderRadius:BorderRadius.circular(8.0),
                              border: Border.all(color: Colors.grey[600])
                          ),
                          child: TextField(
                            enabled: true,
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                              hintText: "Enter Message",
                              border: InputBorder.none,
                            ),
                            onChanged: (text) {

                            },
                            controller: sendMessage,
                            keyboardType:TextInputType.text,
                            obscureText:false,
                          ),
                        ):Container(child: Text(formatTime(_stopwatch.elapsedMilliseconds)),),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if(record==true){
                            _stopwatch.stop();
                            _timer.cancel();
                            _stopwatch.reset();
                              var result = await recordings.stop();
                              print("Stop recording: ${result.path}");
                              print("Stop recording: ${result.duration}");
                              File path=await File(result.path);

                              record=false;
                              uploadToFirebase(path,widget.item["data"]);
                          }else{
                            if(widget.item["status"]!=3){
                              var id=ref.child('Messages').child(widget.item["data"].friends_request_id).push().key;
                              var itemval= widget.item["data"].friends_request_id.toString().split("_");
                              var mReceived_id=itemval[0]==model.userId?itemval[1]:itemval[0];
                              var sendMsg=EncryptModel().Encryptedata(jsonEncode(SendMessage(msg:sendMessage.text.toString(),type:"0",sender_id: model.userId,received_id:mReceived_id,date_time: DateTime.now().toUtc().toString())));
                              ref.child('Messages').child(widget.item["data"].friends_request_id).child(id).set(sendMsg);
                              widget.item["data"].msg=sendMessage.text.toString();
                              Map<String, dynamic> map = new Map<String, dynamic>();
                              map["status"] = widget.item["status"];
                              map["data"] = EncryptModel().Encryptedata(jsonEncode(widget.item["data"]));
                              ref.child('Friends').child("Request").child(widget.item["data"].friends_request_id).set(map);
                              sendMessage.clear();
                            }else{
                              var mReceived_id=widget.item["data"].Group_peple;
                              var id=ref.child('Messages').child(widget.item["data"].Group_id).push().key;
                              var sendMsg=EncryptModel().Encryptedata(jsonEncode(SendMessage(msg:sendMessage.text.toString(),type:"0",sender_id: model.userId,received_id:mReceived_id,date_time: DateTime.now().toUtc().toString())));
                              ref.child('Messages').child(widget.item["data"].Group_id).child(id).set(sendMsg);
                              widget.item["data"].msg=sendMessage.text.toString();
                              Map<String, dynamic> map = new Map<String, dynamic>();
                              map["status"] = widget.item["status"];
                              map["data"] = EncryptModel().Encryptedata(jsonEncode(widget.item["data"]));
                              ref.child('Friends').child("Group").child(widget.item["data"].Group_id).set(map);
                              sendMessage.clear();
                            }

                          }

                        },
                        child: Container(
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Image(
                              image: AssetImage('assets/send_img.png',),
                              fit: BoxFit.fill,
                            ),
                          ),
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ],
                  ),),
                  Visibility(
                    visible: invite_view,
                    child:Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Choose date:")
                            ],
                          ),
                          Row(
                            children: [
                              Text("Time:"),
                              Text("to:")
                            ],
                          ),
                          Row(),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: botom_view,
                    child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment:MainAxisAlignment.spaceEvenly ,

                        children: [
                          GestureDetector(
                            onTap: () async {
                              PickedFile file=await ImagePicker.platform.pickImage(source: ImageSource.gallery, maxHeight: 500,maxWidth: 500,imageQuality: 50,preferredCameraDevice: CameraDevice.front);
                              File path=await File(file.path);
                              uploadToFirebase(path,widget.item["data"]);
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    child: AspectRatio(
                                      aspectRatio: 16 / 9,
                                      child: Image(
                                        image: AssetImage('assets/photo_img.png',),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    width: 30,
                                    height: 30,
                                  ),
                                  Container(
                                      child: Text("Photo")
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              PickedFile file=await ImagePicker.platform.pickImage(source: ImageSource.camera, maxHeight: 500,maxWidth: 500,imageQuality: 50,preferredCameraDevice: CameraDevice.front);
                              File path=await File(file.path);
                              uploadToFirebase(path,widget.item["data"]);
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    child: AspectRatio(
                                      aspectRatio: 16 / 9,
                                      child: Image(
                                        image: AssetImage('assets/camra_img.png',),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    width: 30,
                                    height: 30,
                                  ),
                                  Container(
                                      child: Text("Camera")
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Container(
                                  child: AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: Image(
                                      image: AssetImage('assets/attachment_img.png',),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  width: 30,
                                  height: 30,
                                ),
                                Container(
                                    child: Text("File Attachments",textAlign: TextAlign.center,)
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> uploadToFirebase(File file, item) async {
    var id=ref.child('Messages').child(widget.item["status"]!=3?item.friends_request_id:item.Group_id).push().key;
    final filePath = '${id}.png';
    await FirebaseStorage.instance
        .refFromURL('gs://squghted.appspot.com/images/${widget.item["status"]!=3?item.friends_request_id:item.Group_id}/')
        .child(filePath)
        .putFile(file)
        .then((value) async{
      var link = await value.ref.getDownloadURL();
      var itemval= item.friends_request_id.toString().split("_");
      var mReceived_id=itemval[0]==model.userId?itemval[1]:itemval[0];
      var sendMsg=EncryptModel().Encryptedata(jsonEncode(SendMessage(msg:link.toString(),type:"1",sender_id: model.userId,received_id:mReceived_id,date_time: DateTime.now().toUtc().toString())));
      ref.child('Messages').child(widget.item["status"]!=3?item.friends_request_id:item.Group_id).child(id).set(sendMsg);
      setState(() {});
    }).catchError((onError){
      print(onError.toString());
    });
  }
  String formatTime(int milliseconds) {
    var secs = milliseconds ~/ 1000;
    var hours = (secs ~/ 3600).toString().padLeft(2, '0');
    var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
    var seconds = (secs % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }
  





  Future<void> RecordAdieo(item) async {
    var id=ref.child('Messages').child(widget.item["data"].friends_request_id).push().key;

    bool hasPermission = await FlutterAudioRecorder.hasPermissions;
    if(hasPermission){
      var appDocDirectory;
      if (Platform.isIOS) {
        appDocDirectory = await getApplicationDocumentsDirectory();
      } else {
        appDocDirectory = await getExternalStorageDirectory();
      }
      var customPath = appDocDirectory.path+"/${id}";
      recordings=FlutterAudioRecorder(customPath, audioFormat: AudioFormat.WAV);
      await recordings.initialized;
      await recordings.start();
      print("recording started");
    }

  }


}
class ListItem extends StatefulWidget {
  SendMessage dataList;
  ListItem({this.dataList});
  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: widget.dataList.sender_id !=model.userId
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      crossAxisAlignment: widget.dataList.sender_id !=model.userId
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width:widget.dataList.sender_id !=model.userId ? 30.0 : 20.0),
        if (widget.dataList.sender_id !=model.userId) ...[],

        ///Chat bubbles
        Container(
          padding: EdgeInsets.only(
            bottom: 5,
            right: 5,
          ),
          child: Column(
            crossAxisAlignment: widget.dataList.sender_id !=model.userId
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                constraints: BoxConstraints(
                  minHeight: 40,
                  maxHeight: double.infinity,
                  maxWidth: double.infinity,
                  minWidth: 40,
                ),
                decoration: BoxDecoration(
                  color:widget.dataList.sender_id !=model.userId
                      ? Colors.white
                      : Color(0xFF3066CA),
                  borderRadius: widget.dataList.sender_id !=model.userId
                      ? BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )
                      : BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15, top: 10, bottom: 5, right: 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: widget.dataList.sender_id !=model.userId
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            widget.dataList.type=="1"?Container(
                              height: 100,
                              width: 100,
                              child: CachedNetworkImage(
                                imageUrl:widget.dataList.msg,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                      decoration: BoxDecoration(
                                        // shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.fill,
                                          // colorFilter: ColorFilter.mode(
                                          //   Colors.red,
                                          //   BlendMode.colorBurn,
                                          // ),
                                        ),
                                      ),
                                    ),
                                placeholder: (context, url) => Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            )
                                :Text(
                              widget.dataList.msg ?? '',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: widget.dataList.sender_id !=model.userId
                                    ? Color(0xFF6D6D6D)
                                    : Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                TimeAgo.timeAgoSinceDate(widget.dataList.date_time) ?? '',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black.withOpacity(0.5),
                ),
              )
            ],
          ),
        ),
        SizedBox(width: widget.dataList.sender_id !=model.userId ? 20.0 : 30.0),
      ],
    );
  }
}