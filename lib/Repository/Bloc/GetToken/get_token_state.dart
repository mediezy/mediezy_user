part of 'get_token_bloc.dart';

@immutable
abstract class GetTokenState {}

final class GetTokenInitial extends GetTokenState {}

final class GetTokenLoadingState extends GetTokenState {}
final class GetTokenLoadedState extends GetTokenState {}
final class GetTokenErrorState extends GetTokenState {}
