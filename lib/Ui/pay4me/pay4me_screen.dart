import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/service_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/pay4me/pay4me_summary_screen.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/NewColor.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:jost_pay_wallet/utils/toast.dart';
import 'package:provider/provider.dart';

class Pay4meScreen extends StatefulWidget {
  const Pay4meScreen({super.key});

  @override
  State<Pay4meScreen> createState() => _Pay4meScreenState();
}

class _Pay4meScreenState extends State<Pay4meScreen> {
  List paymentOption = ["Paypal", "Visa & Mastercard"];
  int selectedOption = 0;
  final payCtrl = TextEditingController();
  final amountCtrl = TextEditingController();
  final username = TextEditingController();
  final pwd = TextEditingController();
  final link = TextEditingController();
  @override
  void initState() {
    super.initState();
    final model = Provider.of<ServiceProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      payCtrl.text = paymentOption[selectedOption];
      model.getPayRate();
    });
  }

  num amount = 0;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Consumer2<ServiceProvider, AccountProvider>(
          builder: (context, model, ctrl, _) {
        return SafeArea(
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
                        style: MyStyle.tx18Black
                            .copyWith(color: themedata.tertiary),
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
                        PopupMenuButton(
                          color: themeProvider.isDarkMode()
                              ? const Color(0XFF33353C)
                              : MyColor.textFieldFillColor,
                          position: PopupMenuPosition.under,
                          itemBuilder: (_) => <PopupMenuItem<String>>[
                            ...paymentOption
                                .map((e) => PopupMenuItem<String>(
                                    value: e.toString(),
                                    child: Text(
                                      e,
                                      style: MyStyle.tx14Black.copyWith(
                                        color: themedata.tertiary,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )))
                                ,
                          ],
                          onSelected: (val) {
                            selectedOption = paymentOption.indexOf(val);
                            setState(() {
                              if (amountCtrl.text.isNotEmpty) {
                                if (selectedOption == 0) {
                                  amount = num.parse(amountCtrl.text) *
                                      model.paymentFeeModel!.paypalPercent! *
                                      num.parse(
                                          model.paymentFeeModel!.ngnPrice!);
                                } else {
                                  amount = num.parse(amountCtrl.text) *
                                      model.paymentFeeModel!.cardPercent! *
                                      num.parse(
                                          model.paymentFeeModel!.ngnPrice!);
                                }
                              }
                              payCtrl.text = val.toString();
                            });
                          },
                          child: TextFormField(
                            enabled: false,
                            controller: payCtrl,
                            style: MyStyle.tx14Black.copyWith(
                              color: themedata.tertiary,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: NewStyle.authInputDecoration.copyWith(
                                hintText: 'Select option',
                                fillColor: themeProvider.isDarkMode()
                                    ? const Color(0XFF33353C)
                                    : MyColor.textFieldFillColor,
                                // prefixIcon: Padding(
                                //   padding: const EdgeInsets.all(14.0),
                                //   child: SvgPicture.asset(
                                //     'assets/images/svg/paypal.svg',
                                //     height: 8.r,
                                //     width: 10.r,
                                //   ),
                                // ),
                                suffixIcon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: themedata.tertiary,
                                )),
                          ),
                        ),
                        const SizedBox(height: 25),
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
                          controller: amountCtrl,
                          keyboardType: TextInputType.number,
                          style: MyStyle.tx14Black.copyWith(
                            color: themedata.tertiary,
                            fontWeight: FontWeight.w400,
                          ),
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Please enter amount';
                          //   } else if (num.parse(value) < 30) {
                          //     return 'Minimum amount should be \$30';
                          //   }
                          //   return null;
                          // },
                          onChanged: (val) {
                            setState(() {
                              if (amountCtrl.text.isNotEmpty) {
                                if (selectedOption == 0) {
                                  amount = num.parse(amountCtrl.text) *
                                      model.paymentFeeModel!.paypalPercent! *
                                      num.parse(
                                          model.paymentFeeModel!.ngnPrice!);
                                } else {
                                  amount = num.parse(amountCtrl.text) *
                                      model.paymentFeeModel!.cardPercent! *
                                      num.parse(
                                          model.paymentFeeModel!.ngnPrice!);
                                }
                              }
                            });
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: NewStyle.authInputDecoration.copyWith(
                            hintText: 'Enter amount',
                            fillColor: themeProvider.isDarkMode()
                                ? const Color(0XFF33353C)
                                : MyColor.textFieldFillColor,
                            prefixIcon: const Padding(
                              padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
                              child: Text(
                                '\$',
                                style: MyStyle.tx16Gray,
                              ),
                            ),
                          ),
                        ),
                        if (amountCtrl.text.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              'NGN amount: ${formatNumber(amount)}',
                              style: MyStyle.tx14Grey,
                            ),
                          ),
                        SizedBox(height: 25),
                        Text.rich(
                          TextSpan(
                              text: 'Your invoice Link',
                              children: const [
                                TextSpan(
                                    text:
                                        ' (The site address should be link us to an invoice)',
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
                          controller: link,
                          style: MyStyle.tx14Black.copyWith(
                            color: themedata.tertiary,
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: NewStyle.authInputDecoration.copyWith(
                            hintText: 'Enter Invoice link',
                            fillColor: themeProvider.isDarkMode()
                                ? const Color(0XFF33353C)
                                : MyColor.textFieldFillColor,
                          ),
                        ),
                        SizedBox(height: 25),
                        Text.rich(
                          TextSpan(
                              text: 'Account Username',
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
                          controller: username,
                          style: MyStyle.tx14Black.copyWith(
                            color: themedata.tertiary,
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: NewStyle.authInputDecoration.copyWith(
                            hintText: 'Enter Username',
                            fillColor: themeProvider.isDarkMode()
                                ? const Color(0XFF33353C)
                                : MyColor.textFieldFillColor,
                          ),
                        ),
                        SizedBox(height: 25),
                        Text.rich(
                          TextSpan(
                              text: 'Account Password',
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
                          controller: pwd,
                          style: MyStyle.tx14Black.copyWith(
                            color: themedata.tertiary,
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: NewStyle.authInputDecoration.copyWith(
                            hintText: 'Enter password',
                            fillColor: themeProvider.isDarkMode()
                                ? const Color(0XFF33353C)
                                : MyColor.textFieldFillColor,
                          ),
                        ),
                        SizedBox(height: 50.h),
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
                              if (amountCtrl.text.isEmpty ||
                                  username.text.isEmpty ||
                                  link.text.isEmpty ||
                                  pwd.text.isEmpty) {
                                ErrorToast("Please fill all fields");
                                // } else if (num.parse(amountCtrl.text) < 30) {
                                //   ErrorToast("Minimum amount is \$30");
                                // } else if (amount > ctrl.balance!) {
                                //   ErrorToast('Insufficient balance');
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Pay4meSummaryScreen(data: {
                                      "payOption": selectedOption,
                                      "amount": amountCtrl.text,
                                      "username": username.text,
                                      "pwd": pwd.text,
                                      "link": link.text,
                                      "total": amount,
                                    }),
                                  ),
                                );
                              }
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
        );
      }),
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
    final model = context.read<AccountProvider>();
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total balance',
            style: MyStyle.tx12Grey,
          ),
          Text(
            '₦ ${formatNumber(model.balance ?? 0)}',
            style: MyStyle.tx32Black.copyWith(
              color: themedata.tertiary,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
    );
  }
}
