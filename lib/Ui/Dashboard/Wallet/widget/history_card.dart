import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Models/transactions.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

class HistoryCard extends StatelessWidget {
  final Transaction transaction;
  const HistoryCard({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context).colorScheme;
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    return ListTile(
      minVerticalPadding: 0,
      contentPadding: EdgeInsets.zero,
      leading: Container(
        height: 41.r,
        width: 41.r,
        padding: EdgeInsets.all(6.r),
        decoration: BoxDecoration(
            color: themeProvider.isDarkMode()
                ? const Color(0XFF171717)
                : const Color(0XFFF4F5F6),
            shape: BoxShape.circle),
        child: SvgPicture.asset('assets/images/svg/money.svg'),
      ),
      title: Text(
        transaction.type!.capitalizeFirst!,
        style: MyStyle.tx14Grey.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 12.sp,
            color: themeProvider.isDarkMode()
                ? const Color(0XFFCBD2EB)
                : const Color(0xff30333A)),
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '₦${formatNumber(num.parse(transaction.amount!))}',
            style: MyStyle.tx14Grey.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
                color: themeProvider.isDarkMode()
                    ? const Color(0XFFCBD2EB)
                    : const Color(0xff30333A)),
          ),
          Text(
            transaction.status == 'success' || transaction.status == '1'
                ? 'Successful'
                : transaction.status == 'pending'
                    ? 'Pending'
                    : 'Failed',
            style: MyStyle.tx14Grey.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 11.sp,
                color:
                    transaction.status == 'success' || transaction.status == '1'
                        ? const Color(0XFF027A48)
                        : const Color(0XFFEA4D2D)),
          ),
        ],
      ),
      subtitle: Text(
        formatDateTime(transaction.transDate!),
        style: MyStyle.tx14Grey.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 12.sp,
            color: themeProvider.isDarkMode()
                ? const Color(0XFFCBD2EB)
                : const Color(0xff30333A)),
      ),
    );
  }
}
