import 'package:flutter/material.dart';
import 'package:mediezy_user/Models/saved_doctor_model.dart';

class SavedDoctorController with ChangeNotifier {
  Map<String, SavedDoctorModel> _savedDoctors = {};

  //* get saved doctors
  Map<String, SavedDoctorModel> get getSavedDoctors {
    return _savedDoctors;
  }

  //* add and remove doctors to saved
  void toSaveDoctorAndUnSaveDoctor({required String doctorId}) {
    if (_savedDoctors.containsKey(doctorId)) {
      removeDoctor(doctorId);
    } else {
      _savedDoctors.putIfAbsent(
        doctorId,
        () => SavedDoctorModel(
            savedId: DateTime.now().toString(), doctorId: doctorId),
      );
    }
    notifyListeners();
  }

  //* remove  single doctor from list
  void removeDoctor(String doctorId) {
    _savedDoctors.remove(doctorId);
    notifyListeners();
  }
}
