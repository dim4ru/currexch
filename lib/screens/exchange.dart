import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/currency/currency_bloc.dart';
import '../bloc/exchange/exchange_bloc.dart';
import '../widgets/currency_selector.dart';

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
                    CurrencySelector(
                      currencyBloc: currencyBloc,
                      direction: ExchangeDirection.from,
                    ),
                    const SizedBox(height: 16),
                    IconButton(
                      onPressed: () {
                        currencyBloc.add(SwapCurrencyEvent());
                      },
                      icon: const Icon(Icons.swap_vert),
                    ),
                    const SizedBox(height: 16),
                    CurrencySelector(
                        currencyBloc: currencyBloc,
                        direction: ExchangeDirection.to,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ElevatedButton(
                      onPressed: () {
                        exchangeBloc.add(UserRequestExchange(currencyFrom: currencyBloc.state.currencyFrom ,currencyTo: currencyBloc.state.currencyTo));
                      },
                      child: const Text("Go!")),
                  const SizedBox(
                    height: 16,
                  ),
                    if (state is ExchangeLoading)
                      const CircularProgressIndicator()
                    else if (state is ExchangeApiSuccessful)
                      Text(
                        state.result,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      )
                    else if (state is ExchangeCacheSuccessful)
                      Column(
                        children: [
                          Text(
                            state.result,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600),
                          ),
                          const Row(
                            children: [
                              Icon(Icons.warning_amber),
                              SizedBox(width: 16,),
                              Expanded(
                                child: Text(
                                  "The result is definitely outdated because exchange rate from local storage was used. Establish your internet connection to get up to date rates and update your local exchange rates storage.",
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
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
