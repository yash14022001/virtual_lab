import 'package:flutter/material.dart';

class CustomDropDown<T> extends StatelessWidget {
  final String hintText;
  final List<T> options;
  final T value;
  final String Function(T) getLabel;
  final void Function(T?)? onChanged;

  CustomDropDown({
    this.hintText = 'Please select an Option',
    this.options = const [],
    required this.getLabel,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      builder: (FormFieldState<T> state) {
        return InputDecorator(
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            // labelStyle: textStyle,
            errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
            hintText: hintText,
            hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            labelText: hintText,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
          isEmpty: value == null || value == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              isDense: true,
              menuMaxHeight: 500,
              onChanged: onChanged,
              isExpanded: true,
              items: options.map((T value) {
                return DropdownMenuItem<T>(
                  value: value,
                  child: Text(getLabel(value)),
                );
              }).toList(),
              // selectedItemBuilder: (BuildContext context) {
              //   return options.map((T value) {
              //     return Text(
              //       getLabel(value),
              //       style: const TextStyle(color: Colors.blue),
              //     );
              //   }).toList();
              // },
            ),
          ),
        );
      },
    );
  }
}
