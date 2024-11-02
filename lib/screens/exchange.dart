import 'package:flutter/material.dart';

import '../widgets/currency_dropdown.dart';

class Exchange extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  Exchange({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Currency converter"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const CurrencyDropdown(title: "You send",),
              const SizedBox(height: 16.0),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.swap_vert),
              ),
              const SizedBox(height: 16.0),
              const CurrencyDropdown(title: "They get",),
            ],
          ),
        ),
      ),
    );
  }
}
