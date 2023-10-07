class User {
  int? id;
  String? fullname;
  String? username;
  String? email;
  String? phonenumber;
  String? password;
  String? role;
  String? userstatus;
  int? logId;

  User(
      {this.id,
        this.fullname,
        this.username,
        this.email,
        this.phonenumber,
        this.password,
        this.role,
        this.userstatus,
        this.logId});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    username = json['username'];
    email = json['email'];
    phonenumber = json['phonenumber'];
    password = json['password'];
    role = json['role'];
    userstatus = json['userstatus'];
    logId = json['log_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullname'] = this.fullname;
    data['username'] = this.username;
    data['email'] = this.email;
    data['phonenumber'] = this.phonenumber;
    data['password'] = this.password;
    data['role'] = this.role;
    data['userstatus'] = this.userstatus;
    data['log_id'] = this.logId;
    return data;
  }
}