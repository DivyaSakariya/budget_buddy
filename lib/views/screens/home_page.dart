import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../controller/pageindex_controller.dart';
import '../../controller/user_controller.dart';
import '../../utility/colors.dart';
import 'add_transaction.dart';
import 'monthly_page.dart';
import 'recent_page.dart';
import 'saving_page.dart';
import 'profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Logger l = Logger();
    return Scaffold(
      body: Consumer<PageIndexController>(
        builder: (context, pro, child) {
          return IndexedStack(
            index: pro.currentPage,
            children: [
              RecentPage(),
              MonthlyPage(),
              SavingPage(),
              ProfilePage(),
            ],
          );
        },
      ),
      bottomNavigationBar: Consumer<PageIndexController>(
        builder: (context, pro, child) {
          return AnimatedBottomNavigationBar(
            activeColor: primary,
            splashColor: third,
            inactiveColor: Colors.black.withOpacity(0.5),
            icons: const [
              FluentIcons.calendar_agenda_24_regular,
              FluentIcons.calendar_32_regular,
              Icons.wallet,
              FluentIcons.person_24_regular,
            ],
            activeIndex: pro.currentPage,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.softEdge,
            leftCornerRadius: 10,
            iconSize: 25,
            rightCornerRadius: 10,
            onTap: (index) {
              pro.currentPage = index;
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: third),
        shape: CircleBorder(),
        backgroundColor: secondary,
        onPressed: () async {
          Navigator.of(context).push(
            PageTransition(
              type: PageTransitionType.scale,
              alignment: Alignment.bottomCenter, // or any other alignment
              child: AddTransactionPage(),
            ),
          );
          l.t(
            "${Provider.of<UserController>(context, listen: false).username} \n ${Provider.of<UserController>(context, listen: false).email} \n   ${Provider.of<UserController>(context, listen: false).total}",
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
