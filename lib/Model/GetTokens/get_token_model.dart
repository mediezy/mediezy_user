class GetTokenModel {
  bool? status;
  TokenData? tokenData;

  GetTokenModel({this.status, this.tokenData});

  GetTokenModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    tokenData = json['token_data'] != null
        ? TokenData.fromJson(json['token_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (tokenData != null) {
      data['token_data'] = tokenData!.toJson();
    }
    return data;
  }
}

class TokenData {
  int? id;
  List<Tokens>? tokens;
  String? date;
  int? hospitalId;
  String? startingTime;
  String? endingTime;

  TokenData(
      {this.id,
      this.tokens,
      this.date,
      this.hospitalId,
      this.startingTime,
      this.endingTime});

  TokenData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['tokens'] != null) {
      tokens = <Tokens>[];
      json['tokens'].forEach((v) {
        tokens!.add(Tokens.fromJson(v));
      });
    }
    date = json['date'];
    hospitalId = json['hospital_Id'];
    startingTime = json['startingTime'];
    endingTime = json['endingTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (tokens != null) {
      data['tokens'] = tokens!.map((v) => v.toJson()).toList();
    }
    data['date'] = date;
    data['hospital_Id'] = hospitalId;
    data['startingTime'] = startingTime;
    data['endingTime'] = endingTime;
    return data;
  }
}

class Tokens {
  int? number;
  String? time;
  String? tokens;
  int? isBooked;
  int? isCancelled;

  Tokens(
      {this.number, this.time, this.tokens, this.isBooked, this.isCancelled});

  Tokens.fromJson(Map<String, dynamic> json) {
    number = json['Number'];
    time = json['Time'];
    tokens = json['Tokens'];
    isBooked = json['is_booked'];
    isCancelled = json['is_cancelled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Number'] = number;
    data['Time'] = time;
    data['Tokens'] = tokens;
    data['is_booked'] = isBooked;
    data['is_cancelled'] = isCancelled;
    return data;
  }
}
