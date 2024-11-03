part of 'currency_bloc.dart';

abstract class CurrencyEvent {}

class ChangeCurrencyFromEvent extends CurrencyEvent {
  final String currencyFrom;

  ChangeCurrencyFromEvent(this.currencyFrom);
}

class ChangeCurrencyToEvent extends CurrencyEvent {
  final String currencyTo;

  ChangeCurrencyToEvent(this.currencyTo);
}

class SwapCurrencyEvent extends CurrencyEvent {
  final String currencyFrom;
  final String currencyTo;

  SwapCurrencyEvent({required this.currencyFrom, required this.currencyTo});
}