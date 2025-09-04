import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Wallet/virtual_account_creation.dart';
import 'package:jost_pay_wallet/Ui/kyc/widget/info_wrap.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:jost_pay_wallet/common/glass_wrap.dart';
import 'package:jost_pay_wallet/utils/toast.dart';
import 'package:provider/provider.dart';

class ActivateVirtualAccount extends StatelessWidget {
  const ActivateVirtualAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Consumer<AccountProvider>(builder: (context, model, _) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            InfoWrap2(
              child: Text(
                'Fund your JostPay wallet by transferring to the account balance. Confirmed in minutes.',
                style: MyStyle.tx12Black.copyWith(color: themedata.tertiary),
              ),
            ),
            const SizedBox(height: 10),
            GlassWrap(
              radius: 13,
              blur: 5,
              height: 114,
              bgImage: themeProvider.isDarkMode()
                  ? 'assets/images/dk_bg.png'
                  : 'assets/images/li_bg.png',
              child: Container(
                  height: 114,
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: themedata.tertiary.withValues(alpha: 0.08),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Activate your personal virtual account\n for faster deposits',
                          textAlign: TextAlign.center,
                          style: MyStyle.tx12Black.copyWith(
                            // fontSize: 14,
                            color: themedata.tertiary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 30,
                        width: Get.width * 0.5,
                        child: CustomButton(
                          onTap: () {
                            if (model.userModel?.user?.idVerified == false) {
                              ErrorToast(
                                  'You need to verify your account to create a virtual account');
                              return;
                            } else {
                              Get.to(const VirtualAccountCreation());
                            }
                          },
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          radius: 60,
                          text: 'Activate Virtual Account',
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      );
    }
    );
  }
}
