import 'package:budget_buddy/views/screens/home_page.dart';
import 'package:budget_buddy/views/screens/intro_screen_1.dart';
import 'package:budget_buddy/views/screens/login_page.dart';
import 'package:budget_buddy/views/screens/signup_page.dart';
import 'package:budget_buddy/views/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controller/api_controller.dart';
import 'controller/category_controller.dart';
import 'controller/heatmap_controller.dart';
import 'controller/login_controller.dart';
import 'controller/pageindex_controller.dart';
import 'controller/savings_controller.dart';
import 'controller/transaction_controller.dart';
import 'controller/user_controller.dart';
import 'helper/db_helper.dart';
import 'utility/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.dbHelper.initDB();
  SharedPreferences Pref = await SharedPreferences.getInstance();
  bool isLogin = Pref.getBool("isLogin") ?? false;
  bool isIntro = Pref.getBool("isIntro") ?? false;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserController()),
        ChangeNotifierProvider(create: (context) => CategoryController()),
        ChangeNotifierProvider(create: (context) => HeatMapController()),
        ChangeNotifierProvider(create: (context) => ApiController()),
        ChangeNotifierProvider(create: (context) => SavingsController()),
        ChangeNotifierProvider(create: (context) => PageIndexController()),
        ChangeNotifierProvider(create: (context) => TransactionController()),
        ChangeNotifierProvider(
          create:
              (context) => LogInController(isLogin: isLogin, isIntro: isIntro),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        primaryColor: primary,
        useMaterial3: true,
      ),
      title: 'BudgetBuddy',
      routes: {'/': (context) => SplashScreen()},
    );
  }
}
