import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'exchange_event.dart';
part 'exchange_state.dart';

class ExchangeBloc extends Bloc<ExchangeEvent, ExchangeState> {
  ExchangeBloc() : super(ExchangeInitial()) {

    on<AppStartup>((event, emit) async {
      print("Currencies loaded: ...");
      // TODO Закомментировано в целях экономии запросов
      // try {
      //   final dio = Dio();
      //   final response = await dio.get('https://api.exchangeratesapi.io/v1/latest?access_key=dca0810669ccd43d7253437f759a61d6');
      //   print("Currencies loaded: ${response.data}"); // Print the successful response data
      // } catch (error) {
      //   print("Error loading currencies: $error"); // Print the error
      // }
    });

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
