import 'package:expensiv/consts/colors/color.dart';
import 'package:expensiv/provider/homeprovider.dart';
import 'package:expensiv/utils/size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Customdrower extends StatefulWidget {
  const Customdrower({super.key});

  @override
  State<Customdrower> createState() => _CustomdrowerState();
}

class _CustomdrowerState extends State<Customdrower>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.9,
      height: context.height,
      color: Cols.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child: Column(
            children: [
              SizedBox(height: 30),
              Card(
                child: ListTile(
                  onTap: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: Text('Rostanham keshni tozalamoqchimis'),
                        actions: [
                          CupertinoActionSheetAction(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Yoq',
                              style: TextStyle(
                                color: Cols.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          CupertinoActionSheetAction(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              context.read<Homeprovider>().cleareDB();
                            },
                            child: Text(
                              'Ha',
                              style: TextStyle(
                                color: Cols.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  title: Text('Keshni tozalash'),
                  trailing: Icon(Icons.delete),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    _animationController.toggle();
                  },
                  title: Text("Themeni o'zgartirish"),
                  trailing: LottieBuilder.asset(
                    controller: _animationController,
                    'assets/lottie/day.json',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
