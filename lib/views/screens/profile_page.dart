import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:budget_buddy/views/screens/recent_page.dart';
import 'package:budget_buddy/views/screens/saving_page.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controller/login_controller.dart';
import '../../controller/transaction_controller.dart';
import '../../controller/savings_controller.dart';
import '../../controller/user_controller.dart';
import '../../helper/db_helper.dart';
import '../../modal/chart_modal.dart';
import '../component/setting_tile.dart';
import 'add_transaction.dart';
import 'history_page.dart';
import 'login_page.dart';
import 'monthly_page.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double percent = 0.45;
    TransactionController transactionController =
        Provider.of<TransactionController>(context, listen: false);

    SavingsController sav = Provider.of<SavingsController>(
      context,
      listen: false,
    );

    double expense = transactionController.transactionList
        .where((expense) => expense.type == "EXPENSE")
        .fold(0.0, (sum, expense) => sum + (expense.amount ?? 0.0));

    double income = transactionController.transactionList
        .where((income) => income.type == "INCOME")
        .fold(0.0, (sum, income) => sum + (income.amount ?? 0.0));

    double savings = sav.transactionListGoal.fold(
      0,
      (previousValue, element) => previousValue + element.amount!,
    );

    final pw.Document pdf = pw.Document();

    List<ChartModal> chartModal = [
      ChartModal('Income : ${income.toStringAsFixed(2)}', income, Colors.green),
      ChartModal(
        'Savings : ${savings.toStringAsFixed(2)}',
        savings,
        Colors.blue,
      ),
      ChartModal(
        'Expense : ${expense.toStringAsFixed(2)}',
        expense,
        Colors.red,
      ),
    ];

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: (size.width - 40) * 0.4,
                    child: Stack(
                      children: [
                        TweenAnimationBuilder(
                          tween: Tween<double>(begin: 0.0, end: percent),
                          duration: const Duration(seconds: 2),
                          builder: (BuildContext context, double value, _) {
                            return RotatedBox(
                              quarterTurns: 1,
                              child: CircularPercentIndicator(
                                circularStrokeCap: CircularStrokeCap.round,
                                backgroundColor: Colors.grey.withOpacity(0.05),
                                radius: 52,
                                lineWidth: 6.0,
                                percent: value,
                                startAngle: 45,
                                progressColor: Colors.black,
                              ),
                            );
                          },
                        ),
                        Positioned(
                          top: 10,
                          left: 9,
                          child: Container(
                            width: 85,
                            height: 85,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: MemoryImage(
                                  Provider.of<UserController>(
                                        context,
                                        listen: false,
                                      ).image ??
                                      Uint8List(0),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: (size.width - 40) * 0.6,
                    child: Consumer<UserController>(
                      builder: (context, pro, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${pro.username}",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Total Balance : ${(pro.total ?? 25000) - expense + income}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.4),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Container(
                padding: const EdgeInsets.all(10),
                height: size.height * 0.15,
                width: size.width * 0.90,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  gradient: const LinearGradient(
                    begin: Alignment(0.5, 1.0),
                    end: Alignment(1.0, 1),
                    colors: [Colors.black, Colors.black87],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: SfCircularChart(
                          tooltipBehavior: TooltipBehavior(enable: false),
                          legend: const Legend(
                            isVisible: true,
                            textStyle: TextStyle(color: Colors.white),
                            overflowMode: LegendItemOverflowMode.scroll,
                            alignment: ChartAlignment.center,
                            height: '150%',
                            position: LegendPosition.right,
                          ),
                          series: <RadialBarSeries<ChartModal, String>>[
                            RadialBarSeries<ChartModal, String>(
                              dataSource: chartModal,
                              xValueMapper:
                                  (ChartModal data, _) => data.category,
                              yValueMapper: (ChartModal data, _) => data.amount,
                              pointColorMapper:
                                  (ChartModal data, _) => data.color,
                              enableTooltip: true,
                              radius: '110%',
                              innerRadius: '30%',
                              cornerStyle: CornerStyle.bothCurve,
                              maximumValue:
                                  (Provider.of<UserController>(
                                        context,
                                        listen: false,
                                      ).total ??
                                      0) -
                                  expense +
                                  income,
                              gap: '20%',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(20),
                  const Text(
                    'Transactions',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const Gap(5),
                  SettingTile(
                    title: 'Recent Transaction ',
                    icon: FluentIcons.app_recent_24_regular,
                    onTilePressed: () {
                      Navigator.of(context).push(
                        PageTransition(
                          type: PageTransitionType.size,
                          duration: const Duration(seconds: 1),
                          alignment:
                              Alignment.bottomCenter, // or any other alignment
                          child: const RecentPage(),
                        ),
                      );
                    },
                  ),
                  const Gap(5),
                  SettingTile(
                    title: 'Transaction History',
                    icon: FluentIcons.apps_list_detail_24_regular,
                    onTilePressed: () {
                      Navigator.of(context).push(
                        PageTransition(
                          type: PageTransitionType.size,
                          duration: const Duration(seconds: 1),
                          alignment:
                              Alignment.bottomCenter, // or any other alignment
                          child: HistoryPage(),
                        ),
                      );
                    },
                  ),
                  const Gap(5),
                  SettingTile(
                    title: 'Monthly Report',
                    icon: FluentIcons.calendar_month_24_regular,
                    onTilePressed: () {
                      Navigator.of(context).push(
                        PageTransition(
                          type: PageTransitionType.size,
                          duration: const Duration(seconds: 1),
                          alignment:
                              Alignment.bottomCenter, // or any other alignment
                          child: MonthlyPage(),
                        ),
                      );
                    },
                  ),
                  const Gap(5),
                  SettingTile(
                    title: 'Add Transaction ',
                    icon: FluentIcons.add_square_multiple_24_regular,
                    onTilePressed: () {
                      Navigator.of(context).push(
                        PageTransition(
                          type: PageTransitionType.size,
                          duration: const Duration(seconds: 1),
                          alignment:
                              Alignment.bottomCenter, // or any other alignment
                          child: AddTransactionPage(),
                        ),
                      );
                    },
                  ),
                  const Gap(20),
                  const Text(
                    'Savings',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const Gap(5),
                  SettingTile(
                    title: 'Savings History',
                    icon: FluentIcons.savings_24_regular,
                    onTilePressed: () {
                      Navigator.of(context).push(
                        PageTransition(
                          type: PageTransitionType.size,
                          duration: const Duration(seconds: 1),
                          alignment:
                              Alignment.bottomCenter, // or any other alignment
                          child: SavingPage(),
                        ),
                      );
                    },
                  ),
                  const Gap(20),
                  const Text(
                    'Backups',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const Gap(5),
                  SettingTile(
                    title: 'Export Data',
                    icon: FluentIcons.document_pdf_24_regular,
                    onTilePressed: () async {
                      UserController user = Provider.of<UserController>(
                        context,
                        listen: false,
                      );
                      String date = DateFormat(
                        'dd/MM/yyyy',
                      ).format(DateTime.now());

                      String time =
                          '${TimeOfDay.now().hour % 12}:${TimeOfDay.now().minute}';
                      final logoImage = pw.MemoryImage(
                        (await rootBundle.load(
                          "assets/images/MainIcon.png",
                        )).buffer.asUint8List(),
                      );
                      final image = pw.MemoryImage(
                        (user.image ?? Uint8List(0)),
                      );

                      pdf.addPage(
                        pw.MultiPage(
                          margin: const pw.EdgeInsets.all(10),
                          pageFormat: PdfPageFormat.a4,
                          build: (pw.Context context) {
                            return <pw.Widget>[
                              pw.Column(
                                children: [
                                  pw.Row(
                                    children: [
                                      pw.Column(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.Container(
                                            color: PdfColors.black,
                                            width: 100,
                                            height: 50,
                                            child: pw.Column(),
                                          ),
                                          pw.Text(
                                            "BudgetBuddy",
                                            style: pw.TextStyle(
                                              color: PdfColors.black,
                                              fontSize: 19,
                                              fontWeight: pw.FontWeight.bold,
                                            ),
                                          ),
                                          pw.Container(
                                            color: PdfColors.black,
                                            width: 100,
                                            height: 713,
                                            child: pw.Column(),
                                          ),
                                        ],
                                      ),
                                      pw.Container(
                                        child: pw.Column(
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Row(
                                              mainAxisAlignment:
                                                  pw
                                                      .MainAxisAlignment
                                                      .spaceEvenly,
                                              children: [
                                                pw.SizedBox(width: 25),
                                                pw.Row(
                                                  children: [
                                                    pw.Text(
                                                      'Time : ',
                                                      style: pw.TextStyle(
                                                        color: PdfColors.black,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            pw.FontWeight.bold,
                                                      ),
                                                    ),
                                                    pw.Text(
                                                      time,
                                                      style: pw.TextStyle(
                                                        color: PdfColors.grey,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            pw.FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                pw.SizedBox(width: 25),
                                                pw.Text(
                                                  'BudgetBuddy',
                                                  style: pw.TextStyle(
                                                    color: PdfColors.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        pw.FontWeight.bold,
                                                  ),
                                                ),
                                                pw.SizedBox(width: 25),
                                                pw.Row(
                                                  children: [
                                                    pw.Text(
                                                      'Date : ',
                                                      style: pw.TextStyle(
                                                        color: PdfColors.black,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            pw.FontWeight.bold,
                                                      ),
                                                    ),
                                                    pw.Text(
                                                      date,
                                                      style: pw.TextStyle(
                                                        color: PdfColors.grey,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            pw.FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            pw.SizedBox(height: 40),
                                            pw.Row(
                                              children: [
                                                pw.SizedBox(width: 20),
                                                pw.Column(
                                                  crossAxisAlignment:
                                                      pw
                                                          .CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    pw.Text(
                                                      'Expense',
                                                      style: pw.TextStyle(
                                                        color: PdfColors.black,
                                                        fontSize: 36,
                                                        fontWeight:
                                                            pw.FontWeight.bold,
                                                        letterSpacing: 2,
                                                      ),
                                                    ),
                                                    pw.Text(
                                                      'Report',
                                                      style: pw.TextStyle(
                                                        color: PdfColors.black,
                                                        fontSize: 60,
                                                        fontWeight:
                                                            pw
                                                                .FontWeight
                                                                .normal,
                                                        letterSpacing: 2,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                pw.SizedBox(width: 140),
                                                pw.Image(
                                                  logoImage,
                                                  height: 100,
                                                ),
                                              ],
                                            ),

                                            pw.SizedBox(height: 30),
                                            pw.Row(
                                              children: [
                                                pw.SizedBox(width: 28),
                                                pw.Container(
                                                  child: pw.ClipOval(
                                                    child: pw.Image(
                                                      image,
                                                      height: 300,
                                                      width: 160,
                                                    ),
                                                  ),
                                                ),
                                                pw.SizedBox(width: 20),
                                                pw.Column(
                                                  crossAxisAlignment:
                                                      pw
                                                          .CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    pw.Text(
                                                      user.username ?? '',
                                                      style: pw.TextStyle(
                                                        color: PdfColors.black,
                                                        fontSize: 36,
                                                        fontWeight:
                                                            pw.FontWeight.bold,
                                                      ),
                                                    ),
                                                    pw.SizedBox(height: 15),
                                                    pw.Text(
                                                      'diyasakariya1227@gmail.com',
                                                      style: pw.TextStyle(
                                                        color: PdfColors.grey,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            pw.FontWeight.bold,
                                                      ),
                                                    ),
                                                    pw.SizedBox(height: 10),
                                                    pw.Row(
                                                      children: [
                                                        pw.Text(
                                                          'Current Balance : ',
                                                          style: pw.TextStyle(
                                                            color:
                                                                PdfColors.black,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                pw
                                                                    .FontWeight
                                                                    .bold,
                                                          ),
                                                        ),
                                                        pw.Text(
                                                          '${(user.total ?? 25000) - expense + income}',
                                                          style: pw.TextStyle(
                                                            color:
                                                                PdfColors.grey,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                pw
                                                                    .FontWeight
                                                                    .bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            pw.SizedBox(height: 68),
                                            pw.Row(
                                              children: [
                                                pw.SizedBox(width: 20),
                                                pw.Column(
                                                  children: [
                                                    pw.Container(
                                                      height: 2,
                                                      width: 440,
                                                      color: PdfColors.black,
                                                    ),
                                                    pw.Row(
                                                      mainAxisAlignment:
                                                          pw
                                                              .MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        pw.Container(
                                                          height: 120,
                                                          width: 2,
                                                          color:
                                                              PdfColors.black,
                                                        ),
                                                        pw.Column(
                                                          children: [
                                                            pw.Text(
                                                              'NO',
                                                              style: pw.TextStyle(
                                                                color:
                                                                    PdfColors
                                                                        .black,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    pw
                                                                        .FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            pw.SizedBox(
                                                              height: 05,
                                                            ),
                                                            pw.Container(
                                                              height: 1,
                                                              width: 110,
                                                              color:
                                                                  PdfColors
                                                                      .black,
                                                            ),
                                                            pw.SizedBox(
                                                              height: 05,
                                                            ),
                                                            pw.Text(
                                                              '1',
                                                              style: pw.TextStyle(
                                                                color:
                                                                    PdfColors
                                                                        .black,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    pw
                                                                        .FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            pw.SizedBox(
                                                              height: 05,
                                                            ),
                                                            pw.Container(
                                                              height: 1,
                                                              width: 110,
                                                              color:
                                                                  PdfColors
                                                                      .black,
                                                            ),
                                                            pw.SizedBox(
                                                              height: 05,
                                                            ),
                                                            pw.Text(
                                                              '2',
                                                              style: pw.TextStyle(
                                                                color:
                                                                    PdfColors
                                                                        .black,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    pw
                                                                        .FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            pw.Container(
                                                              height: 1,
                                                              width: 110,
                                                              color:
                                                                  PdfColors
                                                                      .black,
                                                            ),
                                                            pw.SizedBox(
                                                              height: 05,
                                                            ),
                                                            pw.Text(
                                                              '3',
                                                              style: pw.TextStyle(
                                                                color:
                                                                    PdfColors
                                                                        .black,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    pw
                                                                        .FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        pw.Container(
                                                          height: 120,
                                                          width: 2,
                                                          color:
                                                              PdfColors.black,
                                                        ),
                                                        pw.SizedBox(width: 50),
                                                        pw.Container(
                                                          height: 120,
                                                          width: 2,
                                                          color:
                                                              PdfColors.black,
                                                        ),
                                                        pw.Column(
                                                          children: [
                                                            pw.Text(
                                                              'Type',
                                                              style: pw.TextStyle(
                                                                color:
                                                                    PdfColors
                                                                        .black,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    pw
                                                                        .FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            pw.SizedBox(
                                                              height: 05,
                                                            ),
                                                            pw.Container(
                                                              height: 1,
                                                              width: 110,
                                                              color:
                                                                  PdfColors
                                                                      .black,
                                                            ),
                                                            pw.SizedBox(
                                                              height: 05,
                                                            ),
                                                            pw.Text(
                                                              'Income',
                                                              style: pw.TextStyle(
                                                                color:
                                                                    PdfColors
                                                                        .green,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    pw
                                                                        .FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            pw.SizedBox(
                                                              height: 05,
                                                            ),
                                                            pw.Container(
                                                              height: 1,
                                                              width: 110,
                                                              color:
                                                                  PdfColors
                                                                      .black,
                                                            ),
                                                            pw.SizedBox(
                                                              height: 05,
                                                            ),
                                                            pw.Text(
                                                              'Expense',
                                                              style: pw.TextStyle(
                                                                color:
                                                                    PdfColors
                                                                        .red,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    pw
                                                                        .FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            pw.Container(
                                                              height: 1,
                                                              width: 110,
                                                              color:
                                                                  PdfColors
                                                                      .black,
                                                            ),
                                                            pw.SizedBox(
                                                              height: 05,
                                                            ),
                                                            pw.Text(
                                                              'Savings',
                                                              style: pw.TextStyle(
                                                                color:
                                                                    PdfColors
                                                                        .blue,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    pw
                                                                        .FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        pw.Container(
                                                          height: 120,
                                                          width: 2,
                                                          color:
                                                              PdfColors.black,
                                                        ),
                                                        pw.SizedBox(width: 50),
                                                        pw.Container(
                                                          height: 120,
                                                          width: 2,
                                                          color:
                                                              PdfColors.black,
                                                        ),
                                                        pw.Column(
                                                          children: [
                                                            pw.Text(
                                                              'Amount',
                                                              style: pw.TextStyle(
                                                                color:
                                                                    PdfColors
                                                                        .black,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    pw
                                                                        .FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            pw.SizedBox(
                                                              height: 05,
                                                            ),
                                                            pw.Container(
                                                              height: 1,
                                                              width: 110,
                                                              color:
                                                                  PdfColors
                                                                      .black,
                                                            ),
                                                            pw.SizedBox(
                                                              height: 05,
                                                            ),
                                                            pw.Text(
                                                              '$income',
                                                              style: pw.TextStyle(
                                                                color:
                                                                    PdfColors
                                                                        .green,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    pw
                                                                        .FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            pw.SizedBox(
                                                              height: 05,
                                                            ),
                                                            pw.Container(
                                                              height: 1,
                                                              width: 110,
                                                              color:
                                                                  PdfColors
                                                                      .black,
                                                            ),
                                                            pw.SizedBox(
                                                              height: 05,
                                                            ),
                                                            pw.Text(
                                                              '$expense',
                                                              style: pw.TextStyle(
                                                                color:
                                                                    PdfColors
                                                                        .red,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    pw
                                                                        .FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            pw.Container(
                                                              height: 1,
                                                              width: 110,
                                                              color:
                                                                  PdfColors
                                                                      .black,
                                                            ),
                                                            pw.SizedBox(
                                                              height: 05,
                                                            ),
                                                            pw.Text(
                                                              '$savings',
                                                              style: pw.TextStyle(
                                                                color:
                                                                    PdfColors
                                                                        .blue,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    pw
                                                                        .FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        pw.Container(
                                                          height: 120,
                                                          width: 2,
                                                          color:
                                                              PdfColors.black,
                                                        ),
                                                      ],
                                                    ),
                                                    pw.Container(
                                                      height: 2,
                                                      width: 440,
                                                      color: PdfColors.black,
                                                    ),

                                                    pw.SizedBox(height: 10),
                                                    pw.Row(
                                                      children: [
                                                        pw.SizedBox(width: 120),

                                                        pw.Text(
                                                          'Total Amount :',
                                                          style:
                                                              const pw.TextStyle(
                                                                color:
                                                                    PdfColors
                                                                        .black,
                                                                fontSize: 18,
                                                                letterSpacing:
                                                                    2,
                                                              ),
                                                        ),
                                                        pw.SizedBox(width: 35),
                                                        pw.Text(
                                                          '${income - expense + savings}',
                                                          style: pw.TextStyle(
                                                            color:
                                                                PdfColors.black,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                pw
                                                                    .FontWeight
                                                                    .bold,
                                                            letterSpacing: 1,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    pw.SizedBox(height: 10),
                                                    pw.Container(
                                                      height: 2,
                                                      width: 440,
                                                      color: PdfColors.black,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            pw.SizedBox(height: 55),
                                            pw.Row(
                                              children: [
                                                pw.SizedBox(width: 18),
                                                pw.Container(
                                                  child: pw.ConstrainedBox(
                                                    constraints:
                                                        const pw.BoxConstraints(
                                                          maxWidth: 450,
                                                        ),
                                                    child: pw.Text(
                                                      "          ${user.username} balance income and expensing, emphasizing savings for goals. Regular budget reviews ensure financial resilience.",
                                                      style: pw.TextStyle(
                                                        color: PdfColors.black,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            pw
                                                                .FontWeight
                                                                .normal,
                                                        letterSpacing: 2,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            pw.SizedBox(height: 30),
                                            pw.Row(
                                              children: [
                                                pw.SizedBox(width: 108),
                                                pw.Text(
                                                  ' Master your money, master your life',
                                                  style: pw.TextStyle(
                                                    color: PdfColors.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        pw.FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ];
                          },
                        ),
                      );
                      await Printing.layoutPdf(
                        onLayout: (format) => pdf.save(),
                      );
                      final output = await getTemporaryDirectory();
                      final file = File(
                        "${output.path}/BudgetBuddy-Report.pdf",
                      );
                      await file.writeAsBytes(await pdf.save());
                    },
                  ),

                  const Gap(20),
                  const Text(
                    'F & Q',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const Gap(5),
                  SettingTile(
                    title: 'Feedback',
                    icon: FluentIcons.person_feedback_24_regular,
                    onTilePressed: () async {
                      Uri email = Uri(
                        scheme: 'mailto',
                        path: 'diyasakariya1227@gmail.com',
                        query:
                            'subject=Your Subject Here&body=Body of the email',
                      );
                      await launchUrl(email);
                    },
                  ),
                  const Gap(5),
                  SettingTile(
                    title: 'Privacy Policy',
                    icon: FluentIcons.tab_inprivate_account_24_regular,
                    onTilePressed: () {
                      Navigator.of(context).push(
                        PageTransition(
                          type: PageTransitionType.size,
                          duration: const Duration(seconds: 1),
                          alignment:
                              Alignment.bottomCenter, // or any other alignment
                          child: SavingPage(),
                        ),
                      );
                    },
                  ),
                  const Gap(5),
                  SettingTile(
                    title: 'Log Out',
                    icon: FluentIcons.arrow_exit_20_regular,
                    onTilePressed: () async {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        headerAnimationLoop: false,
                        animType: AnimType.scale,
                        title: 'Warning',
                        desc: 'Are you sure you want to log out ?',
                        btnCancelOnPress: () async {
                          print(
                            Provider.of<UserController>(
                              context,
                              listen: false,
                            ).username,
                          );
                        },
                        btnOkOnPress: () async {
                          Provider.of<UserController>(
                            context,
                            listen: false,
                          ).logoutUser();
                          await DbHelper.dbHelper.initDB();
                          await Provider.of<LogInController>(
                            context,
                            listen: false,
                          ).islogout();
                          Navigator.of(context).pushReplacement(
                            PageTransition(
                              type: PageTransitionType.size,
                              duration: const Duration(seconds: 1),
                              alignment: Alignment.bottomCenter,
                              child: LogInPage(),
                            ),
                          );
                        },
                      ).show();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
