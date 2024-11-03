part of 'currency_bloc.dart';

abstract class CurrencyEvent {}

@immutable
class ChangeCurrencyEvent extends CurrencyEvent {
  final String currency;

  ChangeCurrencyEvent(this.currency);
}
