class SendMessage{
  String msg;
  String sender_id;
  String received_id;
  String type;
  String date_time;
  SendMessage({this.msg,this.sender_id,this.received_id,this.type,this.date_time});
  SendMessage.fromJson(Map<String, dynamic> json){
    sender_id= json["sender_id"];
    received_id= json["received_id"];
    type= json["type"];
    msg= json["msg"];
    date_time= json["date_time"];
  }

  Map<String, dynamic> toJson() => {
    "sender_id": sender_id,
    "received_id": received_id,
    "type": type,
    "msg": msg,
    "date_time": date_time,
  };

}