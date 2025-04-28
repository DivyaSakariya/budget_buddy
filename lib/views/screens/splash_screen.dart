import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:budget_buddy/utility/colors.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../controller/login_controller.dart';
import '../../utility/animation/fade_animation_controller.dart';
import 'home_page.dart';
import 'intro_screen_1.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      setState(() {
        Navigator.of(context).pushReplacement(
          PageTransition(
            type: PageTransitionType.fade,
            child:
                Provider.of<LogInController>(context, listen: false).isIntro &&
                        Provider.of<LogInController>(
                          context,
                          listen: false,
                        ).isLogin
                    ? const HomePage()
                    : Provider.of<LogInController>(
                      context,
                      listen: false,
                    ).isIntro
                    ? LogInPage()
                    : Provider.of<LogInController>(
                      context,
                      listen: false,
                    ).isLogin
                    ? const HomePage()
                    : const IntroScreen1(),
          ),
        );
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Spacer(),
          Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Spacer(),
              Container(
                height: 96,
                width: 72,
                child: Image(image: AssetImage('assets/images/AppIcon.jpeg')),
              ),
              SizedBox(width: 20),
              Text(
                "BudgetBuddy",
                style: TextStyle(
                  fontSize: 28,
                  color: third,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
            ],
          ),
          Spacer(),
          FadeAnimation(
            3,
            0,
            AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText(
                  'Master your money, master your life',
                  textStyle: const TextStyle(fontSize: 18, color: third),
                  textAlign: TextAlign.center,
                ),
              ],
              totalRepeatCount: 1,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
