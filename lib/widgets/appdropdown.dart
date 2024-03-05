import 'package:flutter/material.dart';

class AppDropdown extends StatelessWidget {
  final String value;
  final List<String> items;
  final Function(String?) onChanged;

  const AppDropdown({
    Key? key,
    required this.value,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            width: 3,
            color: Colors.blue,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            width: 3,
            color: Colors.blue,
          ),
        ),
      ),
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: const TextStyle(color: Colors.blue),
          ),
        );
      }).toList(),
      value: value,
      onChanged: onChanged,
    );
  }
}
