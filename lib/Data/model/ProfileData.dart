class ProfileData {
  var userId;
  String usertype;
  PersonlBean personl;
  List<EducationalListBean> educational=List.empty(growable: true);
  List<WorkListBean> work=List.empty(growable: true);
  String experience="";
  var PersonalIntersts =[];
  var PersonalSkills =[];

  ProfileData({this.userId, this.usertype,this.personl, this.educational, this.work,this.PersonalIntersts,this.PersonalSkills,this.experience});

  ProfileData.fromJson(Map<String, dynamic> json) {    
    this.userId = json['user_id'];
    this.usertype = json['usertype'];
    this.personl = json['personl'] != null ? PersonlBean.fromJson(json['personl']) : null;
    this.educational = (json['educational'] as List)!=null?(json['educational'] as List).map((i) => EducationalListBean.fromJson(i)).toList():null;
    this.work = (json['work'] as List)!=null?(json['work'] as List).map((i) => WorkListBean.fromJson(i)).toList():null;
    this.PersonalIntersts = json['PersonalIntersts'];
    this.PersonalSkills = json['PersonalSkills'];
    this.experience = json['experience'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['usertype'] = this.usertype;
    if (this.personl != null) {
      data['personl'] = this.personl.toJson();
    }
    data['educational'] = this.educational != null?this.educational.map((i) => i.toJson()).toList():null;
    data['work'] = this.work != null?this.work.map((i) => i.toJson()).toList():null;
    data['PersonalIntersts']=this.PersonalIntersts;
    data['PersonalSkills']=this.PersonalSkills;
    data['experience']=this.experience;
    return data;
  }

}

class PersonlBean {
  String firestName;
  String lastName;
  String gander;
  String profile_path;
  String occupation;
  var Lang =[];
  String city;
  String country;
  String country_code;
  String country_loc_code;
  String mentorship;


  PersonlBean({this.firestName, this.lastName,this.gander,this.profile_path, this.occupation, this.Lang,this.city,this.country,this.country_code,this.country_loc_code,this.mentorship});

  PersonlBean.fromJson(Map<String, dynamic> json) {    
    this.firestName = json['firestName'];
    this.lastName = json['lastName'];
    this.gander = json['gander'];
    this.profile_path = json['profile_path'];
    this.occupation = json['occupation'];
    this.Lang = json['Lang'];
    this.city = json['city'];
    this.country = json['country'];
    this.country_code = json['country_code'];
    this.country_loc_code = json['country_loc_code'];
    this.mentorship = json['mentorship'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firestName'] = this.firestName;
    data['lastName'] = this.lastName;
    data['gander'] = this.gander;
    data['occupation'] = this.occupation;
    data['Lang'] = this.Lang;
    data['profile_path'] = this.profile_path;
    data['city'] = this.city;
    data['country'] = this.country;
    data['country_code'] = this.country_code;
    data['country_loc_code'] = this.country_loc_code;
    data['mentorship'] = this.mentorship;
    return data;
  }
}
class WorkListBean {

  String type_work="";
  String company="";
  String position="";
  String startdate="";
  String enddate="";

  WorkListBean(
      {
      this.type_work,
      this.company,
      this.position,
      this.startdate,
      this.enddate});
  WorkListBean.fromJson(Map<String, dynamic> json) {

    this.type_work = json['type_work'];
    this.company = json['company'];
    this.position = json['position'];
    this.startdate = json['startdate'];
    this.enddate = json['enddate'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type_work'] = this.type_work;
    data['company'] = this.company;
    data['position'] = this.position;
    data['startdate'] = this.startdate;
    data['enddate'] = this.enddate;
    return data;
  }
}
class EducationalListBean {
  String educationlavel;
  String university;
  String grade;
  var career_interest;
  String startdate;
  String enddate;

  EducationalListBean({this.educationlavel,this.university,this.grade,this.career_interest,this.startdate,this.enddate});

  EducationalListBean.fromJson(Map<String, dynamic> json) {    
    this.educationlavel = json['educationlavel'];
    this.university = json['university'];
    this.grade = json['grade'];
    this.career_interest = json['career_interest'];
    this.startdate = json['startdate'];
    this.enddate = json['enddate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['educationlavel'] = this.educationlavel;
    data['university'] = this.university;
    data['grade'] = this.grade;
    data['career_interest'] = this.career_interest;
    data['startdate'] = this.startdate;
    data['enddate'] = this.enddate;
    return data;
  }
}

class SkillsListBean {
  String skillsName;

  SkillsListBean({this.skillsName});

  SkillsListBean.fromJson(Map<String, dynamic> json) {    
    this.skillsName = json['skills_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['skills_name'] = this.skillsName;
    return data;
  }
}
