import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/currency/currency_bloc.dart';

enum ExchangeDirection {from, to}

class CurrencySelector extends StatelessWidget {
  final ExchangeDirection direction;
  final CurrencyBloc currencyBloc;

  const CurrencySelector({super.key, required this.currencyBloc, required this.direction});

  @override
  Widget build(BuildContext context) {
    final List<String> currencies = ["EUR"];

    return BlocBuilder<CurrencyBloc, CurrencyState>(
      builder: (context, state) {
        final currencyBloc = context.read<CurrencyBloc>();
        String? _selectedCurrency = (direction == ExchangeDirection.from)
            ? state.currencyFrom
            : state.currencyTo;
        final controller = TextEditingController(text: _selectedCurrency);
        return Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: (direction == ExchangeDirection.from)
                      ? "You send"
                      : "They get",
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Select currency'),
                      content: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: currencies.map((currency) {
                            return RadioListTile<String>(
                              title: Text(currency),
                              value: currency,
                              groupValue: _selectedCurrency,
                              onChanged: (value) {
                                currencyBloc.add(
                                    (direction == ExchangeDirection.from)
                                        ? ChangeCurrencyFromEvent(value!)
                                        : ChangeCurrencyToEvent(value!));
                                Navigator.pop(context);
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                );
              },
              icon: const Icon(Icons.arrow_drop_down),
              padding: EdgeInsets.zero,
            ),
          ],
        );
      },
    );
  }
}
