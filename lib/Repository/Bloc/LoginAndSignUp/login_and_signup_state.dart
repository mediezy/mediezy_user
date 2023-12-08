part of 'login_and_signup_bloc.dart';

@immutable
sealed class LoginAndSignupState {}

final class LoginAndSignupInitial extends LoginAndSignupState {}



class LoginAndSignUpLoading extends LoginAndSignupState {}
class LoginAndSignUpLoaded extends LoginAndSignupState {}
class LoginAndSignUpError extends LoginAndSignupState {}