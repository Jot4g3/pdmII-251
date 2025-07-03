import 'package:flutter/material.dart';

class TextFieldCustomized extends StatelessWidget {
  final String placeholder;
  final Color color;
  final Function(String) onChanged;

  const TextFieldCustomized({super.key, required this.placeholder, required this.color, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withAlpha(20),
            blurRadius: 4,
            offset: Offset(4, 8), // Shadow position
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          autofocus: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: placeholder,
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
