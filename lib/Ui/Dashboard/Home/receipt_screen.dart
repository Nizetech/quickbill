import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quick_bills/Provider/service_provider.dart';
import 'package:quick_bills/Values/Helper/helper.dart';
import 'package:quick_bills/Values/MyColor.dart';
import 'package:quick_bills/Values/MyStyle.dart';
import 'package:quick_bills/Values/utils.dart';
import 'package:quick_bills/common/appbar.dart';
import 'package:quick_bills/common/button.dart';
import 'package:provider/provider.dart';

class ReceiptScreen extends StatefulWidget {
  final String referenceNo, date, serviceDetails, amount, status;
  final bool isElectricity, isCable, isRefunded, isDeposit;

  final String? description;
  const ReceiptScreen({
    super.key,
    this.description,
    required this.status,
    required this.referenceNo,
    required this.date,
    required this.serviceDetails,
    required this.amount,
    this.isElectricity = false,
    this.isCable = false,
    this.isRefunded = false,
    this.isDeposit = false,
  });

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Transaction Details'),
      body: Consumer<ServiceProvider>(builder: (context, model, child) {
       
        return SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: MyColor.secondaryColor.withValues(alpha: .5),
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: 25,
                backgroundColor: MyColor.primaryGreen,
                child: Icon(Icons.check, color: MyColor.whiteColor),
              ),
            ),
            SizedBox(height: 20),
            Text(
                widget.isRefunded
                    ? "Refund Completed!"
                    : widget.isDeposit
                        ? "Deposit Completed!"
                        : "Transaction Completed!",
                style: MyStyle.tx18Grey.copyWith(
                  fontWeight: FontWeight.w400,
                  color: MyColor.grey,
                )),
            SizedBox(height: 10),
            Text(
              Utils.naira + formatNumber(num.parse(widget.amount)),
              textAlign: TextAlign.end,
              style: MyStyle.tx18Black.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: MyColor.blackColor,
              ),
            ),
            SizedBox(height: 15),
            Container(
              width: Get.width * 0.7,
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: MyColor.secondaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text("Thank you for using Quickbills.",
                      style: MyStyle.tx12Grey.copyWith(
                        fontWeight: FontWeight.w400,
                        color: MyColor.primaryGreen,
                      )),
                ],
              ),
            ),
            SizedBox(height: 15),
            Divider(
              color: MyColor.borderColor.withValues(alpha: .5),
              thickness: 1,
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Transaction Number",
                  style: MyStyle.tx14Grey,
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Text(widget.referenceNo,
                      textAlign: TextAlign.end,
                      style: MyStyle.tx18Black.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      )),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Description",
                  style: MyStyle.tx14Grey,
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Text(
                    widget.description!,
                      textAlign: TextAlign.end,
                      style: MyStyle.tx18Black.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      )),
                ),
              ],
            ),
            SizedBox(height: 15),
            Divider(
              color: MyColor.borderColor.withValues(alpha: .5),
              thickness: 1,
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Transaction Date",
                  style: MyStyle.tx14Grey,
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Text(
                      DateFormat('dd-MM-yyyy. hh:mm a')
                          .format(DateTime.parse(widget.date)),
                      textAlign: TextAlign.end,
                      style: MyStyle.tx18Black.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      )),
                ),
              ],
            ),
            SizedBox(height: 50),
            Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                text:
                    "Do you need help with this transaction?\n Reach out via our ",
                style: MyStyle.tx14Grey.copyWith(
                  fontSize: 15,
                ),
                children: [
                  TextSpan(
                    text: "support channel.",
                    style: MyStyle.tx14Grey.copyWith(
                      fontSize: 15,
                      color: MyColor.primaryColor,
                      decoration: TextDecoration.underline,
                      decorationColor: MyColor.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            CustomButton(
              radius: 50,
              text: 'Go back',
              onTap: () {
                Navigator.pop(context);
              },
            )
          ]),
        );
      }),
    );
  }
}
