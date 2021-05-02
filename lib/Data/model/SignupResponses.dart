class SignupResponses {
  String Status;
  String message;
  DataBean data;

  SignupResponses({this.Status, this.message, this.data});

  SignupResponses.fromJson(Map<String, dynamic> json) {    
    this.Status = json['Status'];
    this.message = json['message'];
    this.data = json['data'] != null ? DataBean.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.Status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }

}

class DataBean {
  String name;
  String email;
  String lastname;
  String password;
  int id;

  DataBean({this.name, this.email, this.lastname, this.password, this.id});

  DataBean.fromJson(Map<String, dynamic> json) {    
    this.name = json['name'];
    this.email = json['email'];
    this.lastname = json['lastname'];
    this.password = json['password'];
    this.id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['lastname'] = this.lastname;
    data['password'] = this.password;
    data['id'] = this.id;
    return data;
  }
}
