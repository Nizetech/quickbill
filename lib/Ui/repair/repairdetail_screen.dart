import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/service_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Domain/widget/dot.dart';
import 'package:jost_pay_wallet/Ui/repair/Widget/repair_transaction_tile.dart';
import 'package:jost_pay_wallet/Ui/repair/repair_screen.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

class RepairdetailScreen extends StatefulWidget {
  const RepairdetailScreen({super.key});

  @override
  State<RepairdetailScreen> createState() => _RepairdetailScreenState();
}

class _RepairdetailScreenState extends State<RepairdetailScreen> {
  @override
  void initState() {
    super.initState();
    final model = Provider.of<ServiceProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (model.repairTransactions == null) {
        model.getRepairTransactions(account: context.read<AccountProvider>());
      } else {
        model.getRepairTransactions(
            isLoading: false, account: context.read<AccountProvider>());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final isDark = themeProvider.isDarkMode();
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
        backgroundColor: themeProvider.isDarkMode()
            ? MyColor.dark02Color
            : MyColor.mainWhiteColor,
        body: Consumer<ServiceProvider>(builder: (context, model, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 68)
                .copyWith(bottom: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        'assets/images/arrow_left.png',
                        color: themeProvider.isDarkMode()
                            ? MyColor.mainWhiteColor
                            : MyColor.dark01Color,
                      ),
                    ),
                    const Spacer(),
                    Transform.translate(
                      offset: const Offset(-20, 0),
                      child: Text(
                        'Repair',
                        style: MyStyle.tx18Black
                            .copyWith(color: themedata.tertiary),
                      ),
                    ),
                    const Spacer(), // Adds flexible space after the text
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 19),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: isDark
                            ? const Color(0xff1B1B1B)
                            : const Color(0xffE9EBF8),
                        width: 2,
                      ),
                    ),
                    color: isDark
                        ? const Color(0xff101010)
                        : const Color(0xffFCFCFC),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Repair/Service History",
                    style: MyStyle.tx20Grey.copyWith(
                      fontWeight: FontWeight.w400,
                      color: themedata.tertiary,
                    ),
                  ),
                ),
                const SizedBox(height: 17),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RepairScreen(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 11),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xff181818)
                          : const Color(0xffF4F4F4),
                      border: Border(
                        right: BorderSide(
                          color: isDark
                              ? const Color(0xffC8FBC8)
                              : const Color(0xff043704),
                          width: 3,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isDark
                                ? const Color(0xffC8FBC8)
                                : const Color(0xff043704),
                          ),
                          child: SvgPicture.asset(
                            'assets/images/svg/appointment.svg',
                            color: isDark
                                ? MyColor.dark02Color
                                : MyColor.mainWhiteColor,
                          ),
                        ),
                        const SizedBox(width: 11),
                        Text("Schedule Appointment/Pick Up",
                            style: MyStyle.tx16Black.copyWith(
                              fontWeight: FontWeight.w400,
                              color: themedata.tertiary,
                            )),
                        const SizedBox(width: 10),
                        SvgPicture.asset(
                          'assets/images/svg/line.svg',
                          width: 28,
                          color: isDark
                              ? MyColor.mainWhiteColor
                              : Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                if (model.repairTransactions != null)
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await model.getRepairTransactions(
                            account: context.read<AccountProvider>());
                      },
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: model.repairTransactions!.repairList!.length,
                        itemBuilder: (_, i) => RepairTransactionTile(
                          repairTile: model.repairTransactions!.repairList![i],
                        ),
                        separatorBuilder: (_, i) => const SizedBox(height: 10),
                      ),
                    ),
                  ),
              ],
            ),
          );
        }
        ));
  }
}

class StatusIndicator extends StatelessWidget {
  final String text;
  final Color color;
  const StatusIndicator({
    super.key,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text,
            style: MyStyle.tx14White.copyWith(
              fontWeight: FontWeight.w400,
              color: color,
            )),
        const SizedBox(width: 8),
        Dot(
          color: color,
          size: 15,
        )
      ],
    );
  }
}
