import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jost_pay_wallet/Provider/service_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/NewColor.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:jost_pay_wallet/Values/utils.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:provider/provider.dart';

class ElectricitySummaryScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  final bool saveDetails;
  const ElectricitySummaryScreen({
    super.key,
    required this.saveDetails,
    required this.data,
  });

  @override
  State<ElectricitySummaryScreen> createState() =>
      _ElectricitySummaryScreenState();
}

class _ElectricitySummaryScreenState extends State<ElectricitySummaryScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      body: Consumer<ServiceProvider>(builder: (context, model, _) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 24, right: 24),
            child: Column(
              children: [
                Row(
                  children: [
                    BackBtn(),
                    const Spacer(),
                    Transform.translate(
                      offset: const Offset(-20, 0),
                      child: Text(
                        'Electricity Summary',
                        style: MyStyle.tx18Black.copyWith(
                          color: themedata.tertiary,
                        ),
                      ),
                    ),
                    const Spacer(), // Adds flexible space after the text
                  ],
                ),
                SizedBox(
                  height: 78.h,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      boxShadow: const [MyStyle.widgetShadow],
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: MyColor.borderColor,
                              width: 1,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              widget.data['img'],
                              height: 85.r,
                              width: 85.r,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Electricity Summary',
                        style: MyStyle.tx14Black.copyWith(
                            fontFamily: 'Roboto', color: themedata.tertiary),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Service Name',
                            style: MyStyle.tx12Grey,
                          ),
                          const Spacer(),
                          Text(
                            widget.data['name'],
                            style: MyStyle.tx12Black.copyWith(
                                color: themedata.tertiary,
                                fontFamily: 'SF Pro Rounded'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Customer Name',
                            style: MyStyle.tx12Grey,
                          ),
                          const Spacer(),
                          Text(
                            widget.data['merchant'],
                            style: MyStyle.tx12Black.copyWith(
                                color: themedata.tertiary,
                                fontFamily: 'SF Pro Rounded'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Phone Number',
                            style: MyStyle.tx12Grey,
                          ),
                          const Spacer(),
                          Text(
                            widget.data['phone'],
                            style: MyStyle.tx12Black.copyWith(
                                color: themedata.tertiary,
                                fontFamily: 'SF Pro Rounded'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Meter Number',
                            style: MyStyle.tx12Grey,
                          ),
                          const Spacer(),
                          Text(
                            widget.data['meter_number'],
                            style: MyStyle.tx12Black.copyWith(
                                color: themedata.tertiary,
                                fontFamily: 'SF Pro Rounded'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Meter Type',
                            style: MyStyle.tx12Grey,
                          ),
                          const Spacer(),
                          Text(
                            widget.data['meter_type'],
                            style: MyStyle.tx12Black.copyWith(
                                color: themedata.tertiary,
                                fontFamily: 'SF Pro Rounded'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Payment method',
                            style: MyStyle.tx12Grey,
                          ),
                          const Spacer(),
                          Text(
                            'wallet',
                            style: MyStyle.tx12Black.copyWith(
                                color: themedata.tertiary,
                                fontFamily: 'SF Pro Rounded'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        width: double.infinity, // Full width of the screen
                        height: 4, // Adjust height as needed
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: DottedBorder(
                                color: themeProvider.isDarkMode()
                                    ? MyColor.borderDarkColor
                                    : MyColor.borderColor,
                                strokeWidth: 1,
                                dashPattern: const [
                                  6,
                                  3
                                ], // Dash pattern: 6 units line, 3 units space
                                customPath: (size) => Path()
                                  ..moveTo(0, 0)
                                  ..lineTo(size.width, 0),
                                child: Container(
                                  height:
                                      0, // The container for the border can have a height of 0
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          const Text(
                            'You pay',
                            style: MyStyle.tx12Grey,
                          ),
                          const Spacer(),
                          Text(
                            '${Utils.naira} ${formatNumber(
                              num.parse(
                                widget.data['amount'],
                              ),
                            )}',
                            style: MyStyle.tx14Black.copyWith(
                                fontWeight: FontWeight.w600,
                                color: themedata.tertiary,
                                fontFamily: 'SF Pro Rounded'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 47.h),
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
                      Map<String, dynamic> data = {
                        'type': widget.data['meter_type'],
                        "service_id": widget.data['service_id'],
                        "amount": widget.data['amount'],
                        "number": widget.data['meter_number'],
                        "phone": widget.data['phone'],
                        "details": widget.saveDetails ? 1 : 0,
                      };
                      model.buyElectricity(data);
                    },
                    child: Text(
                      "Confirm",
                      style: NewStyle.btnTx16SplashBlue
                          .copyWith(color: NewColor.mainWhiteColor),
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
