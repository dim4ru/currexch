part of 'exchange_bloc.dart';

@immutable
abstract class ExchangeEvent {}

class UserRequestExchange extends ExchangeEvent {
  final String currencyFrom;
  final String currencyTo;

  UserRequestExchange({required this.currencyFrom, required this.currencyTo});
}

class AppStartupEvent extends ExchangeEvent {}