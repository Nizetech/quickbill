import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/service_provider.dart';
import 'package:jost_pay_wallet/Ui/giftCard/gift_card_summary_screen.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:jost_pay_wallet/Values/utils.dart';
import 'package:jost_pay_wallet/utils/toast.dart';
import 'package:provider/provider.dart';

import '../../Provider/theme_provider.dart';

class CardsOptionScreen extends StatefulWidget {
  const CardsOptionScreen({super.key});

  @override
  State<CardsOptionScreen> createState() => _CardsOptionScreenState();
}

class _CardsOptionScreenState extends State<CardsOptionScreen> {
  final amount = TextEditingController();
  final quantity = TextEditingController();
  final balance = TextEditingController();
  final phone = TextEditingController();
  List quantityList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  String selectedCountryCode = '234';
  String selectedCountry = 'NG';
  @override
  void initState() {
    super.initState();
    final model = Provider.of<AccountProvider>(context, listen: false);
    final service = Provider.of<ServiceProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      balance.text = formatNumber(num.parse(model.balance!.toString()));
      amount.text = service.cardModel!.amounts!.first.toString();
      quantity.text = quantityList.first.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<ServiceProvider>(builder: (context, model, _) {
          return Padding(
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
                        model.cardModel!.product!.productName!,
                        style: MyStyle.tx18Black
                            .copyWith(color: themedata.tertiary),
                      ),
                    ),
                    const Spacer(), // Adds flexible space after the text
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 32.h,
                        ),
                        Text(
                          'Amount',
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
                            ...model.cardModel!.amounts!
                                .map((e) => PopupMenuItem<String>(
                                    value: e.toString(),
                                    child: Text(
                                      "\$${e.toString()}",
                                      style: MyStyle.tx14Black.copyWith(
                                        color: themedata.tertiary,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )))
                                .toList(),
                          ],
                          onSelected: (val) {
                            setState(() {
                              amount.text = val.toString();
                            });
                          },
                          child: TextFormField(
                            enabled: false,
                            controller: amount,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: themedata.tertiary,
                              fontFamily: 'SF Pro Rounded',
                            ),
                            decoration: NewStyle.authInputDecoration.copyWith(
                                hintText: 'Select amount',
                                fillColor: themeProvider.isDarkMode()
                                    ? const Color(0XFF33353C)
                                    : MyColor.textFieldFillColor,
                                prefixIcon: Icon(
                                  Icons.monetization_on_outlined,
                                  color: themedata.tertiary,
                                ),
                                suffixIcon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: themedata.tertiary,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          'Quantity',
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
                            ...quantityList
                                .map((e) => PopupMenuItem<String>(
                                    value: e.toString(),
                                    child: Row(
                                      children: [
                                        if (e.toString() == quantity.text)
                                          Icon(
                                            Icons.check,
                                            color: themedata.tertiary,
                                          )
                                        else
                                          SizedBox(
                                            width: 22,
                                          ),
                                        const SizedBox(width: 8),
                                        Text(
                                          e.toString(),
                                          style: MyStyle.tx14Black.copyWith(
                                            color: themedata.tertiary,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    )))
                                .toList(),
                          ],
                          onSelected: (val) {
                            setState(() {
                              quantity.text = val.toString();
                            });
                          },
                          child: TextFormField(
                            enabled: false,
                            controller: quantity,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: themedata.tertiary,
                              fontFamily: 'SF Pro Rounded',
                            ),
                            decoration: NewStyle.authInputDecoration.copyWith(
                                hintText: 'Select quantity',
                                fillColor: themeProvider.isDarkMode()
                                    ? const Color(0XFF33353C)
                                    : MyColor.textFieldFillColor,
                                suffixIcon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: themedata.tertiary,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Your phone ',
                                style: MyStyle.tx14Black.copyWith(
                                  color: themedata.tertiary,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '(You will receive the Giftcard via SMS.)',
                                style: MyStyle.tx14Black.copyWith(
                                  fontSize: 12.sp,
                                  color: MyColor.dotBoarderColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        IntlPhoneField(
                          flagsButtonMargin: EdgeInsets.zero,
                          flagsButtonPadding: EdgeInsets.zero,
                          dropdownDecoration: BoxDecoration(
                            color: MyColor.mainWhiteColor,
                          ),
                          dropdownIcon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: MyColor.lightBlackColor,
                          ),
                          decoration: NewStyle.authInputDecoration.copyWith(
                            hintText: '8061560000',
                          ),
                          style: NewStyle.tx14SplashWhite.copyWith(
                            color: MyColor.lightBlackColor,
                            fontSize: 14,
                          ),
                          initialCountryCode: selectedCountry,
                          controller: phone,
                          onCountryChanged: (country) {
                            setState(() {
                              selectedCountry = country.code;
                              selectedCountryCode = country.dialCode;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.number.isEmpty) {
                              return 'Please enter a valid phone number';
                            } else if (!RegExp(r'^\+(?:[0-9] ?){6,14}[0-9]$')
                                .hasMatch(value.number)) {
                              return 'Please enter a valid phone number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          'Your balance',
                          style: MyStyle.tx14Black.copyWith(
                              color: themedata.tertiary,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        TextFormField(
                          enabled: false,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: themedata.tertiary,
                            fontFamily: 'SF Pro Rounded',
                          ),
                          controller: balance,
                          decoration: NewStyle.authInputDecoration.copyWith(
                            hintText: 'Select option',
                            fillColor: themeProvider.isDarkMode()
                                ? const Color(0XFF33353C)
                                : MyColor.textFieldFillColor,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 12, 0, 0),
                              child: Text(
                                Utils.naira,
                                style: MyStyle.tx14Black.copyWith(
                                    color: themedata.tertiary, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 32.h,
                        ),
                        Stack(
                          children: [
                            // Bottom border
                            DottedBorder(
                              color: MyColor.splashBtn,
                              strokeWidth: 1,
                              dashPattern: const [
                                6,
                                3
                              ], // Dash pattern: 6 units line, 3 units space

                              child: Container(
                                // height: 100.h,
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    vertical: 20.h, horizontal: 9.w),
                                decoration: BoxDecoration(
                                  color:
                                      MyColor.splashBtn.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Please note',
                                      style: MyStyle.tx14Black.copyWith(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      '${model.cardModel!.product!.productName!} Gift Card:',
                                      style: MyStyle.tx14Green,
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    Text(
                                      '* ${model.cardModel!.product!.redeemInstruction!.verbose}\n\n* Funds applied automatically, remaining balance requires other payment method\n\n* Delivered electronically via email\n\nNote: No returns or refunds on gift cards. Confirm country and type before purchase.',
                                      style: MyStyle.tx14Grey,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 42.h),
                        SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () {
                              if (phone.text.isEmpty) {
                                ErrorToast("Please enter phone number");
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          GiftCardSummaryScreen(
                                        amount: amount.text,
                                        cardModel: model.cardModel!,
                                        phoneNumber: phone.text,
                                        countryCode: selectedCountry,
                                        qty: quantity.text,
                                      ),
                                    ));
                              }
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: MyColor.splashBtn,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16), // Padding
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: MyColor.splashBtn,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: Text(
                              "Continue",
                              style: MyStyle.tx16Green.copyWith(
                                  color: MyColor.mainWhiteColor,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
