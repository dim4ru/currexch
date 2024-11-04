part of 'exchange_bloc.dart';

@immutable
abstract class ExchangeEvent {}

class UserRequestExchange extends ExchangeEvent {
  final String currecnyFrom;
  final String currecnyTo;

  UserRequestExchange({required this.currecnyFrom, required this.currecnyTo});
}

class AppStartupEvent extends ExchangeEvent {}