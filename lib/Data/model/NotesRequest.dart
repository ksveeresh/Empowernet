class NotesRequest{
  String user_id;
  String user_name;
  String subject;
  String profile_path;
  String user_type;
  String msg;
  String friends_request_id;
  String Date;

  NotesRequest(
      {this.user_id,
      this.user_name,
      this.subject,
      this.profile_path,
      this.user_type,
      this.msg,
      this.friends_request_id,
      this.Date});
  NotesRequest.fromJson(Map<String, dynamic> json){
    user_id= json["user_id"];
    user_name= json["user_name"];
    subject=json["subject"];
    profile_path= json["profile_path"];
    user_type= json["user_type"];
    msg= json["msg"];
    friends_request_id= json["friends_request_id"];
    Date= json["Date"];
  }

  Map<String, dynamic> toJson() => {
    "user_id": user_id,
    "user_name": user_name,
    "subject": subject,
    "profile_path": profile_path,
    "user_type": user_type,
    "msg": msg,
    "friends_request_id": friends_request_id,
    "Date": Date
  };

}