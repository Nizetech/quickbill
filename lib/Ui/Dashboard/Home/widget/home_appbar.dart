import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quick_bills/Provider/account_provider.dart';
import 'package:quick_bills/Provider/theme_provider.dart';
import 'package:quick_bills/Ui/Dashboard/notification.dart';
import 'package:quick_bills/Ui/Dashboard/Home/widget/profile_image.dart';
import 'package:quick_bills/Ui/settings/setting_screen.dart';
import 'package:quick_bills/Values/MyColor.dart';
import 'package:quick_bills/Values/MyStyle.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final accountProvider = Provider.of<AccountProvider>(context, listen: true);
    final model = Provider.of<AccountProvider>(context, listen: true);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Get.to(const SettingScreen()),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const ProfileImage(size: 40),
              const SizedBox(
                width: 8,
              ),
              Text(
                "Hi, ${model.userModel?.user?.firstName?.capitalizeFirst ?? ''}",
                style: MyStyle.tx16Black.copyWith(
                  color: MyColor.blackColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) => const NotificationScreen()));
          },
          child: Stack(
            children: [
              Icon(
                Iconsax.notification,
                color: themeProvider.isDarkMode()
                    ? MyColor.mainWhiteColor
                    : MyColor.dark01Color,
              ),
              if (accountProvider.notificationModel != null &&
                  accountProvider.notificationModel!.notifications!.isNotEmpty)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 15,
                    height: 15,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: MyColor.redColor,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${accountProvider.notificationModel!.notifications?.length}',
                      style: MyStyle.tx12Black.copyWith(
                          color: MyColor.mainWhiteColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 10),
                    ),
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }
}
