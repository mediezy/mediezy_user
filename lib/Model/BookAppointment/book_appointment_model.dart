class BookAppointmentModel {
  bool? success;
  TokenBooking? tokenBooking;
  String? code;
  String? message;

  BookAppointmentModel(
      {this.success, this.tokenBooking, this.code, this.message});

  BookAppointmentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    tokenBooking = json['TokenBooking'] != null
        ? TokenBooking.fromJson(json['TokenBooking'])
        : null;
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (tokenBooking != null) {
      data['TokenBooking'] = tokenBooking!.toJson();
    }
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}

class TokenBooking {
  String? bookedPersonId;
  String? patientName;
  String? gender;
  String? age;
  String? mobileNo;
  String? appoinmentforId;
  String? date;
  String? tokenNumber;
  String? tokenTime;
  String? doctorId;
  String? whenitstart;
  String? whenitcomes;
  String? regularmedicine;
  String? bookingtime;
  int? patientId;
  String? clinicId;
  String? updatedAt;
  String? createdAt;
  int? id;

  TokenBooking(
      {this.bookedPersonId,
      this.patientName,
      this.gender,
      this.age,
      this.mobileNo,
      this.appoinmentforId,
      this.date,
      this.tokenNumber,
      this.tokenTime,
      this.doctorId,
      this.whenitstart,
      this.whenitcomes,
      this.regularmedicine,
      this.bookingtime,
      this.patientId,
      this.clinicId,
      this.updatedAt,
      this.createdAt,
      this.id});

  TokenBooking.fromJson(Map<String, dynamic> json) {
    bookedPersonId = json['BookedPerson_id'];
    patientName = json['PatientName'];
    gender = json['gender'];
    age = json['age'];
    mobileNo = json['MobileNo'];
    appoinmentforId = json['Appoinmentfor_id'];
    date = json['date'];
    tokenNumber = json['TokenNumber'];
    tokenTime = json['TokenTime'];
    doctorId = json['doctor_id'];
    whenitstart = json['whenitstart'];
    whenitcomes = json['whenitcomes'];
    regularmedicine = json['regularmedicine'];
    bookingtime = json['Bookingtime'];
    patientId = json['patient_id'];
    clinicId = json['clinic_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['BookedPerson_id'] = bookedPersonId;
    data['PatientName'] = patientName;
    data['gender'] = gender;
    data['age'] = age;
    data['MobileNo'] = mobileNo;
    data['Appoinmentfor_id'] = appoinmentforId;
    data['date'] = date;
    data['TokenNumber'] = tokenNumber;
    data['TokenTime'] = tokenTime;
    data['doctor_id'] = doctorId;
    data['whenitstart'] = whenitstart;
    data['whenitcomes'] = whenitcomes;
    data['regularmedicine'] = regularmedicine;
    data['Bookingtime'] = bookingtime;
    data['patient_id'] = patientId;
    data['clinic_id'] = clinicId;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
