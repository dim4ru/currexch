import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/currency/currency_bloc.dart';

class CurrencyFromSelector extends StatelessWidget {
  final String title;
  final CurrencyBloc currencyBloc;

  const CurrencyFromSelector({super.key, required this.title, required this.currencyBloc});

  @override
  Widget build(BuildContext context) {
    final List<String> currencies = ["RUB", "USD", "GBP"];

    return BlocBuilder<CurrencyBloc, CurrencyState>(
      builder: (context, state) {
        final currencyBloc = context.read<CurrencyBloc>();
        String? _selectedCurrency = state.currencyFrom;
        final controller = TextEditingController(text: _selectedCurrency);
        return Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: title,
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
                                currencyBloc.add(ChangeCurrencyFromEvent(value!));
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
