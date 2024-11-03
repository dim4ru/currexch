import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/exchange_bloc.dart';
import '../widgets/currency_dropdown.dart';

class ExchangeScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  ExchangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final exchangeBloc = context.read<ExchangeBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Currency converter"),
      ),
      body: BlocBuilder<ExchangeBloc, ExchangeState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const CurrencyDropdown(
                    title: "You send",
                  ),
                  const SizedBox(height: 16),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.swap_vert),
                  ),
                  const SizedBox(height: 16),
                  const CurrencyDropdown(
                    title: "They get",
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        exchangeBloc.add(UserRequestExchange());
                      },
                      child: Text("Go!")),
                  SizedBox(
                    height: 16,
                  ),
                  if (state is ExchangeLoading)
                    const CircularProgressIndicator()
                  else if (state is ExchangeApiSuccessful)
                    const Text("ExchangeApiSuccessful")
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
