class Personl {
  String firestName;
  String lastName;
  String occupation;
  String mobileNumber;
  String dob;

  Personl({this.firestName, this.lastName, this.occupation, this.mobileNumber, this.dob});

  Personl.fromJson(Map<String, dynamic> json) {    
    this.firestName = json['firest_name'];
    this.lastName = json['last_name'];
    this.occupation = json['occupation'];
    this.mobileNumber = json['mobile_number'];
    this.dob = json['dob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firest_name'] = this.firestName;
    data['last_name'] = this.lastName;
    data['occupation'] = this.occupation;
    data['mobile_number'] = this.mobileNumber;
    data['dob'] = this.dob;
    return data;
  }

}
