import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/currency/currency_bloc.dart';
import '../bloc/exchange/exchange_bloc.dart';
import '../widgets/currency_from_selector.dart';
import '../widgets/currency_to_selector.dart';
import '../widgets/result_text.dart';

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
      body: BlocProvider(
        create: (context) => CurrencyBloc(),
        child: BlocBuilder<ExchangeBloc, ExchangeState>(
          builder: (context, state) {
            final currencyBloc = context.read<CurrencyBloc>();

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CurrencyFromSelector(
                      title: "You send",
                      currencyBloc: currencyBloc,
                    ),
                    const SizedBox(height: 16),
                    IconButton(
                      onPressed: () {
                        currencyBloc.add(SwapCurrencyEvent());
                      },
                      icon: const Icon(Icons.swap_vert),
                    ),
                    const SizedBox(height: 16),
                    CurrencyToSelector(
                        title: "They get",
                        currencyBloc: currencyBloc),
                    const SizedBox(
                      height: 16,
                    ),
                  ElevatedButton(
                      onPressed: () {
                        exchangeBloc.add(UserRequestExchange(currecnyFrom: currencyBloc.state.currencyFrom ,currecnyTo: currencyBloc.state.currencyTo));
                      },
                      child: Text("Go!")),
                  const SizedBox(
                    height: 16,
                  ),
                    if (state is ExchangeLoading)
                      const CircularProgressIndicator()
                    else if (state is ExchangeApiSuccessful)
                      Text(state.result, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),)
                    else if (state is ExchangeError)
                      Text("Ошибка конвертации (${state.message})"),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
