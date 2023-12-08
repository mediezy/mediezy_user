class GetUserModel {
  GetUserModel({
      this.success, 
      this.userdetails, 
      this.code, 
      this.message,});

  GetUserModel.fromJson(dynamic json) {
    success = json['success'];
    userdetails = json['Userdetails'] != null ? Userdetails.fromJson(json['Userdetails']) : null;
    code = json['code'];
    message = json['message'];
  }
  bool? success;
  Userdetails? userdetails;
  String? code;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (userdetails != null) {
      map['Userdetails'] = userdetails?.toJson();
    }
    map['code'] = code;
    map['message'] = message;
    return map;
  }

}

class Userdetails {
  Userdetails({
      this.id, 
      this.firstname, 
      this.lastname, 
      this.userImage, 
      this.mobileNo, 
      this.gender, 
      this.location, 
      this.email, 
      this.userId, 
      this.createdAt, 
      this.updatedAt,});

  Userdetails.fromJson(dynamic json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    userImage = json['user_image'];
    mobileNo = json['mobileNo'];
    gender = json['gender'];
    location = json['location'];
    email = json['email'];
    userId = json['UserId'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? firstname;
  String? lastname;
  dynamic userImage;
  String? mobileNo;
  String? gender;
  String? location;
  String? email;
  int? userId;
  dynamic createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['firstname'] = firstname;
    map['lastname'] = lastname;
    map['user_image'] = userImage;
    map['mobileNo'] = mobileNo;
    map['gender'] = gender;
    map['location'] = location;
    map['email'] = email;
    map['UserId'] = userId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}