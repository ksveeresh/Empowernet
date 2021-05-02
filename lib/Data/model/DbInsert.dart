
class DbInsert{
  String key;
  String  value;
  DbInsert({this.key, this.value});
  factory DbInsert.fromJson(Map<String, dynamic> json) => DbInsert(
    key: json["key"],
    value: json["value"]
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "value": value
  };
}