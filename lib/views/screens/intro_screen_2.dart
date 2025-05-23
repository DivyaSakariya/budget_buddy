import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../controller/login_controller.dart';
import '../../utility/animation/fade_animation_controller.dart';
import '../../utility/colors.dart';
import 'intro_screen_1.dart';
import 'intro_screen_3.dart';
import 'login_page.dart';

class IntroScreen2 extends StatelessWidget {
  const IntroScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/intro-1.png'),
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
                    'assets/images/intro-1.2.png',
                    width: size.width * 0.75,
                  ),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0, 0.05),
              child: Text(
                'Every Rupees Counts,\n Every Detail Matters. \n\n Trust BudgetBuddy.',
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
                          'Transaction Tracking',
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
                              "Precision you can trust. At BudgetBuddy, our commitment to accuracy guarantees that your financial journey is guided by clarity, confidence, and lasting success.",
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
                        12,
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
                                    child: const IntroScreen1(),
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
                                    child: const IntroScreen3(),
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
