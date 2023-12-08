import 'dart:convert';

import 'package:http/http.dart';
import 'package:mediezy_user/Model/Profile/edit_user_model.dart';
import 'package:mediezy_user/Model/Profile/get_user_model.dart';
import 'package:mediezy_user/Repository/Api/ApiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileApi {
  ApiClient apiClient = ApiClient();

  //* get user details
  Future<GetUserModel> getUserDetails() async {
    final preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    String basePath = "Useredit/$userId";
    Response response =
        await apiClient.invokeAPI(path: basePath, method: "GET", body: null);
    print("<<<<<<<<Get User WORKED>>>>>>");
    return GetUserModel.fromJson(
      json.decode(response.body),
    );
  }

  //* edit user details
  Future<EditUserModel> editUserDetails({
    // Future<EditProfileModel> getEditProfile({
    required String firstName,
    required String secondName,
    required String email,
    required String mobileNo,
    required String location,
    required String gender,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    String basePath = "Userupdate/$userId";
    final body = {
      "firstname": firstName,
      "secondname": secondName,
      "email": email,
      "mobileNo": mobileNo,
      "location": location,
      "gender": gender,
    };

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "PUT", body: body);
    print(body);
    return EditUserModel.fromJson(json.decode(response.body));
  }
}
