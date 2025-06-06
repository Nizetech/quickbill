import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

class BalanceActionCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const BalanceActionCard(
      {super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    final model = context.watch<AccountProvider>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      decoration: BoxDecoration(
          border: Border.all(
            width: 0.8,
            color: themeProvider.isDarkMode()
                ? MyColor.borderDarkColor
                : MyColor.borderColor,
          ),
          borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Total balance',
                  style: MyStyle.tx12Grey,
                ),
                Text(
                  '₦ ${formatNumber(model.balance ?? 0)}',
                  style: MyStyle.tx32Black.copyWith(
                    color: themedata.tertiary,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                SizedBox(width: 20),
              ],
            ),
          ),
          TextButton(
            onPressed: onTap,
            style: TextButton.styleFrom(
              backgroundColor: MyColor.greenColor,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: MyStyle.tx12White,
                ),
                SizedBox(width: 5),
                Icon(Icons.arrow_forward_ios_rounded,
                    color: MyColor.mainWhiteColor)
              ],
            ),
          )
        ],
      ),
    );
  }
}
