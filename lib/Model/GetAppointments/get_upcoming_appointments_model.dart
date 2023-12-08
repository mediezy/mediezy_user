class GetUpComingAppointmentsModel {
  bool? success;
  Appointments? appointments;
  String? code;
  String? message;

  GetUpComingAppointmentsModel(
      {this.success, this.appointments, this.code, this.message});

  GetUpComingAppointmentsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    appointments = json['Appointments'] != null
        ? Appointments.fromJson(json['Appointments'])
        : null;
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (appointments != null) {
      data['Appointments'] = appointments!.toJson();
    }
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}

class Appointments {
  List<AppointmentsDetails>? appointmentsDetails;
  String? currentOngoingToken;

  Appointments({this.appointmentsDetails, this.currentOngoingToken});

  Appointments.fromJson(Map<String, dynamic> json) {
    if (json['appointmentsDetails'] != null) {
      appointmentsDetails = <AppointmentsDetails>[];
      json['appointmentsDetails'].forEach((v) {
        appointmentsDetails!.add(AppointmentsDetails.fromJson(v));
      });
    }
    currentOngoingToken = json['currentOngoingToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (appointmentsDetails != null) {
      data['appointmentsDetails'] =
          appointmentsDetails!.map((v) => v.toJson()).toList();
    }
    data['currentOngoingToken'] = currentOngoingToken;
    return data;
  }
}

class AppointmentsDetails {
  String? tokenNumber;
  String? date;
  String? startingtime;
  String? patientName;
  List<MainSymptoms>? mainSymptoms;
  List<OtherSymptoms>? otherSymptoms;
  String? tokenBookingDate;
  String? tokenBookingTime;
  String? consultationStartsfrom;
  int? doctorEarlyFor;
  int? doctorLateFor;
  String? firstname;
  String? secondname;
  String? specialization;
  String? docterImage;
  String? mobileNumber;
  String? mainHospital;
  String? subspecificationId;
  String? specificationId;
  List<String>? specifications;
  List<String>? subspecifications;
  List<Clincs>? clincs;
  String? estimateTime;

  AppointmentsDetails(
      {this.tokenNumber,
      this.date,
      this.startingtime,
      this.patientName,
      this.mainSymptoms,
      this.otherSymptoms,
      this.tokenBookingDate,
      this.tokenBookingTime,
      this.consultationStartsfrom,
      this.doctorEarlyFor,
      this.doctorLateFor,
      this.firstname,
      this.secondname,
      this.specialization,
      this.docterImage,
      this.mobileNumber,
      this.mainHospital,
      this.subspecificationId,
      this.specificationId,
      this.specifications,
      this.subspecifications,
      this.clincs,
      this.estimateTime});

  AppointmentsDetails.fromJson(Map<String, dynamic> json) {
    tokenNumber = json['TokenNumber'];
    date = json['Date'];
    startingtime = json['Startingtime'];
    patientName = json['PatientName'];
    if (json['main_symptoms'] != null) {
      mainSymptoms = <MainSymptoms>[];
      json['main_symptoms'].forEach((v) {
        mainSymptoms!.add(MainSymptoms.fromJson(v));
      });
    }
    if (json['other_symptoms'] != null) {
      otherSymptoms = <OtherSymptoms>[];
      json['other_symptoms'].forEach((v) {
        otherSymptoms!.add(OtherSymptoms.fromJson(v));
      });
    }
    tokenBookingDate = json['TokenBookingDate'];
    tokenBookingTime = json['TokenBookingTime'];
    consultationStartsfrom = json['ConsultationStartsfrom'];
    doctorEarlyFor = json['DoctorEarlyFor'];
    doctorLateFor = json['DoctorLateFor'];
    firstname = json['firstname'];
    secondname = json['secondname'];
    specialization = json['Specialization'];
    docterImage = json['DocterImage'];
    mobileNumber = json['Mobile Number'];
    mainHospital = json['MainHospital'];
    subspecificationId = json['subspecification_id'];
    specificationId = json['specification_id'];
    specifications = json['specifications'].cast<String>();
    subspecifications = json['subspecifications'].cast<String>();
    if (json['clincs'] != null) {
      clincs = <Clincs>[];
      json['clincs'].forEach((v) {
        clincs!.add(Clincs.fromJson(v));
      });
    }
    estimateTime = json['estimateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TokenNumber'] = tokenNumber;
    data['Date'] = date;
    data['Startingtime'] = startingtime;
    data['PatientName'] = patientName;
    if (mainSymptoms != null) {
      data['main_symptoms'] =
          mainSymptoms!.map((v) => v.toJson()).toList();
    }
    if (otherSymptoms != null) {
      data['other_symptoms'] =
          otherSymptoms!.map((v) => v.toJson()).toList();
    }
    data['TokenBookingDate'] = tokenBookingDate;
    data['TokenBookingTime'] = tokenBookingTime;
    data['ConsultationStartsfrom'] = consultationStartsfrom;
    data['DoctorEarlyFor'] = doctorEarlyFor;
    data['DoctorLateFor'] = doctorLateFor;
    data['firstname'] = firstname;
    data['secondname'] = secondname;
    data['Specialization'] = specialization;
    data['DocterImage'] = docterImage;
    data['Mobile Number'] = mobileNumber;
    data['MainHospital'] = mainHospital;
    data['subspecification_id'] = subspecificationId;
    data['specification_id'] = specificationId;
    data['specifications'] = specifications;
    data['subspecifications'] = subspecifications;
    if (clincs != null) {
      data['clincs'] = clincs!.map((v) => v.toJson()).toList();
    }
    data['estimateTime'] = estimateTime;
    return data;
  }
}

class MainSymptoms {
  int? id;
  String? symtoms;

  MainSymptoms({this.id, this.symtoms});

  MainSymptoms.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symtoms = json['symtoms'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['symtoms'] = symtoms;
    return data;
  }
}

class OtherSymptoms {
  int? id;
  String? symtoms;

  OtherSymptoms({this.id, this.symtoms});

  OtherSymptoms.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symtoms = json['symtoms'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['symtoms'] = symtoms;
    return data;
  }
}

class Clincs {
  int? id;
  String? hospitalName;
  String? availability;

  Clincs({this.id, this.hospitalName, this.availability});

  Clincs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hospitalName = json['hospital_Name'];
    availability = json['availability'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['hospital_Name'] = hospitalName;
    data['availability'] = availability;
    return data;
  }
}
