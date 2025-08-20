
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/service_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/repair/Widget/section_chip.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/utils.dart';
import 'package:provider/provider.dart';

class RepairstepsScreen extends StatefulWidget {
  final String repairId;
  final bool isPaid;
  const RepairstepsScreen(
      {super.key, required this.repairId, required this.isPaid});

  @override
  State<RepairstepsScreen> createState() => _RepairstepsScreenState();
}

class _RepairstepsScreenState extends State<RepairstepsScreen> {
  void calculateTotal(ServiceProvider model) {
    total = model.repairDetails!.autoRepairHistory!
        .where((e) => e.status != '20' && e.status != '2')
        .fold<num>(
      0,
      (previousValue, element) {
        return previousValue + num.parse(element.cost!.replaceAll(',', ''));
      },
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    final model = Provider.of<ServiceProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      calculateTotal(model);
    });
  }

  Widget buildItem(
    String name,
    String price,
    VoidCallback onSkip,
    bool isPaid,
  ) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final isDark = themeProvider.isDarkMode();
    final themedata = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name,
                style: MyStyle.tx16Black.copyWith(
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff6E6D7A),
                )),
            Text("${Utils.naira}$price",
                style: MyStyle.tx16Black.copyWith(
                  fontWeight: FontWeight.w600,
                  color: themedata.tertiary,
                )),
          ],
        ),
        const SizedBox(height: 7),
        InkWell(
          onTap: isPaid ? null : onSkip,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
                border: Border.all(
                  color: isDark
                      ? const Color(0xff1B1B1B)
                      : const Color(0xffE9EBF8),
                ),
                borderRadius: BorderRadius.circular(999),
                color: isDark ? MyColor.dark02Color : MyColor.mainWhiteColor),
            child: Text(isPaid ? "Paid" : "Skip",
                style: MyStyle.tx14Black.copyWith(
                  fontWeight: FontWeight.w500,
                  color: isDark ? const Color(0xff0B930B) : MyColor.greenColor,
                )),
          ),
        ),
      ],
    );
  }

  num total = 0;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final isDark = themeProvider.isDarkMode();
    final model = context.watch<ServiceProvider>();
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
        backgroundColor: themeProvider.isDarkMode()
            ? MyColor.dark02Color
            : MyColor.mainWhiteColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20)
                .copyWith(bottom: 0),
            child: Column(
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
                        'Repair/Service History',
                        style: MyStyle.tx18Black
                            .copyWith(color: themedata.tertiary),
                      ),
                    ),
                    const Spacer(), // Adds flexible space after the text
                  ],
                ),
                if (model.repairDetails!.autoRepairHistory!.isEmpty)
                  Expanded(
                    child: Center(
                      child: Text('No Pending Payment Yet',
                          style: MyStyle.tx22RWhite.copyWith(
                            color: themedata.tertiary,
                          )),
                    ),
                  )
                else
                  Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        ListView.separated(
                            shrinkWrap: true,
                            separatorBuilder: (_, i) => SizedBox(height: 20),
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:
                                model.repairDetails!.autoRepairHistory!.length,
                            itemBuilder: (context, index) {
                              var item = model
                                  .repairDetails!.autoRepairHistory![index];
                              return item.status == '20'
                                  ? SizedBox.shrink()
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SectionChip(
                                          title: item.section!,
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 17),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: isDark
                                                ? const Color(0xff101010)
                                                : const Color(0xffFCFCFC),
                                            border: Border.all(
                                              color: isDark
                                                  ? const Color(0xff1B1B1B)
                                                  : const Color(0xffE9EBF8),
                                            ),
                                          ),
                                          child: buildItem(
                                            item.detail!,
                                            formatNumber(num.parse(item.cost!)),
                                            () {
                                              model.skipRepair(
                                                  repairID: widget.repairId,
                                                  workId: item.id!,
                                                account: context
                                                    .read<AccountProvider>(),
                                                  callback: () {
                                                    calculateTotal(model);
                                                },
                                              );
                                             
                                            },
                                            item.status == '2',
                                          ),
                                        )
                                      ],
                                    );
                            }),
                        SizedBox(height: 20),
                        _totalSection(
                          title: "Total Section",
                          total: model.repairDetails!.autoRepairHistory!
                              .where((e) => e.status != '20')
                              .toList()
                              .length,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 19),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                           
                                "Total Cost",
                                style: MyStyle.tx16Black.copyWith(
                                  color: const Color(0xff6E6D7A),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "${Utils.naira}${formatNumber(total)}",
                                style: MyStyle.tx16Black.copyWith(
                                  color: themedata.tertiary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: isDark
                              ? const Color(0xff1B1B1B)
                              : const Color(0xffE9EBF8),
                        ),
                        const SizedBox(height: 38),
                        OutlinedButton(
                          onPressed: () {
                            model.shareRepairInvoice(widget.repairId);
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide.none,
                            backgroundColor: themeProvider.isDarkMode()
                                ? const Color(0xff0B930B)
                                : MyColor.greenColor,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 11),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/images/svg/share.svg",
                                color: MyColor.mainWhiteColor,
                              ),
                              const SizedBox(width: 12),
                              Text("Share invoice",
                                  style: MyStyle.tx14Black.copyWith(
                                    fontFamily: 'SF Pro Rounded',
                                    color: MyColor.mainWhiteColor,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              side: BorderSide(
                                  color: themeProvider.isDarkMode()
                                      ? const Color(0xff0B930B)
                                      : MyColor.greenColor,
                                  width: 0.6),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 11),
                            ),
                            child: Text("Back to history",
                                style: MyStyle.tx14Black.copyWith(
                                  fontFamily: 'SF Pro Rounded',
                                  color: themeProvider.isDarkMode()
                                      ? const Color(0xff0B930B)
                                      : MyColor.greenColor,
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                        ),
                        SizedBox(height: 40),
                      ],
                    )),
                  ),
              ],
            ),
          ),
        ));
  }

  _totalSection({required String title, required int total}) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final isDark = themeProvider.isDarkMode();
    final themedata = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 19),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xff101010) : const Color(0xffFCFCFC),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: MyStyle.tx16Black.copyWith(
              color: const Color(0xff6E6D7A),
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "$total Services",
            style: MyStyle.tx16Black.copyWith(
              color: themedata.tertiary,
            ),
          ),
        ],
      ),
    );
  }
                        
}
