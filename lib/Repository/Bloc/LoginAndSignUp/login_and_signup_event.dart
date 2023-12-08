part of 'login_and_signup_bloc.dart';

@immutable
abstract class LoginAndSignupEvent {}

//* login
class LoginEvent extends LoginAndSignupEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

//* signup
class SignUpEvent extends LoginAndSignupEvent {
  final String email;
  final String password;
  final String firstname;
  final String secondname;
  final String mobileNo;

  SignUpEvent({
    required this.email,
    required this.password,
    required this.firstname,
    required this.secondname,
    required this.mobileNo,
  });
}
