import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:quick_bills/Models/network_provider.dart';
import 'package:quick_bills/Provider/account_provider.dart';
import 'package:quick_bills/Values/Helper/helper.dart';
import 'package:quick_bills/Values/MyColor.dart';
import 'package:quick_bills/Values/MyStyle.dart';
import 'package:quick_bills/Values/utils.dart';
import 'package:quick_bills/common/appbar.dart';
import 'package:quick_bills/common/button.dart';
import 'package:provider/provider.dart';

class ConfirmAirtimeDetails extends StatefulWidget {
  final Network selectedNetwork;
  final String amount;
  final String number;
  final bool saveDetails;
  const ConfirmAirtimeDetails({
    super.key,
    required this.selectedNetwork,
    required this.amount,
    required this.number,
    required this.saveDetails,
  });

  @override
  State<ConfirmAirtimeDetails> createState() => _ConfirmAirtimeDetailsState();
}

class _ConfirmAirtimeDetailsState extends State<ConfirmAirtimeDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Purchase Airtime'),
      body: Consumer<AccountProvider>(builder: (context, model, _) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 14, left: 24, right: 24),
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
                        "${Utils.naira}${formatNumber(num.parse(widget.amount))}",
                        style: MyStyle.tx28Black,
                      ),
                    ),
                    SizedBox(width: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: widget.selectedNetwork.logo ?? "",
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
                    title: 'Airtime Provider',
                    value: widget.selectedNetwork.network!),
                details(title: 'Phone Number', value: widget.number),
                details(
                  title: 'Amount',
                  value: "${Utils.naira}${formatNumber(
                    num.parse(widget.amount),
                  )}",
                ),
                details(title: 'Payment Method', value: 'Wallet'),
                Spacer(),
                CustomButton(
                    text: 'Confirm',
                    onTap: () {
                      model.buyAirtime({
                        // 'network_name':
                        //     widget.selectedNetwork.network!.toLowerCase(),
                        'phone': widget.number,
                        'amount': widget.amount,
                        // 'details': widget.saveDetails ? 1 : 0,
                        'network_id':
                            widget.selectedNetwork.networkId.toString(),
                      });
                    }),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      }),
    );
  }
}

Widget details({required String title, required String value}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: MyStyle.tx12Grey,
        ),
        Text(
          value,
          style: MyStyle.tx12Black.copyWith(
            fontWeight: FontWeight.w500,
            color: MyColor.grey03Color,
          ),
        ),
      ],
    ),
  );
}
