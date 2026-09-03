import 'package:expensiv/consts/colors/color.dart';
import 'package:flutter/material.dart';

class Customtextfild extends StatelessWidget {
  const Customtextfild({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Cols.grey,
      cursorWidth: 1,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderSide: BorderSide.none),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: Cols.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: Cols.grey),
        ),

        hintText: 'ADD NOTE',
        hintStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Cols.grey,
        ),
      ),
    );
  }
}
