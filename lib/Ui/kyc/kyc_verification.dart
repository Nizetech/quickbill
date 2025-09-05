import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/kyc/personal_info_verif.dart';
import 'package:jost_pay_wallet/Ui/kyc/widget/info_wrap.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:provider/provider.dart';


class KycVerification extends StatefulWidget {
  const KycVerification({super.key});

  @override
  State<KycVerification> createState() => _KycVerificationState();
}

class _KycVerificationState extends State<KycVerification> {
  List<Map> basicVerification = [
    {
      'level': 'Entry Level',
      'title': 'Basic Verification',
      'info': 'Face Capture Only: Monthly Deposit Limit N20,000',
      'features': [
        'Quick Setup: Complete in under 2mins with face caption.',
        'Essential Access: Buy airtime, data, & basic services.',
        'Limited Limit: Capped at N20,000 per month.',
      ],
      'btn': 'Choose Basic Plan',
    },
    {
      'level': 'Recommended',
      'title': 'Full Verification',
      'info': 'Face Capture + ID Upload Deposit Limit: Unlimited',
      'features': [
        'Enhance Security: Face Capture & Government ID',
        "Full Access: Unlock advanced services such as gift card, auto repair, painting etc.",
        'No Monthly Cap: Transact without limits',
      ],
      'btn': 'Choose Full Plan',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
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
                      'KYC Verification',
                      style:
                          MyStyle.tx18Black.copyWith(color: themedata.tertiary),
                    ),
                  ),
                  const Spacer(), // Adds flexible space after the text
                ],
              ),
              const SizedBox(height: 30),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      InfoWrap(
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/warning.svg',
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                  'Choose Your Verification: Upgrade anytime to unlock high limit and features',
                                  style: MyStyle.tx14Black.copyWith(
                                    color: themedata.tertiary,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final data = basicVerification[index];
                          return Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              border: Border(
                                bottom: BorderSide(
                                  color: MyColor.greenColor,
                                  width: 2,
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: themeProvider.isDarkMode()
                                        ? Color(0xff162A16)
                                        : MyColor.lightGreenColor,
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                      color: MyColor.greenColor,
                                    ),
                                  ),
                                  child: Text(
                                    data['level'],
                                    style: MyStyle.tx14Black.copyWith(
                                      color: themeProvider.isDarkMode()
                                          ? Color(0xffB5FAB5)
                                          : MyColor.greenColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 13),
                                Divider(
                                  color: MyColor.borderColor
                                      .withValues(alpha: 0.2),
                                  height: 1,
                                ),
                                const SizedBox(height: 12),
                                Text(data['title'],
                                    style: MyStyle.tx14Black.copyWith(
                                      color: themedata.tertiary,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    )),
                                const SizedBox(height: 10),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: MyColor.grey01Color
                                          .withValues(alpha: 0.2),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/images/face_info.svg',
                                            color: themedata.tertiary,
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              data['info'],
                                              style: MyStyle.tx14Black.copyWith(
                                                color: themedata.tertiary,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        Icon(
                                          Icons.check_circle,
                                          color: MyColor.greenColor,
                                          size: 18,
                                        ),
                                        const SizedBox(width: 5),
                                        Expanded(
                                          child: Text(
                                            data['features'][index],
                                            style: MyStyle.tx14Black.copyWith(
                                              color: themedata.tertiary,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(height: 10);
                                  },
                                  itemCount: data['features'].length,
                                ),
                                const SizedBox(height: 20),
                                CustomButton(
                                  text: data['btn'],
                                  textColor: MyColor.greenColor,
                                  bgColor: themeProvider.isDarkMode()
                                      ? Color(0xff162A16)
                                      : MyColor.lightGreenColor,
                                  onTap: () => Get.to(
                                    () => PersonalInfoVerif(
                                      isBasic: data['level'] == 'Entry Level',
                                    ),
                                   
                                  ),
                                  radius: 40,
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 20);
                        },
                        itemCount: basicVerification.length,
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
