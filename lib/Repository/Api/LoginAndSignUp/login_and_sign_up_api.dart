import 'dart:convert';

import 'package:http/http.dart';
import 'package:mediezy_user/Model/auth/login_model.dart';
import 'package:mediezy_user/Model/auth/sign_up_model.dart';
import 'package:mediezy_user/Repository/Api/ApiClient.dart';

class LoginAndSignUpApi {
  ApiClient apiClient = ApiClient();
  //* login
  Future<LoginModel> login(
      {required String email, required String password}) async {
    String basePath = "auth/login";
    final body = {"email": email, "password": password};
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    print(body);
    print("Login response worked");
    return LoginModel.fromJson(json.decode(response.body));
  }


  //* signup
  Future<SignUpModel> signUp(
      {required String firstName,
      required String secondName,
      required String email,
      required String mobileNumber,
      required String password}) async {
    String basePath = "Userregister";
    final body = {
      "firstname": firstName,
      "secondname": secondName,
      "mobileNo": mobileNumber,
      "email": email,
      "password":password,
      "location": "",
      "gender": "male",
    };

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    print(body);
    print("signup response worked");
    return SignUpModel.fromJson(json.decode(response.body));
  }
}
