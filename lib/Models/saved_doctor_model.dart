import 'package:flutter/material.dart';

class SavedDoctorModel with ChangeNotifier {
  final String savedId;
  final String doctorId;

  SavedDoctorModel({required this.savedId, required this.doctorId});
}
