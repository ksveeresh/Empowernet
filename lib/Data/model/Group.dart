class Group{
  String Group_creater_id;
  String Group_name;
  String Group_img;
  String msg;
  String Group_id;
  String Group_peple;

  Group(
      {this.Group_creater_id,
      this.Group_name,
      this.Group_img,
      this.Group_id,
      this.msg,
      this.Group_peple});
  Group.fromJson(Map<String, dynamic> json){
    Group_creater_id= json["Group_creater_id"];
    Group_name= json["Group_name"];
    Group_img= json["Group_img"];
    Group_id= json["Group_id"];
    msg= json["msg"];
    Group_peple= json["Group_peple"];
  }
  Map<String, dynamic> toJson() => {
    "Group_creater_id": Group_creater_id,
    "Group_name": Group_name,
    "Group_img": Group_img,
    "Group_id": Group_id,
    "msg": msg,
    "Group_peple": Group_peple
  };
}