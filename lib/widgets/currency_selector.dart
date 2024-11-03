import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/currency/currency_bloc.dart';

class CurrencySelector extends StatelessWidget {
  final String title;

  const CurrencySelector({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final List<String> currencies = ["RUB", "USD", "GBP"];


    return BlocBuilder<CurrencyBloc, CurrencyState>(
      builder: (context, state) {
        String? _selectedCurrency;
        final currencyBloc = context.read<CurrencyBloc>();
        return Row(
          children: [
            Expanded(
              child: TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: currencyBloc.state.currency,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                // TODO перенести в отдельную функцию
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
                                currencyBloc.add(ChangeCurrencyEvent(value!));
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
