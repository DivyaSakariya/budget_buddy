import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../controller/login_controller.dart';
import '../../utility/animation/fade_animation_controller.dart';
import '../../utility/colors.dart';
import 'intro_screen_2.dart';
import 'login_page.dart';

class IntroScreen3 extends StatelessWidget {
  const IntroScreen3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/intro-3.png'),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Column(
          children: [
            const Spacer(),
            FadeAnimation(
              2,
              0,
              Align(
                alignment: const Alignment(0.85, -0.6),
                child: GestureDetector(
                  onTap: () {
                    Provider.of<LogInController>(
                      context,
                      listen: false,
                    ).isintro();
                    Navigator.of(context).pushReplacement(
                      PageTransition(
                        type: PageTransitionType.fade,
                        duration: const Duration(milliseconds: 1000),
                        child: LogInPage(),
                      ),
                    );
                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
            ),
            FadeAnimation(
              1,
              0,
              Align(
                alignment: const Alignment(0, -0.6),
                child: SizedBox(
                  child: Image.asset(
                    'assets/images/intro-1.3.png',
                    width: size.width * 0.75,
                  ),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0, 0.05),
              child: Text(
                'Dream, Achieve, Repeat \n\n BudgetBuddy, \n Your Financial Success Partner.',
                style: TextStyle(
                  color: Colors.grey.shade900,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: size.height * 0.40,
                width: size.width * 0.98,
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: FadeAnimation(
                        2,
                        0,
                        const Text(
                          'Goal Setting and Summary',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 26,
                        left: 10,
                        right: 10,
                      ),
                      child: FadeAnimation(
                        3,
                        0,
                        AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText(
                              "BudgetBuddy: Empowering your financial journey. We help you turn dreams into reality and goals into achievements—shaping your success, every step of the way.",
                              textStyle: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                          totalRepeatCount: 1,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18.0,
                        vertical: 40,
                      ),
                      child: FadeAnimation(
                        8,
                        0,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    duration: const Duration(
                                      milliseconds: 1000,
                                    ),
                                    child: const IntroScreen2(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Back',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Provider.of<LogInController>(
                                  context,
                                  listen: false,
                                ).isintro();
                                Navigator.of(context).pushReplacement(
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    duration: const Duration(
                                      milliseconds: 1000,
                                    ),
                                    child: LogInPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Next',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
