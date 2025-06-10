import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jost_pay_wallet/Models/social_services.dart' as ser;
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:jost_pay_wallet/Provider/service_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/promotions/soical_summary_screen.dart';
import 'package:jost_pay_wallet/Ui/promotions/widget/service_selection_sheet.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:jost_pay_wallet/utils/toast.dart';
import 'package:provider/provider.dart';

class SocialBoost extends StatefulWidget {
  const SocialBoost({super.key});

  @override
  State<SocialBoost> createState() => _SocialBoostState();
}

class _SocialBoostState extends State<SocialBoost> {
  final service = TextEditingController();
  final qty = TextEditingController();
  final price = TextEditingController();
  String serviceDescr = '';
  ser.Service? selectedService;
  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context).colorScheme;
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    return Scaffold(
      body: Consumer<ServiceProvider>(builder: (context, model, _) {
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
                        'Social Boost',
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
                        Text(
                          'Service',
                          style: MyStyle.tx14Black.copyWith(
                              color: themedata.tertiary,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            serviceSelectionSheet(
                              themeProvider: themeProvider,
                              services: model.socialServiceModel!.services,
                              onSelect: (val) {
                                setState(() {
                                  selectedService = val;
                                  service.text = val.serviceName!;
                                  serviceDescr = val.description!;
                                  if (qty.text.isNotEmpty) {
                                    setState(() {
                                      var amount = num.parse(qty.text) *
                                          num.parse(selectedService!.price!
                                              .toString());
                                      price.text = formatNumber(
                                        amount,
                                      );
                                    });
                                  }
                                });
                              },
                            );
                          },
                          child: TextFormField(
                            controller: service,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: themedata.tertiary,
                              fontFamily: 'SF Pro Rounded',
                            ),
                            enabled: false,
                            decoration: NewStyle.authInputDecoration.copyWith(
                                hintText: 'Select Service',
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
                          height: 32.h,
                        ),
                        Stack(
                          children: [
                            // Bottom border
                            DottedBorder(
                              strokeCap: StrokeCap.round,
                              radius: Radius.circular(10),
                              color: MyColor.splashBtn,
                              strokeWidth: 1,
                              dashPattern: const [
                                6,
                                3
                              ], // Dash pattern: 6 units line, 3 units space

                              child: Container(
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
                                    HtmlWidget(
                                      serviceDescr,
                                      textStyle: MyStyle.tx14Black.copyWith(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/svg/info.svg',
                                          height: 18.r,
                                          width: 18.r,
                                        ),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        const Text(
                                          'Please note',
                                          style: MyStyle.tx14Green,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    const Text(
                                      'Some content limitations apply (e.g, drugs, political, religious content) \n\nIf these limitations are violated , the order will be canceled. Video must be public throughout the order\n\nNo refunds for orders if the video is removed or made private while in progress.',
                                      style: MyStyle.tx14Grey,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Link',
                          style: MyStyle.tx14Black.copyWith(
                              color: themedata.tertiary,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        TextFormField(
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: themedata.tertiary,
                            fontFamily: 'SF Pro Rounded',
                          ),
                          decoration: NewStyle.authInputDecoration.copyWith(
                            hintText: 'Paste Link',
                            fillColor: themeProvider.isDarkMode()
                                ? const Color(0XFF33353C)
                                : MyColor.textFieldFillColor,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Quantity',
                          style: MyStyle.tx14Black.copyWith(
                              color: themedata.tertiary,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 6.h),
                        GestureDetector(
                          onTap: () {
                            if (selectedService == null) {
                              fancyToast('Please select a service');
                            }
                          },
                          child: TextFormField(
                            controller: qty,
                            enabled: selectedService != null,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: themedata.tertiary,
                              fontFamily: 'SF Pro Rounded',
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null ||
                                  value.isNotEmpty &&
                                      num.parse(value) <
                                          num.parse(
                                              selectedService!.minQuantity!)) {
                                return 'Minimum quantity is ${formatNumber(num.parse(selectedService!.minQuantity!))}';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              log('Value: $value');
                              if (value.isNotEmpty) {
                                setState(() {
                                  var amount = num.parse(value) *
                                      num.parse(
                                          selectedService!.price!.toString());
                                  price.text = formatNumber(
                                    amount,
                                  );
                                });
                              }
                            },
                            decoration: NewStyle.authInputDecoration.copyWith(
                              hintText: 'Enter Quantity',
                              fillColor: themeProvider.isDarkMode()
                                  ? const Color(0XFF33353C)
                                  : MyColor.textFieldFillColor,
                            ),
                          ),
                        ),
                        if (selectedService != null)
                          Text(
                            'Min: ${formatNumberWithOutDecimal(
                              selectedService!.minQuantity.toString(),
                            )} - Max: ${formatNumberWithOutDecimal(
                              selectedService!.maxQuantity.toString(),
                            )}',
                            style: MyStyle.tx14Grey,
                          ),
                        const SizedBox(height: 20),
                        Text(
                          'Charges (NGN)',
                          style: MyStyle.tx14Black.copyWith(
                              color: themedata.tertiary,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        TextFormField(
                          enabled: false,
                          controller: price,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: themedata.tertiary,
                            fontFamily: 'SF Pro Rounded',
                          ),
                          decoration: NewStyle.authInputDecoration.copyWith(
                            hintText: 'Enter quantity',
                            fillColor: themeProvider.isDarkMode()
                                ? const Color(0XFF33353C)
                                : MyColor.textFieldFillColor,
                          ),
                        ),
                        SizedBox(height: 42.h),
                        SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SocialSummaryScreen(),
                                  ));
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
          ),
        );
      }),
    );
  }
}
