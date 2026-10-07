class SignUpRes {
  bool? success;
  String? message;
  String? id;
  String? email;

  SignUpRes({this.success, this.message, this.id, this.email});

  SignUpRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    id = json['id'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['id'] = this.id;
    data['email'] = this.email;
    return data;
  }
}
