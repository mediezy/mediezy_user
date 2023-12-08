import 'package:flutter/material.dart';

class AppointmentModel with ChangeNotifier {
  final String appointmentId;
  final String doctorId;
  final String appointmentDate;
  final String appointmentTime;

  AppointmentModel(
      {required this.appointmentId,
      required this.doctorId,
      required this.appointmentDate,
      required this.appointmentTime});
}
