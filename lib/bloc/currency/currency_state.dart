part of 'currency_bloc.dart';

@immutable
abstract class CurrencyState {
  final String currency;

  CurrencyState(this.currency);
}

final class CurrencyInitial extends CurrencyState {
  CurrencyInitial(super.currency);
}

class CurrencyChanged extends CurrencyState {
  CurrencyChanged(super.currency);
}