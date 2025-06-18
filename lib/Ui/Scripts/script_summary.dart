import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/service_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/NewColor.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:jost_pay_wallet/Values/utils.dart';
import 'package:jost_pay_wallet/utils/toast.dart';
import 'package:provider/provider.dart';

class BuyScriptSummary extends StatefulWidget {
  final Map<String, dynamic> data;

  const BuyScriptSummary({
    super.key,
    required this.data,
  });

  @override
  State<BuyScriptSummary> createState() => _BuyScriptSummaryState();
}

class _BuyScriptSummaryState extends State<BuyScriptSummary> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Consumer2<AccountProvider, ServiceProvider>(
          builder: (context, model, service, _) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 24, right: 24),
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
                        'Script Summary',
                        style: MyStyle.tx18Black.copyWith(
                          color: themedata.tertiary,
                        ),
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
                      boxShadow: const [MyStyle.widgetShadow],
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: widget.data['image'],
                          height: 68,
                          width: 86,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Script Summary',
                        style: MyStyle.tx14Black.copyWith(
                            color: themedata.tertiary, fontFamily: 'Roboto'),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Title',
                            style: MyStyle.tx12Grey,
                          ),
                          const Spacer(),
                          Text(
                            widget.data['title'],
                            style: MyStyle.tx12Black.copyWith(
                                color: themedata.tertiary,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'SF Pro Rounded'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Category',
                            style: MyStyle.tx12Grey,
                          ),
                          const Spacer(),
                          Text(
                            widget.data['category'],
                            style: MyStyle.tx12Black.copyWith(
                                color: themedata.tertiary,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'SF Pro Rounded'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Balance',
                            style: MyStyle.tx12Grey,
                          ),
                          const Spacer(),
                          Text(
                            '${Utils.naira} ${formatNumber(model.balance!)}',
                            style: MyStyle.tx12Black.copyWith(
                                fontWeight: FontWeight.w600,
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
                            'Amount',
                            style: MyStyle.tx12Grey,
                          ),
                          const Spacer(),
                          Text(
                            '${Utils.naira} ${formatNumber(num.parse(widget.data['price']))}',
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
                      if (num.parse(widget.data['price']) > model.balance!) {
                        ErrorToast('Insufficient balance');
                      } else {
                        service.buyScript(widget.data['id']);
                      }
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
