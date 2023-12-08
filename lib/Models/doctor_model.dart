import 'package:flutter/material.dart';

class DoctorModelA with ChangeNotifier {
  final String id;
  final String firstName;
  final String lastName;
  final String location;
  final String mobileNumber;
  final String imageUrl;
  final String specialisation;
  final String about;
  final double doctorRating;
  final List specifications;
  final List subSpecifications;
  final List worksAt;
  final List availableDates;
  final List availableTimes;

  DoctorModelA(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.location,
      required this.mobileNumber,
      required this.imageUrl,
      required this.specialisation,
      required this.about,
      required this.doctorRating,
      required this.specifications,
      required this.subSpecifications,
      required this.worksAt,
      required this.availableDates,
      required this.availableTimes});
}
