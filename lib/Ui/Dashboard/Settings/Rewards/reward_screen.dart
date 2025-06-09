import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Settings/Rewards/reward_record_screen.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen({super.key});

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  @override
  void initState() {
    super.initState();
    final model = Provider.of<AccountProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      model.getReferrals();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    final isDark = themeProvider.isDarkMode();
    return Scaffold(
        backgroundColor: themeProvider.isDarkMode()
            ? MyColor.dark02Color
            : MyColor.mainWhiteColor,
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 68)
                .copyWith(bottom: 0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                      'Rewards',
                      style: MyStyle.tx18Black.copyWith(
                          color: themedata.tertiary,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const Spacer(), // Adds flexible space after the text
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Image.asset(isDark
                  ? "assets/images/referal-dark.png"
                  : "assets/images/referal.png"),
              const SizedBox(
                height: 16,
              ),
              Divider(
                color: isDark
                    ? MyColor.outlineDasheColor.withOpacity(0.21)
                    : const Color(0xffE9EBF8),
                thickness: 0.5,
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 16)
                        .copyWith(bottom: 21),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        width: 0.6,
                        color: isDark
                            ? MyColor.outlineDasheColor.withOpacity(0.25)
                            : const Color(0xffE9EBF8))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: inviteStepsRow(),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: DottedLine(
                          dashLength: 4,
                          dashGapLength: 3,
                          lineThickness: 1,
                          dashColor: isDark
                              ? const Color(0xff1B1B1B)
                              : const Color(0xffE9EBF8)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Share Invitation Code",
                        style: MyStyle.tx14Grey
                            .copyWith(color: const Color(0xff6B7280)),
                      ),
                    ),
                    const SizedBox(
                      height: 17,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 11),
                          decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0xff131313)
                                  : const Color(0xffF9F9F9),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(999),
                                  bottomLeft: Radius.circular(999))),
                          child: Text(
                            "Q45738498",
                            style: MyStyle.tx18Black.copyWith(
                                color: themedata.tertiary,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(
                                const ClipboardData(text: "Q45738498"));
                            Fluttertoast.showToast(msg: "Copied to clipboard");
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 15)
                                .copyWith(right: 14),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0xff0B930B)
                                  : MyColor.greenColor,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(999),
                                bottomRight: Radius.circular(999),
                              ),
                            ),
                            child: Text(
                              "Copy Code",
                              style: MyStyle.tx12Black.copyWith(
                                  color: MyColor.mainWhiteColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    Text(
                      "https://project.jostpay.com/register? referral_code=Q45738498",
                      style: MyStyle.tx12Black.copyWith(
                          fontSize: 10,
                          color: isDark
                              ? MyColor.mainWhiteColor
                              : const Color(0xff40444D)),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: isDark
                          ? MyColor.outlineDasheColor.withOpacity(0.25)
                          : const Color(0xffE9EBF8),
                      width: 0.6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Background Circle
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isDark
                                      ? const Color(0xff0B930B)
                                      : MyColor.greenColor,
                                ),
                              ),

                              // Money Icon (PNG)
                              Transform.translate(
                                offset: const Offset(-1, 3),
                                child: ClipOval(
                                  child: SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: Image.asset(
                                      'assets/images/money.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Total Earned: N300",
                          style: MyStyle.tx18Black.copyWith(
                              color: themedata.tertiary,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    DottedLine(
                      dashLength: 2,
                      dashGapLength: 3,
                      lineThickness: 1,
                      dashColor: isDark
                          ? MyColor.outlineDasheColor.withOpacity(0.25)
                          : const Color(0xffE9EBF8),
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const RewardRecordScreen();
                          },
                        ));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Referral Earing Record",
                            style: MyStyle.tx14Black.copyWith(
                                fontWeight: FontWeight.w500,
                                color: isDark
                                    ? const Color(0xff6B7280)
                                    : const Color(0xff30333A)),
                          ),
                          const SizedBox(
                            width: 121,
                          ),
                          Icon(
                            Icons.arrow_forward_ios_sharp,
                            size: 15,
                            color: isDark
                                ? const Color(0xffCBD2EB)
                                : const Color(0xff141B34),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                  ],
                ),
              )
            ])));
  }

  Widget inviteStep(String imagePath, String label, String reward) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    final isDark = themeProvider.isDarkMode();
    return Column(
      children: [
        DottedBorder(
          borderType: BorderType.Circle,
          dashPattern: const [6, 6],
          color: const Color(0xff9CA3AF),
          strokeWidth: 0.7,
          child: Container(
            padding: const EdgeInsets.all(5),
            width: 40,
            height: 40,
            child: SvgPicture.asset(
              imagePath,
              color: isDark ? const Color(0xff0B930B) : MyColor.greenColor,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          textAlign: TextAlign.center,
          style: MyStyle.tx14Black.copyWith(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color:
                  isDark ? const Color(0xff6B7280) : const Color(0xff40444D)),
        ),
        const SizedBox(height: 4),
        Text(
          reward,
          style: MyStyle.tx14Black.copyWith(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color:
                  isDark ? const Color(0xff6B7280) : const Color(0xff40444D)),
        ),
      ],
    );
  }

  Widget inviteStepsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        inviteStep('assets/images/svg/medal.svg',
            'Invite one\n person\nand earn', '#500'),

        // Dotted line between steps
        Expanded(
          child: Transform.translate(
            offset: const Offset(0, -34),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0)
                  .copyWith(left: 20),
              child: const DottedLine(
                  dashLength: 4,
                  dashGapLength: 4,
                  lineThickness: 1,
                  dashColor: Color(0xff9CA3AF)),
            ),
          ),
        ),

        inviteStep('assets/images/svg/medal.svg', 'Invite 3\n person\nand earn',
            '#1500'),

        Expanded(
          child: Transform.translate(
            offset: const Offset(0, -34),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0)
                  .copyWith(left: 20),
              child: const DottedLine(
                  dashLength: 4,
                  dashGapLength: 4,
                  lineThickness: 1,
                  dashColor: Color(0xff9CA3AF)),
            ),
          ),
        ),

        inviteStep('assets/images/svg/medal.svg', 'Invite 5\n person\nand earn',
            '#3000'),
      ],
    );
  }
}
