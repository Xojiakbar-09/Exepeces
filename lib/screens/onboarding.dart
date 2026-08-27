import 'package:expensiv/consts/colors/color.dart';
import 'package:expensiv/gen/assets.gen.dart';
import 'package:expensiv/provider/onboardinprovider.dart';
import 'package:expensiv/screens/home.dart';
import 'package:expensiv/screens/homepage.dart';
import 'package:expensiv/screens/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => OnbordProvider(),
        child: Builder(
          builder: (context) {
            return Column(
              children: [
                Expanded(
                  flex: 7,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: context.read<OnbordProvider>().pagealmash,
                    itemCount: context.watch<OnbordProvider>().soz.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CircleAvatar(
                            backgroundColor: Cols.oqro,
                            radius: 24,
                            child: SvgPicture.asset(Assets.icons.onbord),
                          ),
                          SizedBox(height: 40),
                          Text(
                            context
                                .watch<OnbordProvider>()
                                .soz[index]['title']
                                .toString(),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 24),
                          Text(
                            context
                                .watch<OnbordProvider>()
                                .soz[index]['subtitle']
                                .toString(),
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: Cols.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 70),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 8,
                        children: List.generate(
                          context.watch<OnbordProvider>().soz.length,
                          (index) => CircleAvatar(
                            radius: 6,
                            backgroundColor:
                                context.watch<OnbordProvider>().pageindex ==
                                    index
                                ? Cols.black
                                : Cols.lightgrey,
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          if (context.read<OnbordProvider>().pageindex == context.read<OnbordProvider>().soz.length - 1) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Mainscreen(),
                              ),
                            );
                          } else {
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 590),
                              curve: Curves.decelerate,
                            );
                          }
                        },
                        child: Text(
                          context.watch<OnbordProvider>().pageindex ==
                                  context.watch<OnbordProvider>().soz.length - 1
                              ? 'GET STARED'
                              : 'NEXT',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
