import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Models/network_provider.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/NewColor.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:jost_pay_wallet/Values/utils.dart';
import 'package:provider/provider.dart';

class Buyairtimeconfirmdetail extends StatefulWidget {
  final Network selectedNetwork;
  final String amount;
  final String number;
  const Buyairtimeconfirmdetail(
      {super.key,
      required this.selectedNetwork,
      required this.amount,
      required this.number});

  @override
  State<Buyairtimeconfirmdetail> createState() =>
      _BuyairtimeconfirmdetailState();
}

class _BuyairtimeconfirmdetailState extends State<Buyairtimeconfirmdetail> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      body: Consumer<AccountProvider>(builder: (context, model, _) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 14, left: 24, right: 24),
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () => Get.back(),
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
                        'Buy Airtime',
                        style: MyStyle.tx18Black
                            .copyWith(color: themedata.tertiary),
                      ),
                    ),
                    const Spacer(), // Adds flexible space after the text
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      boxShadow: themeProvider.isDarkMode()
                          ? null
                          : const [MyStyle.widgetShadow],
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: widget.selectedNetwork.logo ?? "",
                          height: 68,
                          width: 86,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Airtime Purchase Summary',
                        style: MyStyle.tx14Black.copyWith(
                            fontFamily: 'Roboto', color: themedata.tertiary),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Airtime Provider',
                            style: MyStyle.tx12Grey,
                          ),
                          const Spacer(),
                          Text(
                            widget.selectedNetwork.network!,
                            style: MyStyle.tx12Black.copyWith(
                                fontWeight: FontWeight.w500,
                                color: themedata.tertiary,
                                fontFamily: 'SF Pro Rounded'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      // Row(
                      //   children: [
                      //     const Text(
                      //       'Expiry Date',
                      //       style: MyStyle.tx12Grey,
                      //     ),
                      //     const Spacer(),
                      //     Text(
                      //       '1 day',
                      //       style: MyStyle.tx12Black.copyWith(
                      //           color: themedata.tertiary,
                      //           fontWeight: FontWeight.w500,
                      //           fontFamily: 'SF Pro Rounded'),
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 12,
                      // ),
                      // Row(
                      //   children: [
                      //     const Text(
                      //       'Carrier',
                      //       style: MyStyle.tx12Grey,
                      //     ),
                      //     const Spacer(),
                      //     Text(
                      //       'MTN Direct Top-up (Prepaid)',
                      //       style: MyStyle.tx12Black.copyWith(
                      //           fontWeight: FontWeight.w500,
                      //           color: themedata.tertiary,
                      //           fontFamily: 'SF Pro Rounded'),
                      //     ),
                      //   ],
                      // ),
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
                            widget.number,
                            style: MyStyle.tx12Black.copyWith(
                                fontWeight: FontWeight.w500,
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
                            // Bottom border
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: DottedBorder(
                                color: MyColor.borderColor,
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
                            'Amount',
                            style: MyStyle.tx12Grey,
                          ),
                          const Spacer(),
                          Text(
                            "${Utils.naira}${formatNumber(num.parse(widget.amount))}",
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
                const SizedBox(
                  height: 50,
                ),
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
                      model.buyAirtime({
                        'network_name':
                            widget.selectedNetwork.network!.toLowerCase(),
                        'phone': widget.number,
                        'amount': widget.amount,
                      });
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
