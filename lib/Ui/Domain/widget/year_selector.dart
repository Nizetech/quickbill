import 'package:flutter/material.dart';

class YearSelector extends StatefulWidget {
  @override
  _YearSelectorState createState() => _YearSelectorState();
}

class _YearSelectorState extends State<YearSelector> {
  String? selectedYear;
  final List<String> years =
      List.generate(50, (index) => (2000 + index).toString());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade700),
        borderRadius: BorderRadius.circular(30),
        color: Colors.black,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedYear,
          hint: const Text(
            "Add Years",
            style: TextStyle(color: Colors.white),
          ),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
          dropdownColor: Colors.grey[900],
          style: const TextStyle(color: Colors.white),
          items: years.map((String year) {
            return DropdownMenuItem<String>(
              value: year,
              child: Text(year),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedYear = newValue;
            });
          },
        ),
      ),
    );
  }
}
