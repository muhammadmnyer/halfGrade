import 'package:flutter/material.dart';

class MyDropDown extends StatelessWidget {
  final String hint;
  final String? Function(String? value) validator;
  final void Function(String? value) onChanged;
  final IconData icon;
  final List<String> values;


  const MyDropDown({
        super.key,
        required this.hint,
        required this.validator,
        required this.icon,
        required this.values,
        required this.onChanged
      });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      hint: Text(hint),
      validator: validator,
      dropdownColor: Colors.white,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.black.withOpacity(0.1),

          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none),
          prefixIcon: Icon(icon)),
      items: List<DropdownMenuItem<String>>.generate(
        values.length,
        (index) => DropdownMenuItem<String>(
            value: values[index],
            child: Text(values[index])
        ),
      
      ),
      onChanged: onChanged,
    );
  }
}
