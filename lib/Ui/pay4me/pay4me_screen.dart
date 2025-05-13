import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/pay4me/pay4me_summary_screen.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/NewColor.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:provider/provider.dart';

class Pay4meScreen extends StatefulWidget {
  const Pay4meScreen({super.key});

  @override
  State<Pay4meScreen> createState() => _Pay4meScreenState();
}

class _Pay4meScreenState extends State<Pay4meScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
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
                      'Choose Companies',
                      style:
                          MyStyle.tx18Black.copyWith(color: themedata.tertiary),
                    ),
                  ),
                  const Spacer(), // Adds flexible space after the text
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          // height: 100.h,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              vertical: 20.h, horizontal: 15.w),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: MyColor.splashBtn,
                            ),
                            color: MyColor.splashBtn.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Text(
                            'Easily pay for any services online using Mastercard, Visa, or paypal. Our platform ensures a convenient and hassle-free payment experience\n for all your needs',
                            style: MyStyle.tx14Black.copyWith(
                                color: MyColor.splashBtn,
                                fontSize: 12.sp,
                                height: 1.5,
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                          )),
                      SizedBox(
                        height: 24.h,
                      ),
                      const CompanyCard(),
                      SizedBox(
                        height: 26.h,
                      ),
                      Text(
                        'We pay With',
                        style: MyStyle.tx14Black.copyWith(
                            color: themedata.tertiary,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      TextFormField(
                        enabled: false,
                        initialValue: 'Paypal',
                        decoration: NewStyle.authInputDecoration.copyWith(
                            hintText: 'Select option',
                            fillColor: themeProvider.isDarkMode()
                                ? const Color(0XFF33353C)
                                : MyColor.textFieldFillColor,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: SvgPicture.asset(
                                'assets/images/svg/paypal.svg',
                                height: 8.r,
                                width: 10.r,
                              ),
                            ),
                            suffixIcon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: themedata.tertiary,
                            )),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Amount to send',
                        style: MyStyle.tx14Black.copyWith(
                            color: themedata.tertiary,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      TextFormField(
                        enabled: false,
                        initialValue: '50',
                        decoration: NewStyle.authInputDecoration.copyWith(
                            hintText: 'Select option',
                            fillColor: themeProvider.isDarkMode()
                                ? const Color(0XFF33353C)
                                : MyColor.textFieldFillColor,
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(12.r),
                              child: const Text(
                                '\$',
                                style: MyStyle.tx16Gray,
                              ),
                            ),
                            suffixIcon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: themedata.tertiary,
                            )),
                      ),
                      SizedBox(height: 36.h),
                      Text.rich(
                        TextSpan(
                            text: 'Your invoice link',
                            children: const [
                              TextSpan(
                                  text:
                                      ' (The site address should be linked us to an invoice)',
                                  style: MyStyle.tx14Grey),
                            ],
                            style: MyStyle.tx14Black.copyWith(
                              fontWeight: FontWeight.w500,
                              color: themedata.tertiary,
                            )),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      TextFormField(
                        decoration: NewStyle.authInputDecoration.copyWith(
                          fillColor: themeProvider.isDarkMode()
                              ? const Color(0XFF33353C)
                              : MyColor.textFieldFillColor,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Text.rich(
                        TextSpan(
                            text: 'Your invoice link',
                            children: const [
                              TextSpan(
                                  text:
                                      ' (Please fill this blank if it is needed)',
                                  style: MyStyle.tx14Grey),
                            ],
                            style: MyStyle.tx14Black.copyWith(
                              fontWeight: FontWeight.w500,
                              color: themedata.tertiary,
                            )),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      TextFormField(
                        decoration: NewStyle.authInputDecoration.copyWith(
                          hintText: 'Select option',
                          fillColor: themeProvider.isDarkMode()
                              ? const Color(0XFF33353C)
                              : MyColor.textFieldFillColor,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Text.rich(
                        TextSpan(
                            text: 'Your account password',
                            children: const [
                              TextSpan(
                                  text:
                                      ' (Please fill this blank if it is needed)',
                                  style: MyStyle.tx14Grey),
                            ],
                            style: MyStyle.tx14Black.copyWith(
                              fontWeight: FontWeight.w500,
                              color: themedata.tertiary,
                            )),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      TextFormField(
                        decoration: NewStyle.authInputDecoration.copyWith(
                          hintText: 'Select option',
                          fillColor: themeProvider.isDarkMode()
                              ? const Color(0XFF33353C)
                              : MyColor.textFieldFillColor,
                        ),
                      ),
                      SizedBox(height: 105.h),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: MyColor.greenColor,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Pay4meSummaryScreen()));
                          },
                          child: Text(
                            "Continue",
                            style: NewStyle.btnTx16SplashBlue
                                .copyWith(color: NewColor.mainWhiteColor),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32.h,
                      )
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

class CompanyCard extends StatelessWidget {
  const CompanyCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;

    return Container(
      width: 163.w,
      height: 114.h,
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
          border: Border.all(
            color: themeProvider.isDarkMode()
                ? MyColor.borderDarkColor
                : MyColor.borderColor,
          ),
          borderRadius: BorderRadius.circular(8.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/usa.png',
                height: 28.r,
                width: 28.r,
              ),
              Text(
                'USD',
                style: MyStyle.tx8White.copyWith(color: themedata.tertiary),
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '\$',
                style: MyStyle.tx16Black.copyWith(color: themedata.tertiary),
              ),
              Text(
                '100.00',
                style: MyStyle.tx12Black.copyWith(color: themedata.tertiary),
              ),
              Text(
                '≍',
                style: MyStyle.tx16Black.copyWith(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: themedata.tertiary),
              ),
              Text(
                '150,00.00 NGN',
                style: MyStyle.tx8White.copyWith(
                    color: themeProvider.isDarkMode()
                        ? const Color(0XFFCBD2EB)
                        : const Color(0xff30333A)),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Available Balance',
              style: MyStyle.tx8White.copyWith(color: MyColor.splashBtn),
            ),
          ),
        ],
      ),
    );
  }
}
