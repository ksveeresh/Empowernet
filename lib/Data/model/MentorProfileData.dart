class MentorProfileData {
  MentorPersonlBean mMentorPersonlBean;
  var mQuestionData=[];
  var userId;
  String usertype;


  MentorProfileData({
      this.mMentorPersonlBean,
      this.mQuestionData,
      this.userId,
      this.usertype
      });

  MentorProfileData.fromJson(Map<String, dynamic> json) {
    this.mMentorPersonlBean =MentorPersonlBean.fromJson(json['mMentorPersonlBean']);
    var list = new List<QuestionData>();
    json['mQuestionData'].forEach((v) {
      list.add(new QuestionData.fromJson(v));
    });
    this.mQuestionData = list;
    this.userId = json['userId'];
    this.usertype = json['usertype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mMentorPersonlBean'] = this.mMentorPersonlBean;
    data['mQuestionData'] = this.mQuestionData;
    data['userId'] = this.userId;
    data['usertype'] = this.usertype;

    return data;
  }
}
class MentorPersonlBean {
  String firestName;
  String lastName;
  String occupation;
  String city;
  String country;
  String country_code;
  String gander;
  var AreasInterest =[];
  String educationlavel;
  var Lang =[];
  String profile_path;
  String cv_path;

  MentorPersonlBean({
      this.firestName,
      this.lastName,
      this.occupation,
      this.city,
      this.country,
      this.country_code,
      this.gander,
      this.AreasInterest,
      this.educationlavel,
      this.Lang,
      this.profile_path,
      this.cv_path});
  MentorPersonlBean.fromJson(Map<String, dynamic> json) {
    this.firestName = json['firestName'];
    this.lastName = json['lastName'];
    this.occupation = json['occupation'];
    this.city = json['city'];
    this.country = json['country'];
    this.country_code = json['country_code'];
    this.gander = json['gander'];
    this.AreasInterest = json['AreasInterest'];
    this.educationlavel = json['educationlavel'];
    this.Lang = json['Lang'];
    this.profile_path = json['profile_path'];
    this.cv_path = json['cv_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firestName'] = this.firestName;
    data['lastName'] = this.lastName;
    data['occupation'] = this.occupation;
    data['city'] = this.city;
    data['country'] = this.country;
    data['country_code'] = this.country_code;
    data['gander'] = this.gander;
    data['AreasInterest'] = this.AreasInterest;
    data['educationlavel'] = this.educationlavel;
    data['Lang'] = this.Lang;
    data['profile_path'] = this.profile_path;
    data['cv_path'] = this.cv_path;
    return data;
  }
}
class QuestionData {
  String qust;
  String ans;
  QuestionData({this.qust, this.ans});
  QuestionData.fromJson(Map<String, dynamic> json) {

    this.qust = json['qust'];
    this.ans = json['ans'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['qust'] = this.qust;
    data['ans'] = this.ans;
    return data;
  }
}