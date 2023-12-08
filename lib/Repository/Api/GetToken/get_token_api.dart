import 'dart:convert';
import 'package:http/http.dart';
import 'package:mediezy_user/Model/GetSymptoms/get_symptoms_model.dart';
import 'package:mediezy_user/Model/GetTokens/get_token_model.dart';
import 'package:mediezy_user/Repository/Api/ApiClient.dart';

class GetTokenApi {
  ApiClient apiClient = ApiClient();

  Future<GetTokenModel> getAllTokens(
      {required String doctorId,
      required String clinicId,
      required String date}) async {
    String basePath = "user/get_docter_tokens";
    final body = {"doctor_id": doctorId, "hospital_id": clinicId, "date": date};
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    print(body);
    print("<<<<<<<<GET TOKEN WORKED>>>>>>");
    return GetTokenModel.fromJson(json.decode(response.body));
  }



  //Get Symptoms api

  Future<GetSymptomsModel> getSymptoms({
    required String doctorId
}) async {

    String basePath = "symptoms/$doctorId";

    Response response =
    await apiClient.invokeAPI(path: basePath, method: "GET", body: null);
    print("<<<<<<<<<<Get Symtoms Successfully>>>>>>>>>>");
    return GetSymptomsModel.fromJson(json.decode(response.body));
  }
}
