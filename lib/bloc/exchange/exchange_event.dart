part of 'exchange_bloc.dart';

@immutable
abstract class ExchangeEvent {}

class UserRequestExchange extends ExchangeEvent {}

class AppStartup extends ExchangeEvent {}