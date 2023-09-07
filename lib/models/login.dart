/*class Login {
  Data? data;
  bool? success;
  String? message;

  Login({this.data, this.success, this.message});

  Login.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}*/

class Login {
  int? loginId;
  String? email;
  String? password;

  Login({this.loginId, this.email,this.password});

  Login.fromJson(Map<String, dynamic> json) {
    loginId = json['login_id'];
    email = json['email'];
    password=json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login_id'] = this.loginId;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}