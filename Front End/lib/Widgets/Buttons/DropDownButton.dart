import 'package:flutter/material.dart';

class DropdownWithArrow extends StatefulWidget {
  @override
  _DropdownWithArrowState createState() => _DropdownWithArrowState();
}

class _DropdownWithArrowState extends State<DropdownWithArrow> {
  static const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      width: width * 1 / 3,
      height: 33,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xffE2E4FB), // Set your desired border color
          width: 1.5, // Customize the border width
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        hint: Text('Select Length'),
        value: dropdownValue,
        icon: Icon(Icons.arrow_drop_down),
        // iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 0,
        ),
        onChanged: (String? value) {
          setState(() {
            dropdownValue = value!;
          });
        },
        items: list.map((String value) {
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
