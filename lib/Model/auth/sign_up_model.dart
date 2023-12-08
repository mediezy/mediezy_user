class SignUpModel {
  bool? success;
  Users? users;
  String? code;
  String? message;

  SignUpModel({this.success, this.users, this.code, this.message});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    users = json['users'] != null ? Users.fromJson(json['users']) : null;
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (users != null) {
      data['users'] = users!.toJson();
    }
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}

class Users {
  String? firstname;
  String? lastname;
  String? mobileNo;
  String? email;
  String? location;
  String? gender;
  int? userId;
  String? updatedAt;
  String? createdAt;
  int? id;

  Users(
      {this.firstname,
      this.lastname,
      this.mobileNo,
      this.email,
      this.location,
      this.gender,
      this.userId,
      this.updatedAt,
      this.createdAt,
      this.id});

  Users.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    mobileNo = json['mobileNo'];
    email = json['email'];
    location = json['location'];
    gender = json['gender'];
    userId = json['UserId'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['mobileNo'] = mobileNo;
    data['email'] = email;
    data['location'] = location;
    data['gender'] = gender;
    data['UserId'] = userId;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
