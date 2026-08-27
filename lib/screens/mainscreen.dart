import 'package:expensiv/consts/colors/color.dart';
import 'package:expensiv/gen/assets.gen.dart';
import 'package:expensiv/screens/history.dart';
import 'package:expensiv/screens/home.dart';
import 'package:expensiv/screens/homepage.dart';
import 'package:expensiv/screens/settings.dart';
import 'package:expensiv/screens/wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  List page = [Home(), Wallet(), Homepage(), History(), Settings()];

  int pageindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page[pageindex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageindex,
        onTap: (index) => setState(() => pageindex = index),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items:  [
         BottomNavigationBarItem(
      // ignore: deprecated_member_use
      icon: SvgPicture.asset(Assets.icons.qorahome, width: 18, height: 20, color: Cols.grey,),
      // ignore: deprecated_member_use
      activeIcon: SvgPicture.asset(Assets.icons.qorahome, width: 18, height: 20, color: Cols.black,), 
      label: '',
    ),
          BottomNavigationBarItem(
      icon: SvgPicture.asset(Assets.icons.hamyon, width: 18, height: 20),
      // ignore: deprecated_member_use
      activeIcon: SvgPicture.asset(Assets.icons.hamyon, width: 18, height: 20, color: Cols.black,), 
      label: '',
    ),
     BottomNavigationBarItem(
      icon: Icon(Icons.add,),
      // ignore: deprecated_member_use
      activeIcon: Icon(Icons.add,color: Cols.black,), 
      label: '',
    ),
          BottomNavigationBarItem(
      icon: SvgPicture.asset(Assets.icons.qogoz, width: 18, height: 20),
      // ignore: deprecated_member_use
      activeIcon: SvgPicture.asset(Assets.icons.qogoz, width: 18, height: 20, color: Cols.black,), 
      label: '',
    ),
            BottomNavigationBarItem(
      icon: SvgPicture.asset(Assets.icons.setting, width: 18, height: 20),
      // ignore: deprecated_member_use
      activeIcon: SvgPicture.asset(Assets.icons.setting,  width: 18, height: 20, color: Cols.black,), 
      label: '',
    ),
     
        ],
      ),
    );
  }
}
