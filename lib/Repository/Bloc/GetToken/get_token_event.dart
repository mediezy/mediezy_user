part of 'get_token_bloc.dart';

@immutable
abstract class GetTokenEvent {}

class FetchTokenEvent extends GetTokenEvent {
  final String doctorId;
  final String clinicId;
  final String date;

  FetchTokenEvent(
      {required this.doctorId, required this.clinicId, required this.date});
}
