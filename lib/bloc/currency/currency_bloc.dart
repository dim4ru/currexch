import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'currency_event.dart';
part 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  // TODO указывать initial в state
  CurrencyBloc() : super(const CurrencyInitial(currencyFrom: 'Choose', currencyTo: 'Choose')) {

    on<ChangeCurrencyFromEvent>((event, emit) {
      emit(ChangedCurrencyState(currencyFrom: event.currencyFrom, currencyTo: state.currencyTo));
      print("CURRENCY FROM CHANGED: ${event.currencyFrom}");
    });

    on<ChangeCurrencyToEvent>((event, emit) {
      emit(ChangedCurrencyState(currencyFrom: state.currencyFrom, currencyTo: event.currencyTo));
      print("CURRENCY TO CHANGED: ${event.currencyTo}");
    });

    on<SwapCurrencyEvent>((event, emit) {
      emit(SwappedCurrencyState(
          currencyFrom: state.currencyTo,
          currencyTo: state.currencyFrom,
      ));
      print("SWAP ${state.currencyFrom}->${state.currencyTo}");
    });
  }
}
