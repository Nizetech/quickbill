import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/kyc/widget/info_wrap.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

class VirtualNumber extends StatelessWidget {
  const VirtualNumber({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    final account = Provider.of<AccountProvider>(context, listen: true);
    return Column(
      children: [
        InfoWrap2(
          child: Text(
            'Fund your JostPay wallet by transferring to the account balance. Confirmed in minutes.',
            style: MyStyle.tx12Black.copyWith(color: themedata.tertiary),
          ),
        ),
        const SizedBox(height: 10),
        Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 20),
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
                    CircleAvatar(
                      radius: 20,
                      backgroundColor:
                          MyColor.greenColor.withValues(alpha: 0.1),
                      child: Image.asset(
                        'assets/images/bank_i.png',
                        width: 20.7,
                        height: 20.7,
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bank Name',
                          style: MyStyle.tx28Black.copyWith(
                            fontSize: 12,
                            color: themedata.tertiary,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'Fidelity',
                          style: MyStyle.tx28Black.copyWith(
                              fontSize: 14, color: themedata.tertiary),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    CircleAvatar(
                        radius: 16.3,
                        backgroundColor:
                            MyColor.greenColor.withValues(alpha: 0.1),
                        child: Icon(
                          Icons.account_balance_wallet_outlined,
                          color: MyColor.greenColor,
                          size: 20,
                        )),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Account Number',
                          style: MyStyle.tx28Black.copyWith(
                            fontSize: 12,
                            color: themedata.tertiary,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              account.userModel?.user?.virtualAccount ?? '',
                              style: MyStyle.tx28Black.copyWith(
                                  fontSize: 14, color: themedata.tertiary),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Clipboard.setData(ClipboardData(
                                    text: account
                                            .userModel?.user?.virtualAccount ??
                                        ''));
                                Fluttertoast.showToast(
                                    msg: "Copied to clipboard");
                              },
                              child: SvgPicture.asset(
                                'assets/images/copy.svg',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )),
      ],
    );
  }
}
