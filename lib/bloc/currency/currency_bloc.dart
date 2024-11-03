import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'currency_event.dart';
part 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  CurrencyBloc() : super(CurrencyInitial('RUB')) {
    on<ChangeCurrencyEvent>((event, emit) {
      emit(CurrencyChanged(event.currency));
      print("CHANGED to ${event.currency}");
    });
  }
}
