class EventNotificationReq{
  String user_id;
  String key;
  String event_title;
  String user_name;
  String event_date;
  String event_time;
  String event_summary;
  List event_co_host;

  EventNotificationReq({
    this.user_id,
    this.key,
    this.event_title,
    this.user_name,
    this.event_date,
    this.event_time,
    this.event_summary,
    this.event_co_host});
  EventNotificationReq.fromJson(Map<String, dynamic> json){
    user_id= json["user_id"];
    key= json["key"];
    event_title=json["event_title"];
    user_name= json["user_name"];
    event_date= json["event_date"];
    event_time= json["event_time"];
    event_summary= json["event_summary"];
    event_co_host= json["event_co_host"] as List;
  }
  Map<String, dynamic> toJson() => {
    "user_id": user_id,
    "key": key,
    "event_title": event_title,
    "user_name": user_name,
    "event_date": event_date,
    "event_time": event_time,
    "event_date": event_date,
    "event_summary": event_summary,
    "event_co_host": event_co_host
  };
}