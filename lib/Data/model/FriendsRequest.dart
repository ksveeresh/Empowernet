class FriendsRequest{
  String sender_id;
  String receiver_id;
  String sender_name;
  String receiver_name;
  String mentor_subject;
  String receiver_profile;
  String sender_profile;
  String user_type;
  String msg;
  String friends_request_id;
  FriendsRequest({this.sender_id,this.receiver_id,this.mentor_subject,this.receiver_profile,this.sender_profile,this.msg,this.user_type,this.friends_request_id,this.receiver_name,this.sender_name});
  FriendsRequest.fromJson(Map<String, dynamic> json){
    sender_id= json["sender_id"];
    receiver_id= json["receiver_id"];
    sender_name= json["sender_name"];
    receiver_name= json["receiver_name"];
    mentor_subject=json["mentor_subject"];
    receiver_profile= json["receiver_profile"];
    sender_profile= json["sender_profile"];
    user_type= json["user_type"];
    msg= json["msg"];
    friends_request_id= json["friends_request_id"];
  }

  Map<String, dynamic> toJson() => {
    "sender_id": sender_id,
    "receiver_id": receiver_id,
    "sender_name": sender_name,
    "receiver_name": receiver_name,
    "mentor_subject": mentor_subject,
    "receiver_profile": receiver_profile,
    "sender_profile": sender_profile,
    "user_type": user_type,
    "msg": msg,
    "friends_request_id": friends_request_id
  };

}