import 'package:flutter/material.dart';

class CustomDropdownButton extends StatelessWidget {
  final double width;
  final List<String> itemList;
  final String? dropdownValue;
  final void Function(String?)? onChanged; // Change the type here

  CustomDropdownButton({
    required this.width,
    required this.itemList,
    required this.dropdownValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 33,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xffE2E4FB),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        hint: Text('Enter Object'),
        value: dropdownValue,
        icon: Icon(Icons.arrow_drop_down),
        elevation: 16,
        style: TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 0,
        ),
        onChanged: onChanged,
        items: itemList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(value),
            ),
          );
        }).toList(),
      ),
    );
  }
}
