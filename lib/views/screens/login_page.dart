import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_btn/loading_btn.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../controller/login_controller.dart';
import '../../controller/transaction_controller.dart';
import '../../controller/user_controller.dart';
import '../../helper/db_helper.dart';
import '../../utility/animation/fade_animation_controller.dart';
import '../../utility/animation/loop_controller.dart';
import '../../utility/colors.dart';
import 'home_page.dart';
import 'signup_page.dart';

class LogInPage extends StatelessWidget {
  LogInPage({super.key});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: purple100,
      body: Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.09),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                      alignment: Alignment(0, -0.85),
                      child: Hero(
                        tag: 'logo',
                        child: Container(
                          height: size.height * 0.10,
                          padding: EdgeInsets.only(left: 20),
                          child: FadeAnimation(
                            1.2,
                            10,
                            Image.asset(
                              "assets/images/AppIcon.jpeg",
                              height: size.height * 0.07,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Align(
                      alignment: Alignment(-0.8, -0.8),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TyperAnimatedText(
                            'BudgetBuddy',
                            textStyle: const TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.bold,
                            ),
                            speed: const Duration(milliseconds: 200),
                          ),
                        ],
                        totalRepeatCount: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.04),
                Container(
                  height: size.height * 0.6,
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: const BorderRadius.all(Radius.circular(35)),
                  ),
                  padding: EdgeInsets.all(28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeAnimation(
                        1.0,
                        -30,
                        Text(
                          'LOG IN',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            color: third,
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.060),
                      FadeAnimation(
                        1.2,
                        30,
                        SizedBox(
                          width: 200,
                          child: TextFormField(
                            controller: userController,
                            autocorrect: true,
                            style: TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: 'Username',
                              hintStyle: TextStyle(color: grey300),
                              helperText: 'Please enter your Username',
                              helperStyle: TextStyle(
                                fontSize: 12,
                                color: purple100,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your First name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      FadeAnimation(
                        1.4,
                        30,
                        SizedBox(
                          width: 295,
                          child: Consumer<UserController>(
                            builder: (context, pro, child) {
                              {
                                return TextFormField(
                                  controller: passwordController,
                                  autocorrect: true,
                                  obscureText: !pro.isPasswordVisible,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    hintStyle: TextStyle(color: grey300),
                                    helperText: 'Please enter your Password.',
                                    helperStyle: TextStyle(
                                      fontSize: 12,
                                      color: purple100,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        pro.isPasswordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: grey300,
                                      ),
                                      onPressed: () {
                                        pro.togglePasswordVisibility();
                                      },
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your Password';
                                    }
                                    return null;
                                  },
                                );
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      FadeAnimation(
                        1.6,
                        30,
                        LoadingBtn(
                          height: 45,
                          borderRadius: 24,
                          roundLoadingShape: false,
                          color: secondary,
                          width: MediaQuery.of(context).size.width * 0.25,
                          minWidth: MediaQuery.of(context).size.width * 0.20,
                          loader: const CircularProgressIndicator(
                            color: Colors.white,
                          ),
                          child: const Text(
                            'LOG IN',
                            style: TextStyle(
                              color: third,
                              fontSize: 18,
                              letterSpacing: 2,
                            ),
                          ),
                          onTap: (startLoading, stopLoading, btnState) async {
                            if (btnState == ButtonState.idle) {
                              startLoading();
                              await Future.delayed(const Duration(seconds: 2));
                              if (formKey.currentState!.validate()) {
                                bool isAuthenticated = await DbHelper.dbHelper
                                    .loginUser(
                                      username: userController.text,
                                      password: passwordController.text,
                                    );

                                if (isAuthenticated) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Valid username or password.',
                                      ),
                                    ),
                                  );
                                  await DbHelper.dbHelper.getUserByUsername(
                                    username: userController.text,
                                  );
                                  await Provider.of<UserController>(
                                    context,
                                    listen: false,
                                  ).init();
                                  await DbHelper.dbHelper.initDB();
                                  await Provider.of<TransactionController>(
                                    context,
                                    listen: false,
                                  ).init();
                                  await Provider.of<LogInController>(
                                    context,
                                    listen: false,
                                  ).islogin();
                                  Navigator.of(context).pushReplacement(
                                    PageTransition(
                                      type: PageTransitionType.scale,
                                      alignment: Alignment.bottomCenter,
                                      // or any other alignment
                                      child: HomePage(),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Invalid username or password.',
                                      ),
                                    ),
                                  );
                                  stopLoading();
                                }
                              }

                              stopLoading();
                            }
                          },
                        ),
                      ),
                      SizedBox(height: size.height * 0.072),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "New to BudgetBuddy ? ",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: grey400,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              Navigator.of(context).push(
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: SignUpPage(),
                                ),
                              );
                            },
                            child: Text(
                              "Register now",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                color: purple300,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
