import 'package:flutter/material.dart';
import 'package:quick_bills/Provider/account_provider.dart';
import 'package:quick_bills/Values/Helper/helper.dart';
import 'package:quick_bills/Values/MyColor.dart';
import 'package:quick_bills/Values/MyStyle.dart';
import 'package:provider/provider.dart';

class AmountChip extends StatelessWidget {
  const AmountChip({super.key});

  @override
  Widget build(BuildContext context) {
    final account = context.watch<AccountProvider>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: MyColor.grey01Color,
        border: Border.all(color: MyColor.borderColor),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        'Bal:₦ ${formatNumber(account.balance ?? 0)}',
        style: MyStyle.tx14Black.copyWith(
          fontWeight: FontWeight.w400,
          color: MyColor.greenColor,
        ),
      ),
    );
  }
}
