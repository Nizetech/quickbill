import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Deposit.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Wallet/kyc_web.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

class BalanceCard extends StatelessWidget {
  final bool hasAddFund;
  const BalanceCard({
    super.key,
    this.hasAddFund = false,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Consumer<AccountProvider>(builder: (context, account, _) {
      return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: !themeProvider.isDarkMode()
                  ? Color(0xfffCFCFC)
                  : Color(0xff171717),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: themeProvider.isDarkMode()
                      ? MyColor.borderDarkColor
                      : MyColor.borderColor,
                  width: 0.5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/flag.svg',
                    width: 32.7,
                    height: 32.7,
                  ),
                  const Spacer(),
                  Text(
                    'NGN',
                    style: MyStyle.tx28Black
                        .copyWith(fontSize: 12, color: themedata.tertiary),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text('₦ ${formatNumber(account.balance ?? 0)}',
                  style: MyStyle.tx18Black
                      .copyWith(fontSize: 12.3.sp, color: themedata.tertiary)),
              if (hasAddFund)
                GestureDetector(
                  onTap: () {
                    if (account.userModel?.user?.createdAt != null &&
                        account.userModel?.user?.isActive == false) {
                      Get.to(() => const KycWebview());
                    } else {
                      Get.to(Deposit());
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'Add Funds',
                      style: MyStyle.tx14White.copyWith(
                          color: MyColor.greenColor,
                          decoration: TextDecoration.underline,
                          decorationColor: MyColor.greenColor,
                          decorationThickness: 1.0),
                    ),
                  ),
                )
            ],
          ));
    
    });
  }
}
