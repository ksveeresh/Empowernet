class SubjectRequest{
  String subject_id;
  String sender_ids;
  String subject_name;
  String subject_mentorship;
  int req_count;
  List<Senders> senders;

  SubjectRequest({this.subject_id,this.subject_name,this.subject_mentorship,this.req_count,this.sender_ids,this.senders});
  SubjectRequest.fromJson(Map<String, dynamic> json){
    subject_id= json["subject_id"];
    subject_name= json["subject_name"];
    subject_mentorship= json["subject_mentorship"];
    req_count= json["req_count"];
    sender_ids= json["sender_ids"];
    if (json['senders'] != null) {
      senders = new List<Senders>.empty(growable: true);
      json['senders'].forEach((v) {
        senders.add(new Senders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject_id'] = subject_id;
    data['subject_name'] = this.subject_name;
    data['subject_mentorship'] = this.subject_mentorship;
    data['req_count'] = this.req_count;
    data['sender_ids'] = this.sender_ids;
    if (this.senders != null) {
      data['senders'] = this.senders.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return '$subject_name';
  }
}
class Senders {
  String senderId;
  String senderName;
  String senderPeofile;
  String senderOcupation;
  String senderDes;

  Senders(
      {this.senderId,
        this.senderName,
        this.senderPeofile,
        this.senderOcupation,
        this.senderDes
      });

  Senders.fromJson(Map<String, dynamic> json) {
    senderId = json['sender_id'];
    senderName = json['sender_name'];
    senderPeofile = json['sender_peofile'];
    senderOcupation = json['sender_ocupation'];
    senderDes = json['sender_des'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sender_id'] = this.senderId;
    data['sender_name'] = this.senderName;
    data['sender_peofile'] = this.senderPeofile;
    data['sender_ocupation'] = this.senderOcupation;
    data['sender_des'] = this.senderDes;
    return data;
  }
}