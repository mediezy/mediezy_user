import 'package:bloc/bloc.dart';
import 'package:mediezy_user/Model/GetTokens/get_token_model.dart';
import 'package:mediezy_user/Repository/Api/GetToken/get_token_api.dart';
import 'package:meta/meta.dart';
part 'get_token_event.dart';
part 'get_token_state.dart';

class GetTokenBloc extends Bloc<GetTokenEvent, GetTokenState> {
  late GetTokenModel getTokenModel;
  GetTokenApi getTokenApi = GetTokenApi();
  GetTokenBloc() : super(GetTokenInitial()) {
    on<FetchTokenEvent>((event, emit) async {
      emit(GetTokenLoadingState());
      try {
        getTokenModel = await getTokenApi.getAllTokens(
            doctorId: event.doctorId,
            clinicId: event.clinicId,
            date: event.date
        );
        emit(GetTokenLoadedState());
      } catch (error) {
        print("Error>>>>>>>>>>>>>>>>>>>>>>" + error.toString());
        emit(GetTokenErrorState());
      }
    });
  }
}
