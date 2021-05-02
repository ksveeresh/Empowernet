class NotificationData{
  String user_id;
  String user_name;
  String date;
  String profile_path;
  String msg;
  NotificationData({this.user_id,this.date,this.profile_path,this.msg,this.user_name});
  NotificationData.fromJson(Map<String, dynamic> json){
    user_id= json["user_id"];
    date= json["date"];
    profile_path= json["profile_path"];
    msg= json["msg"];
    user_name= json["user_name"];
  }

  Map<String, dynamic> toJson() => {
    "user_id": user_id,
    "date": date,
    "profile_path": profile_path,
    "msg": msg,
    "user_name": user_name,
  };

}