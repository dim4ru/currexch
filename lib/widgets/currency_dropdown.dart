import 'package:flutter/material.dart';

class CurrencyDropdown extends StatelessWidget {
  final String title;

  const CurrencyDropdown({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: title,
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_drop_down),
          padding: EdgeInsets.zero,
        ),
      ],
    );
  }
}
