import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick_bills/Provider/account_provider.dart';
import 'package:quick_bills/Provider/service_provider.dart';
import 'package:quick_bills/Ui/Dashboard/Buy/confirm_airtime_details.dart';
import 'package:quick_bills/Values/Helper/helper.dart';
import 'package:quick_bills/Values/MyColor.dart';
import 'package:quick_bills/Values/MyStyle.dart';
import 'package:quick_bills/Values/utils.dart';
import 'package:quick_bills/common/appbar.dart';
import 'package:quick_bills/common/button.dart';
import 'package:provider/provider.dart';

class CableSummaryScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  final bool saveDetails;
  const CableSummaryScreen({
    super.key,
    required this.data,
    required this.saveDetails,
  });

  @override
  State<CableSummaryScreen> createState() => _CableSummaryScreenState();
}

class _CableSummaryScreenState extends State<CableSummaryScreen> {
  num totalAmount = 0;
  @override
  void initState() {
    super.initState();
    totalAmount = num.parse(widget.data['amount']);
    setState(() {
      totalAmount += 100;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Cable Package Summary'),
      body: Consumer2<ServiceProvider, AccountProvider>(
          builder: (context, model, account, _) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 24, right: 24),
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
                        "${Utils.naira}${formatNumber(num.parse(totalAmount.toString()))}",
                        style: MyStyle.tx28Black,
                      ),
                    ),
                    SizedBox(width: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        widget.data['img'],
                        height: 85.r,
                        width: 85.r,
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
                  title: 'Package Name',
                  value: widget.data['name'],
                ),
                if (!widget.data['showmax'])
                  details(
                      title: 'Customer Name',
                      value: widget.data['cableMerchant']),
                details(title: 'Phone Number', value: widget.data['phone']),
                details(title: 'Smart Card Number', value: widget.data['card']),
                // details(
                //     title: 'Cable Merchant',
                //     value: widget.data['cableMerchant']),
                details(title: 'Convenience Fee', value: 'NGN 100'),
                details(title: 'Payment Method', value: 'Wallet'),
                details(
                    title: 'Amount',
                    value:
                        '${Utils.naira} ${formatNumber(num.parse(totalAmount.toString()))}'),
                Spacer(),
                CustomButton(
                  text: 'Confirm',
                  onTap: () {
                    Map<String, dynamic> data = {
                      "phone": widget.data['phone'],
                      'amount': totalAmount.toString(),
                      "service_id": widget.data['service_id'],
                      "card": widget.data['card'],
                      'code': widget.data['id'],
                      "price": widget.data['amount'],
                      "package": widget.data['package'],
                    };
                    model.buyCable(
                      data,
                      account: account,
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
