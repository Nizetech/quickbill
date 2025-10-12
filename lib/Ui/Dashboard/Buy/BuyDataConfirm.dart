
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Models/data_plans_model.dart';
import 'package:jost_pay_wallet/Models/network_provider.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Buy/confirm_airtime_details.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/NewColor.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:jost_pay_wallet/Values/utils.dart';
import 'package:jost_pay_wallet/common/appbar.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:provider/provider.dart';

class BuyDataConfirm extends StatefulWidget {
  final Network network;
  final String phone;
  final Plan plan;
final bool saveDetails;
  const BuyDataConfirm(
      {super.key,
      required this.network,
      required this.phone,
      required this.plan,
      required this.saveDetails});

  @override
  State<BuyDataConfirm> createState() => _BuyDataConfirmState();
}

class _BuyDataConfirmState extends State<BuyDataConfirm> {


  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: appBar(title: 'Purchase Data'),
      body: Consumer<AccountProvider>(builder: (context, model, _) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 24, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Review & Pay',
                  style: MyStyle.tx14Black.copyWith(
                    color: MyColor.grey,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "${Utils.naira}${formatNumber(num.parse(widget.plan.price.toString()))}",
                        style: MyStyle.tx28Black,
                      ),
                    ),
                    SizedBox(width: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: widget.network.logo ?? "",
                        height: 68,
                        width: 86,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Text(
                  'Bill payment breakdown',
                  style: MyStyle.tx14Black.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Divider(
                  color: MyColor.borderColor,
                  thickness: 1,
                ),
                details(
                    title: 'Network Provider', value: widget.network.network!),
                details(
                    title: 'Data Plan',
                    value: widget.plan.name!.split('-').first),
                details(title: 'Phone Number', value: widget.phone),
                details(
                    title: 'Amount',
                    value: '${Utils.naira} ${widget.plan.price}'),
                details(title: 'Payment Method', value: 'Wallet'),
                Spacer(),
                CustomButton(
                  text: 'Confirm',
                  onTap: () {
                    model.buyData(
                      {
                        "network_name": widget.network.network!.toLowerCase(),
                        "phone": widget.phone,
                        "data_type": "SME",
                        "plan_id": widget.plan.planId,
                        'details': widget.saveDetails ? 1 : 0,
                      },
                      amount: widget.plan.price.toString(),
                      plan: widget.plan.name!,
                    );
                  },
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
                      '${Utils.naira} ${widget.plan.price}',
                      style: MyStyle.tx14Black.copyWith(
                          fontWeight: FontWeight.w600,
                          color: themedata.tertiary,
                          fontFamily: 'SF Pro Rounded'),
                    ),
                  ],
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
                      model.buyData({
                        "network_name": widget.network.network!.toLowerCase(),
                        "phone": widget.phone,
                        "data_type": "SME",
                        "plan_id": widget.plan.planId,
                          'details': widget.saveDetails ? 1 : 0,
                        },
                        amount: widget.plan.price.toString(),
                        plan: widget.plan.name!,
                      );
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
     
      }
      ),
    );
  }
}
