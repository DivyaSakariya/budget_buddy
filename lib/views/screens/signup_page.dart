import 'dart:io';
import 'dart:math';

import 'package:budget_buddy/utility/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_btn/loading_btn.dart';
import 'package:logger/logger.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../controller/user_controller.dart';
import '../../helper/db_helper.dart';
import '../../modal/user_modal.dart';
import '../../utility/animation/fade_animation_controller.dart';
import '../../utility/animation/loop_controller.dart';
import '../../utility/avtar_list.dart';
import 'login_page.dart';

class SignUpPage extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController balanceController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  UserModal user = UserModal.init();
  Logger l = Logger();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: purple100,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.09),
                Row(
                  children: [
                    Hero(
                      tag: 'logo',
                      child: Container(
                        height: size.height * 0.10,
                        child: Positioned(
                          left: 13,
                          child: FadeAnimation(
                            1.6,
                            -30,
                            Image.asset(
                              "assets/images/AppIcon.jpeg",
                              height: size.height * 0.07,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    FadeAnimation(
                      1.8,
                      -30,
                      Text(
                        'CREATE ACCOUNT',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.04),
                Container(
                  height: size.height * 0.7,
                  width: size.width * 1,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: const BorderRadius.all(Radius.circular(35)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeAnimation(
                        2.0,
                        30,
                        TextFormField(
                          controller: userController,
                          autocorrect: true,
                          textInputAction: TextInputAction.next,
                          style: TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: 'Username',
                            hintStyle: TextStyle(color: grey300),
                            helperText: 'Please enter your username',
                            helperStyle: TextStyle(
                              fontSize: 12,
                              color: purple100,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your first name';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            user.username = val;
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      FadeAnimation(
                        2.4,
                        30,
                        TextFormField(
                          controller: emailController,
                          autocorrect: true,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(color: grey300),
                            helperText: 'Please enter your email',
                            helperStyle: TextStyle(
                              fontSize: 12,
                              color: purple100,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your Password';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            user.email = val;
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      FadeAnimation(
                        2.6,
                        30,
                        TextFormField(
                          controller: balanceController,
                          autocorrect: true,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          style: TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: 'Total Balance',
                            hintStyle: TextStyle(color: grey300),
                            helperText:
                                'Please enter your estimated total balance.',
                            helperStyle: TextStyle(
                              fontSize: 12,
                              color: purple100,
                            ),
                          ),
                          onChanged: (val) {
                            user.balance = double.parse(val);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your total balance.';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      FadeAnimation(
                        2.8,
                        30,
                        Consumer<UserController>(
                          builder: (context, pro, child) {
                            {
                              return TextFormField(
                                controller: passwordController,
                                autocorrect: true,
                                obscureText: !pro.isPasswordVisible,
                                textInputAction: TextInputAction.next,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: TextStyle(color: grey300),
                                  helperText: 'Please enter your password.',
                                  helperStyle: TextStyle(
                                    fontSize: 12,
                                    color: purple100,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      pro.isPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: purple100,
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
                      const SizedBox(height: 15),
                      FadeAnimation(
                        3.0,
                        30,
                        Consumer<UserController>(
                          builder: (context, pro, child) {
                            {
                              return TextFormField(
                                controller: confirmPasswordController,
                                autocorrect: true,
                                obscureText: !pro.isConfirmPasswordVisible,
                                textInputAction: TextInputAction.done,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'Confirm Password',
                                  hintStyle: TextStyle(color: grey300),
                                  helperText:
                                      'Please enter your confirm password.',
                                  helperStyle: TextStyle(
                                    fontSize: 12,
                                    color: purple100,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      pro.isConfirmPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: purple100,
                                    ),
                                    onPressed: () {
                                      pro.toggleConfirmPasswordVisibility();
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your Password';
                                  }
                                  if (value != passwordController.text) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  l.w('${val}');
                                  if (val == passwordController.text) {
                                    user.password = val;
                                  }
                                },
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      FadeAnimation(
                        3.2,
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
                            'SIGN UP',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              letterSpacing: 2,
                            ),
                          ),
                          onTap: (startLoading, stopLoading, btnState) async {
                            if (btnState == ButtonState.idle) {
                              startLoading();
                              await Future.delayed(const Duration(seconds: 2));
                              if (formKey.currentState!.validate()) {
                                user.id = 0;
                                String image =
                                    avtarList[Random().nextInt(
                                      avtarList.length,
                                    )];
                                List<int> assetData = await rootBundle
                                    .load(image)
                                    .then(
                                      (ByteData data) =>
                                          data.buffer.asUint8List(),
                                    );
                                Uint8List bytes = Uint8List.fromList(assetData);
                                user.image = bytes;
                                print('${user.image} ');
                                await DbHelper.dbHelper.registerUser(
                                  user: user,
                                );
                                l.d(
                                  "${user.id} \n ${user.username} \n ${user.email} \n ${user.password} \n ${user.balance}",
                                );
                                userController.clear();
                                emailController.clear();
                                passwordController.clear();
                                confirmPasswordController.clear();
                                balanceController.clear();
                                Navigator.of(context).pushReplacement(
                                  PageTransition(
                                    type: PageTransitionType.scale,
                                    alignment:
                                        Alignment
                                            .bottomCenter, // or any other alignment
                                    child: LogInPage(),
                                  ),
                                );
                              }
                              stopLoading();
                            }
                          },
                        ),
                      ),
                      SizedBox(height: size.height * 0.050),
                      ReverseLoopAnimationWidget(
                        beginValue: -02,
                        endValue: 0,
                        duration: 1000,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Have already an account ? ",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                color: grey400,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: LogInPage(),
                                  ),
                                );
                              },
                              child: Text(
                                "Login here",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  color: purple300,
                                ),
                              ),
                            ),
                          ],
                        ),
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
