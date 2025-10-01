import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/giftCard/widget/verification_prompt.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

class ServiceTile extends StatelessWidget {
  final Widget page;
  final String icon, title;
  final bool isTransform;
  final bool isGiftCard;
  const ServiceTile({
    super.key,
    required this.page,
    required this.icon,
    this.isTransform = false,
    required this.title,
    this.isGiftCard = false,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final model = Provider.of<AccountProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return InkWell(
      onTap: isGiftCard && model.userModel?.user?.idVerified == false
          ? () {
              showVerificationPrompt();
            }
          : () => Get.to(page),
      child: Container(
        width: 155,
        height: 110,
        decoration: BoxDecoration(
            color: themedata.secondaryContainer,
            borderRadius: BorderRadius.circular(13.5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 12,
            ),
            CircleAvatar(
              radius: 20,
              backgroundColor: !themeProvider.isDarkMode()
                  ? MyColor.mainWhiteColor
                  : MyColor.dark01Color,
              child: Transform.translate(
                offset: Offset(0, isTransform ? 5 : 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: SvgPicture.asset(
                    icon,
                    height: 24,
                    width: 24,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              title,
              style: MyStyle.tx9Green.copyWith(
                color: MyColor.greenColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
