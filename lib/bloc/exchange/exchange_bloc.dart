import 'package:bloc/bloc.dart';
import 'package:currexch/collections/currency.dart';
import 'package:dio/dio.dart';
import 'package:isar/isar.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

part 'exchange_event.dart';
part 'exchange_state.dart';

class ExchangeBloc extends Bloc<ExchangeEvent, ExchangeState> {
  ExchangeBloc() : super(ExchangeInitial()) {

    on<AppStartupEvent>((event, emit) async {
      final dbDirectory = await getApplicationSupportDirectory();

      final isar = await Isar.open([CurrencySchema], directory: dbDirectory.path);

      try {
        final dio = Dio();
        final response = await dio.get('https://api.exchangeratesapi.io/v1/latest?access_key=dca0810669ccd43d7253437f759a61d6');
        print("Currencies loaded: ${response.data}");

        await isar.writeTxn(() async {
          await isar.currencys.clear();

          final Map<String, double> rates = (response.data['rates'] as Map).map((key, value) {
            return MapEntry(key, double.parse(value.toString()));
          }).cast<String, double>();

          for (final currency in rates.keys) {
            await isar.currencys.put(Currency()
              ..currency = currency
              ..rate = rates[currency]!);
          }
        });

        await isar.close();

      } catch (error) {
        print("Error loading currencies: $error");
      }
    });

    on<UserRequestExchange>((event, emit) async {
      emit(ExchangeLoading());

      try {
        final dio = Dio();
        final response = await dio.get('https://api.exchangeratesapi.io/v1/latest?access_key=dca0810669ccd43d7253437f759a61d6&base=${event.currencyFrom}&symbols=${event.currencyTo}');

        if (response.statusCode == 200) {
          final result = response.data['rates'][event.currencyTo].toString();
          emit(ExchangeApiSuccessful(result: result));
          return;
        } else {
          throw DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.unknown,
          );
        }
      } on DioException catch (e) {
        try {

          final dbDirectory = await getApplicationSupportDirectory();
          final isar = await Isar.open([CurrencySchema], directory: dbDirectory.path);
          final result = await isar.currencys.getByCurrency(event.currencyTo);
          await isar.close();

          if (result != null) {
            emit(ExchangeCacheSuccessful(result: result.rate.toString()));
          } else {
            throw Exception('Exchange rate not found in local storage');
          }
        } on Exception catch (e) {
          String errorMessage = 'An error occurred';

          if (e.toString() != 'Exchange rate not found in local storage') {
            errorMessage = e.toString();
          }

          emit(ExchangeError(message: errorMessage));
        }
      }
    });
  }
}
