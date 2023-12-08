class DoctorModel {
  bool? success;
  List<Docters>? docters;
  String? code;
  String? message;

  DoctorModel({this.success, this.docters, this.code, this.message});

  DoctorModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['Docters'] != null) {
      docters = <Docters>[];
      json['Docters'].forEach((v) {
        docters!.add(new Docters.fromJson(v));
      });
    }
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.docters != null) {
      data['Docters'] = this.docters!.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }
}

class Docters {
  int? id;
  int? userId;
  String? firstname;
  String? secondname;
  String? specialization;
  String? docterImage;
  String? about;
  String? location;
  String? gender;
  String? emailID;
  String? mobileNumber;
  String? mainHospital;
  String? subspecificationId;
  String? specificationId;
  List<String>? specifications;
  List<String>? subspecifications;
  List<Clincs>? clincs;
  int? favoriteStatus;

  Docters(
      {this.id,
      this.userId,
      this.firstname,
      this.secondname,
      this.specialization,
      this.docterImage,
      this.about,
      this.location,
      this.gender,
      this.emailID,
      this.mobileNumber,
      this.mainHospital,
      this.subspecificationId,
      this.specificationId,
      this.specifications,
      this.subspecifications,
      this.clincs,
      this.favoriteStatus});

  Docters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['UserId'];
    firstname = json['firstname'];
    secondname = json['secondname'];
    specialization = json['Specialization'];
    docterImage = json['DocterImage'];
    about = json['About'];
    location = json['Location'];
    gender = json['Gender'];
    emailID = json['emailID'];
    mobileNumber = json['Mobile Number'];
    mainHospital = json['MainHospital'];
    subspecificationId = json['subspecification_id'];
    specificationId = json['specification_id'];
    specifications = json['specifications'].cast<String>();
    subspecifications = json['subspecifications'].cast<String>();
    if (json['clincs'] != null) {
      clincs = <Clincs>[];
      json['clincs'].forEach((v) {
        clincs!.add(new Clincs.fromJson(v));
      });
    }
    favoriteStatus = json['favoriteStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['UserId'] = this.userId;
    data['firstname'] = this.firstname;
    data['secondname'] = this.secondname;
    data['Specialization'] = this.specialization;
    data['DocterImage'] = this.docterImage;
    data['About'] = this.about;
    data['Location'] = this.location;
    data['Gender'] = this.gender;
    data['emailID'] = this.emailID;
    data['Mobile Number'] = this.mobileNumber;
    data['MainHospital'] = this.mainHospital;
    data['subspecification_id'] = this.subspecificationId;
    data['specification_id'] = this.specificationId;
    data['specifications'] = this.specifications;
    data['subspecifications'] = this.subspecifications;
    if (this.clincs != null) {
      data['clincs'] = this.clincs!.map((v) => v.toJson()).toList();
    }
    data['favoriteStatus'] = this.favoriteStatus;
    return data;
  }
}

class Clincs {
  int? id;
  String? name;
  String? availability;

  Clincs({this.id, this.name, this.availability});

  Clincs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    availability = json['availability'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['availability'] = this.availability;
    return data;
  }
}
