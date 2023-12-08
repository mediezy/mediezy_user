// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediezy_user/Model/auth/login_model.dart';
import 'package:mediezy_user/Model/auth/sign_up_model.dart';
import 'package:mediezy_user/Repository/Api/LoginAndSignUp/login_and_sign_up_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_and_signup_event.dart';
part 'login_and_signup_state.dart';

class LoginAndSignupBloc
    extends Bloc<LoginAndSignupEvent, LoginAndSignupState> {
  LoginAndSignupBloc() : super(LoginAndSignupInitial()) {
    late LoginModel loginModel;
    late SignUpModel signUpModel;
    LoginAndSignUpApi loginAndSignUpApi = LoginAndSignUpApi();
    //* login bloc
    on<LoginEvent>((event, emit) async {
      final preference = await SharedPreferences.getInstance();
      emit(LoginAndSignUpLoading());
      print("<<<<<<<Loading>>>>>>>");
      try {
        loginModel = await loginAndSignUpApi.login(
            email: event.email, password: event.password);
        preference.setString('token', loginModel.token.toString());
        preference.setString(
            'firstName', loginModel.user!.firstname.toString());
        preference.setString(
            'lastName', loginModel.user!.secondname.toString());
        preference.setString('userId', loginModel.user!.id.toString());
        preference.setString(
            'phoneNumber', loginModel.user!.mobileNo.toString());
        String? token = await preference.getString('token');
        print("Tokken >>>>>>>>>>>>>>>>>>$token");
        emit(LoginAndSignUpLoaded());
      } catch (error) {
        print("Error>>>>>>>>>>>>>>>>>>>>>>" + error.toString());
        emit(LoginAndSignUpError());
      }
    });

    //* signup bloc
    on<SignUpEvent>((event, emit) async {
      emit(LoginAndSignUpLoading());
      print("<<<<<<<Loading>>>>>>>");
      try {
        signUpModel = await loginAndSignUpApi.signUp(
            email: event.email,
            password: event.password,
            firstName: event.firstname,
            secondName: event.secondname,
            mobileNumber: event.mobileNo);

        emit(LoginAndSignUpLoaded());
        print("loaded");
      } catch (error) {
        print("Error>>>>>>>>>>>>>>>>>>>>>>" + error.toString());
        emit(LoginAndSignUpError());
      }
    });
  }
}
