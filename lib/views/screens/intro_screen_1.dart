import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:budget_buddy/utility/colors.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../controller/login_controller.dart';
import '../../utility/animation/fade_animation_controller.dart';
import 'intro_screen_2.dart';
import 'login_page.dart';

class IntroScreen1 extends StatelessWidget {
  const IntroScreen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/intro.png'),
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
                    ).isIntro;
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
                    'assets/images/intro-1.1.png',
                    width: size.width * 0.75,
                  ),
                ),
              ),
            ),
            FadeAnimation(
              2,
              0,
              Align(
                alignment: const Alignment(0, 0.05),
                child: Text(
                  'BudgetBuddy \n\n Where Financial Freedom Meets Simplicity.',
                  style: TextStyle(
                    color: Colors.grey.shade900,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: size.height * 0.38,
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
                          'Welcome',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 30.0,
                        left: 10,
                        right: 10,
                      ),
                      child: FadeAnimation(
                        3,
                        0,
                        AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText(
                              'Experience financial freedom with ease. BudgetBuddy streamlines your path to economic empowerment, ensuring every step is simple, clear, and stress-free.',
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
                        vertical: 30,
                      ),
                      child: FadeAnimation(
                        11,
                        0,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
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
                                    child: const IntroScreen2(),
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
