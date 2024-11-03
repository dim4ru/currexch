part of 'currency_bloc.dart';

@immutable
abstract class CurrencyState {
  final String currencyFrom;
  final String currencyTo;

  const CurrencyState({required this.currencyFrom, required this.currencyTo});
}

final class CurrencyInitial extends CurrencyState {
  const CurrencyInitial({required super.currencyFrom, required super.currencyTo});
}

class ChangedCurrencyState extends CurrencyState {
  const ChangedCurrencyState({required super.currencyFrom, required super.currencyTo});
}

class SwappedCurrencyState extends CurrencyState {
  const SwappedCurrencyState({required super.currencyFrom, required super.currencyTo});
}