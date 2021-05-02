class CreateprofileResponse {
  String Status;
  String data;
  String message;

  CreateprofileResponse({this.Status, this.data, this.message});

  CreateprofileResponse.fromJson(Map<String, dynamic> json) {    
    this.Status = json['Status'];
    this.data = json['data'];
    this.message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.Status;
    data['data'] = this.data;
    data['message'] = this.message;
    return data;
  }

}
