import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'exchange_event.dart';
part 'exchange_state.dart';

class ExchangeBloc extends Bloc<ExchangeEvent, ExchangeState> {
  ExchangeBloc() : super(ExchangeInitial()) {

    on<AppStartupEvent>((event, emit) async {
      try {
        final dio = Dio();
        final response = await dio.get('https://api.exchangeratesapi.io/v1/latest?access_key=dca0810669ccd43d7253437f759a61d6');
        print("Currencies loaded: ${response.data}");
      } catch (error) {
        print("Error loading currencies: $error");
      }
    });

    on<UserRequestExchange>((event, emit) async {
      emit(ExchangeLoading());

      try {
        final dio = Dio();
        final response = await dio.get('https://api.exchangeratesapi.io/v1/latest?access_key=dca0810669ccd43d7253437f759a61d6&base=${event.currecnyFrom}&symbols=${event.currecnyTo}');

        if (response.statusCode == 200) {
          final result = response.data['rates'][event.currecnyTo].toString();
          emit(ExchangeApiSuccessful(result: result));
        } else {
          throw DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.unknown,
          );
        }
      } on DioException catch (e) {
        String errorMessage = 'An error occurred';

        if (e.response != null) {
          errorMessage = e.response!.statusMessage ?? errorMessage;
        }

        emit(ExchangeError(message: errorMessage));
      }
    });
  }
}
