import 'package:expensiv/gen/assets.gen.dart';
import 'package:expensiv/screens/onboarding.dart';
import 'package:flutter/material.dart';

class Splesh extends StatefulWidget {
  const Splesh({super.key});

  @override
  State<Splesh> createState() => _SpleshState();
}

class _SpleshState extends State<Splesh> {
    @override
  void initState() {
    super.initState();
    loaData();
  }

  Future<void> loaData() async {
    await Future.delayed(Duration(seconds: 5));

   
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => Onboarding())
      );
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         Center(
          child: SizedBox(
            height: 128,
            width: 128,
            child: Assets.images.logo.image(fit: BoxFit.contain),
          ),
         ) 
        ],
      ),
    );
  }
}