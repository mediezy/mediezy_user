import 'dart:convert';
import 'package:http/http.dart';
import 'package:mediezy_user/Model/BookAppointment/book_appointment_model.dart';
import 'package:mediezy_user/Repository/Api/ApiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookAppointmentApi {
  ApiClient apiClient = ApiClient();

  Future<BookAppointmentModel> bookAppointment({
    required String patientName,
    required String doctorId,
    required String clinicId,
    required String date,
    required String regularmedicine,
    required String whenitcomes,
    required String whenitstart,
    required String tokenTime,
    required String tokenNumber,
    required String gender,
    required String age,
    required String mobileNo,
    required String bookingType,
    required List<String> appoinmentfor1,
    required List<int> appoinmentfor2,

  }) async {
    String basePath = "TokenBooking";
    final preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    final body = {
      "BookedPerson_id": userId,
      "PatientName": patientName,
      "date": date,
      "regularmedicine": regularmedicine,
      "whenitcomes": whenitcomes,
      "whenitstart": whenitstart,
      "TokenTime": tokenTime,
      "TokenNumber": tokenNumber,
      "MobileNo": mobileNo,
      "age": age,
      "gender": gender,
      "Appoinmentfor1": appoinmentfor1,
      "Appoinmentfor2": appoinmentfor2,
      "doctor_id": doctorId,
      "clinic_id":clinicId,
      "Bookingtype":bookingType,
    };
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    print(body);
    print("<<<<<<<<<<BOOK APPOINTMENT WORKED SUCCESSFULLY>>>>>>>>>>");
    return BookAppointmentModel.fromJson(json.decode(response.body));
  }

}