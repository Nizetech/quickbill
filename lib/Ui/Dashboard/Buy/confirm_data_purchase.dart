import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Models/data_plans_model.dart';
import 'package:jost_pay_wallet/Models/network_provider.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Buy/confirm_airtime_details.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/utils.dart';
import 'package:jost_pay_wallet/common/appbar.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:provider/provider.dart';

class ConfirmDataPurchase extends StatefulWidget {
  final Network network;
  final String phone;
  final Plan plan;
  final bool saveDetails;
  const ConfirmDataPurchase(
      {super.key,
      required this.network,
      required this.phone,
      required this.plan,
      required this.saveDetails});

  @override
  State<ConfirmDataPurchase> createState() => _ConfirmDataPurchaseState();
}

class _ConfirmDataPurchaseState extends State<ConfirmDataPurchase> {
  @override
  Widget build(BuildContext context) {
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
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      }),
    );
  }
}
