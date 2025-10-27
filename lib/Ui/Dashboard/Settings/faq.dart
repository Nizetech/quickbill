import 'package:flutter/material.dart';
import 'package:quick_bills/Values/MyColor.dart';
import 'package:quick_bills/Values/MyStyle.dart';
import 'package:quick_bills/common/appbar.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'FAQ'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FaqTile(
              title:
                  'What should I do if a payment is delayed or not delivered?',
              answer:
                  "QuickBills is built to handle transactions via your connected API. If a payment is delayed or fails, the system logs the transaction and can automatically retry or flag it for admin review. Most times, it's from the service provider. You can also enable manual reversal or resolution in your admin panel.",
            ),
            FaqTile(
              title: 'How are wallet balances managed?',
              answer:
                  "QuickBills is built to handle transactions via your connected API. If a payment is delayed or fails, the system logs the transaction and can automatically retry or flag it for admin review. Most times, it's from the service provider. You can also enable manual reversal or resolution in your admin panel.",
            ),
            FaqTile(
              title: 'Can users request refunds for failed services?',
              answer:
                  "QuickBills is built to handle transactions via your connected API. If a payment is delayed or fails, the system logs the transaction and can automatically retry or flag it for admin review. Most times, it's from the service provider. You can also enable manual reversal or resolution in your admin panel.",
            ),
            FaqTile(
              title: 'What payment methods are supported?',
              answer:
                  "QuickBills is built to handle transactions via your connected API. If a payment is delayed or fails, the system logs the transaction and can automatically retry or flag it for admin review. Most times, it's from the service provider. You can also enable manual reversal or resolution in your admin panel.",
            ),
            FaqTile(
              title: 'Can I connect multiple APIs?',
              answer:
                  "QuickBills is built to handle transactions via your connected API. If a payment is delayed or fails, the system logs the transaction and can automatically retry or flag it for admin review. Most times, it's from the service provider. You can also enable manual reversal or resolution in your admin panel.",
            ),
          ],
        ),
      ),
    );
  }
}

class FaqTile extends StatefulWidget {
  final String title;
  final String answer;
  const FaqTile({super.key, required this.title, required this.answer});

  @override
  State<FaqTile> createState() => _FaqTileState();
}

class _FaqTileState extends State<FaqTile> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
          childrenPadding: const EdgeInsets.symmetric(horizontal: 16),
          onExpansionChanged: (value) {
            setState(() {
              isExpanded = value;
            });
          },
          trailing: Icon(
            isExpanded ? Icons.remove : Icons.add,
            color: MyColor.blackColor,
          ),
          title: Text(
            widget.title,
            style: MyStyle.tx16Black,
          ),
          children: [
            Text(
              widget.answer,
              style: MyStyle.tx14Black.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
          ]),
    );
  }
}
