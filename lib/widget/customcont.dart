import 'package:expensiv/consts/colors/color.dart';
import 'package:flutter/material.dart';

class Customcont extends StatelessWidget {
  final Widget widget;
  final String title;
  final String subtitle;
  final String pul;
  const Customcont({super.key, required this.widget, required this.title, required this.subtitle, required this.pul});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            spacing: 16,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Cols.lgrey,
                child: widget
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Cols.lightgrey,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Text(
                pul,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 1,
              width: MediaQuery.sizeOf(context).width * 0.9,
              color: Cols.lightgrey,
            ),
          ],
        ),
      ],
    );
  }
}
