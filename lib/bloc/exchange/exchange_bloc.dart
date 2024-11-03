import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'exchange_event.dart';
part 'exchange_state.dart';

class ExchangeBloc extends Bloc<ExchangeEvent, ExchangeState> {
  ExchangeBloc() : super(ExchangeInitial()) {
    on<UserRequestExchange>((event, emit) async {
      emit(ExchangeLoading());
      final dio = Dio();
      final response = await dio.get('https://api.exchangeratesapi.io/v1/symbols?access_key=dca0810669ccd43d7253437f759a61d6');
      if (response.statusCode == 200) {
        print(response.data);
        emit(ExchangeApiSuccessful());
      } else {
        print(response.statusCode);
        ExchangeError();
      }
    });
  }
}
