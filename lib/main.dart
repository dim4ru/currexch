import 'package:currexch/bloc/exchange/exchange_bloc.dart';
import 'package:currexch/screens/exchange.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/currency/currency_bloc.dart';
import 'helpers/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currexch',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.primaryColor,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
            )
        ),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ExchangeBloc()..add(AppStartupEvent())),
          BlocProvider<CurrencyBloc>(create: (context) => CurrencyBloc()),
        ],
        child: ExchangeScreen(),
      ),
    );
  }
}