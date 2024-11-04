part of 'exchange_bloc.dart';

@immutable
sealed class ExchangeState {}

final class ExchangeInitial extends ExchangeState {}

class ExchangeLoading extends ExchangeState {}

class ExchangeApiSuccessful extends ExchangeState {
  final String result;

  ExchangeApiSuccessful({required this.result});
}

class ExchangeCacheSuccessful extends ExchangeState {}

class ExchangeError extends ExchangeState {
  final String message;

  ExchangeError({required this.message});
}