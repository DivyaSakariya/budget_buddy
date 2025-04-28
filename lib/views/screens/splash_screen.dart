import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:budget_buddy/utility/colors.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

// import 'package:provider/provider.dart';
//
// import '../../controller/login_controller.dart';
// import '../../utility/animation/fade_animation_controller.dart';
// import 'home_page.dart';
// import 'intro_screen_1.dart';
// import 'login_page.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(const Duration(seconds: 3), () {
//       // Navigator.of(context).pushReplacementNamed('/');
//       setState(() {
//         Navigator.of(context).pushReplacement(
//           PageTransition(
//             type: PageTransitionType.fade,
//             child:
//                 Provider.of<LogInController>(context, listen: false).isIntro &&
//                         Provider.of<LogInController>(
//                           context,
//                           listen: false,
//                         ).isLogin
//                     ? const HomePage()
//                     : Provider.of<LogInController>(
//                       context,
//                       listen: false,
//                     ).isIntro
//                     ? LogInPage()
//                     : Provider.of<LogInController>(
//                       context,
//                       listen: false,
//                     ).isLogin
//                     ? const HomePage()
//                     : const IntroScreen1(),
//           ),
//         );
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Spacer(),
//           Spacer(),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Spacer(),
//               Container(
//                 height: 96,
//                 width: 72,
//                 child: Image(image: AssetImage('assets/images/AppIcon.jpeg')),
//               ),
//               SizedBox(width: 20),
//               Text(
//                 "BudgetBuddy",
//                 style: TextStyle(
//                   fontSize: 28,
//                   color: third,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Spacer(),
//             ],
//           ),
//           Spacer(),
//           FadeAnimation(
//             3,
//             0,
//             AnimatedTextKit(
//               animatedTexts: [
//                 TyperAnimatedText(
//                   'Master your money, master your life',
//                   textStyle: const TextStyle(fontSize: 18, color: third),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//               totalRepeatCount: 1,
//             ),
//           ),
//           Spacer(),
//         ],
//       ),
//     );
//   }
// }

import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../controller/login_controller.dart';
import '../../utility/animation/fade_animation_controller.dart';
import '../../utility/colors.dart';
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

    // Timer(const Duration(milliseconds: 400), () {
    //   setState(() {
    //     a = true;
    //   });
    // });
    // Timer(const Duration(milliseconds: 400), () {
    //   setState(() {
    //     b = true;
    //   });
    // });
    // Timer(const Duration(milliseconds: 1300), () {
    //   setState(() {
    //     c = true;
    //   });
    // });
    // Timer(const Duration(milliseconds: 1700), () {
    //   setState(() {
    //     e = true;
    //   });
    // });
    // Timer(const Duration(milliseconds: 3400), () {
    //   setState(() {
    //     d = true;
    //   });
    // });
    // Timer(const Duration(milliseconds: 3850), () {
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

  bool a = false;
  bool b = false;
  bool c = false;
  bool d = false;
  bool e = false;

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
      // body: Center(
      //   child: Column(
      //     children: [
      //       AnimatedContainer(
      //         duration: Duration(milliseconds: d ? 900 : 2500),
      //         curve: d ? Curves.fastLinearToSlowEaseIn : Curves.elasticOut,
      //         height: d
      //             ? 0
      //             : a
      //             ? h / 2
      //             : 20,
      //         width: 20,
      //         // color: Colors.deepPurpleAccent,
      //       ),
      //       AnimatedContainer(
      //         duration: Duration(
      //             seconds: d
      //                 ? 1
      //                 : c
      //                 ? 2
      //                 : 0),
      //         curve: Curves.fastLinearToSlowEaseIn,
      //         height: d
      //             ? h
      //             : c
      //             ? 80
      //             : 20,
      //         width: d
      //             ? w
      //             : c
      //             ? 200
      //             : 20,
      //         decoration: BoxDecoration(
      //             color: b ? Colors.white : Colors.transparent,
      //             // shape: c? BoxShape.rectangle : BoxShape.circle,
      //             borderRadius:
      //             d ? const BorderRadius.only() : BorderRadius.circular(30)),
      //         child: Center(
      //           child: e
      //               ? AnimatedTextKit(
      //             totalRepeatCount: 1,
      //             animatedTexts: [
      //               FadeAnimatedText(
      //                 'SpandView',
      //                 duration: const Duration(milliseconds: 1700),
      //                 textStyle: const TextStyle(
      //                   fontSize: 30,
      //                   color: primary,
      //                   fontWeight: FontWeight.w700,
      //                 ),
      //               ),
      //             ],
      //           )
      //               : const SizedBox(),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
