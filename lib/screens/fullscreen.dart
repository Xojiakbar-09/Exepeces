import 'dart:io';

import 'package:expensiv/consts/colors/color.dart';
import 'package:flutter/material.dart';

class Fullscreen extends StatelessWidget {
  const Fullscreen({super.key, required this.rasm});
  final File rasm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cols.black,
      appBar: AppBar(
        leading: IconButton.outlined(
          style: IconButton.styleFrom(side: BorderSide(color: Cols.white)),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close, color: Cols.white),
        ),
        backgroundColor: Cols.black,
      ),
      body: Center(child: Hero( tag: 'rasm1', child: Image.file(rasm, fit: BoxFit.cover))),
    );
  }
}
