import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/auth_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Authentication/change_password.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Wallet/widget/profile_image.dart';
import 'package:jost_pay_wallet/Ui/Static/2fa.dart';
import 'package:jost_pay_wallet/Ui/Static/set_pin_login.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

import '../../Values/MyColor.dart';
import '../../bottom_nav.dart';

class Accountsetting extends StatefulWidget {
  const Accountsetting({super.key});

  @override
  State<Accountsetting> createState() => _AccountsettingState();
}

class _AccountsettingState extends State<Accountsetting> {
  bool _isSwitched = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final themeProvider =
            Provider.of<ThemeProvider>(context, listen: false);
        var accountProvider =
            Provider.of<AccountProvider>(context, listen: false);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (accountProvider.userModel == null) {
            accountProvider.getUserProfile();
          }
        });
        setState(() {
          _isSwitched = themeProvider.isDarkMode();
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      body: Consumer2<AccountProvider, AuthProvider>(
          builder: (context, model, auth, _) {
        log("Pin Enabled==> ${model.userModel?.user!.toJson()}");
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 68, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BottomNav())),
                    child: Image.asset(
                      'assets/images/arrow_left.png',
                      color: themeProvider.isDarkMode()
                          ? MyColor.mainWhiteColor
                          : MyColor.dark01Color,
                    ),
                  ), // Adds flexible space after the text
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Account Settings',
                style: MyStyle.tx18Black.copyWith(color: themedata.tertiary),
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 24, left: 24, bottom: 24),
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    boxShadow: const [MyStyle.widgetShadow],
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const ProfileImage(size: 60),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                    "${model.userModel?.user?.firstName?.capitalizeFirst ?? ""} ${model.userModel?.user?.lastName ?? ""}",
                                    style: MyStyle.tx22Green),
                                Text(
                                  model.userModel?.user?.email ?? "",
                                  style: MyStyle.tx12Black.copyWith(
                                    color: themeProvider.isDarkMode()
                                        ? const Color(0XFFCBD2EB)
                                        : const Color(0xff30333A),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                SizedBox(
                                  width: double
                                      .infinity, // Full width of the screen
                                  height: 4, // Adjust height as needed
                                  child: Stack(
                                    children: [
                                      // Bottom border
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: DottedBorder(
                                          color: themeProvider.isDarkMode()
                                              ? MyColor.borderDarkColor
                                              : MyColor.borderColor,
                                          strokeWidth: 1,
                                          dashPattern: const [
                                            6,
                                            3
                                          ], // Dash pattern: 6 units line, 3 units space
                                          customPath: (size) => Path()
                                            ..moveTo(0, 0)
                                            ..lineTo(size.width, 0),
                                          child: Container(
                                            height:
                                                0, // The container for the border can have a height of 0
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    // const SizedBox(
                    //   height: 12,
                    // ),
                    //  Row(
                    //   children: [
                    //     const SizedBox(
                    //       width: 90,
                    //     ),
                    //     const Text(
                    //       'Set 2FA authentication privacy',
                    //       style: MyStyle.tx12Grey,
                    //     ),
                    //     Image.asset(
                    //       'assets/images/arrow-right.png',
                    //       width: 16,
                    //       height: 16,
                    //     ),
                    //   ],
                    // )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: themeProvider.isDarkMode()
                            ? MyColor.borderDarkColor
                            : MyColor.borderColor,
                        width: 1),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/images/theme.png',
                            color: themeProvider.isDarkMode()
                                ? const Color(0XFFAAAAAA)
                                : MyColor.lightBlackColor),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          'Theme: ${_isSwitched ? 'Dark Mode' : 'Light mode'}',
                          style: MyStyle.tx14Black.copyWith(
                              color: themeProvider.isDarkMode()
                                  ? const Color(0XFFAAAAAA)
                                  : MyColor.lightBlackColor),
                        ),
                        const Spacer(),
                        Switch(
                          value: _isSwitched,
                          onChanged: (value) {
                            setState(() {
                              _isSwitched = value;
                              themeProvider.toggleTheme(
                                  themeProvider.isDarkMode() ? false : true);
                            });
                          },
                          activeColor: Colors.green,
                          inactiveThumbColor: Colors.white,
                          activeTrackColor: themedata.primary,
                          inactiveTrackColor: MyColor.switchGreyColor,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: themeProvider.isDarkMode()
                                      ? MyColor.borderDarkColor
                                      : MyColor.borderColor,
                                  width: 1))),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      children: [
                        Image.asset('assets/images/lock-password.png',
                            color: themeProvider.isDarkMode()
                                ? const Color(0XFFAAAAAA)
                                : MyColor.lightBlackColor),
                        const SizedBox(
                          width: 12,
                        ),

                        Text(
                          '2FA Authentication',
                          style: MyStyle.tx16LightBlack.copyWith(
                              color: themeProvider.isDarkMode()
                                  ? const Color(0XFFAAAAAA)
                                  : MyColor.lightBlackColor),
                        ),
                        const Spacer(),
                        Switch(
                          value: model.userModel?.user?.useGoogleAuth == "1"
                              ? true
                              : false,
                          onChanged: (value) {
                            if (model.userModel?.user?.useGoogleAuth == "1") {
                              model.toogle2Fa(
                                0,
                                showMessage: true,
                                account: context.read<AccountProvider>(),
                              );
                            } else {
                              model.toogle2Fa(1).then((val) {
                                if (val != null) {
                                  Get.to(TwoFAScreen());
                                }
                              });
                            }
                            // log("Switch value: ");
                          },
                          activeColor: Colors.green,
                          inactiveThumbColor: Colors.white,
                          activeTrackColor: themedata.primary,
                          inactiveTrackColor: MyColor.switchGreyColor,
                        ),
                        // Image.asset('assets/images/arrow-right.png',
                        //     color: themeProvider.isDarkMode()
                        //         ? const Color(0XFFAAAAAA)
                        //         : MyColor.lightBlackColor)
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => Get.to(SetPinLogin(
                        isUpdate: model.userModel!.user!.enabledPin == '1',
                      )),
                      child: Row(
                        children: [
                          // Image.asset('assets/images/lock-password.png',
                          //     color: themeProvider.isDarkMode()
                          //         ? const Color(0XFFAAAAAA)
                          //         : MyColor.lightBlackColor),
                          Icon(Iconsax.password_check,
                              color: themeProvider.isDarkMode()
                                  ? const Color(0XFFAAAAAA)
                                  : MyColor.lightBlackColor),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            model.userModel!.user!.enabledPin != '1'
                                ? 'Set Pin Login'
                                : "Change Pin Login",
                            style: MyStyle.tx16LightBlack.copyWith(
                                color: themeProvider.isDarkMode()
                                    ? const Color(0XFFAAAAAA)
                                    : MyColor.lightBlackColor),
                          ),
                          const Spacer(),
                          Image.asset('assets/images/arrow-right.png',
                              color: themeProvider.isDarkMode()
                                  ? const Color(0XFFAAAAAA)
                                  : MyColor.lightBlackColor)
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    GestureDetector(
                      onTap: () => Get.to(ChangePassword()),
                      child: Row(
                        children: [
                          Icon(Iconsax.key_square,
                              color: themeProvider.isDarkMode()
                                  ? const Color(0XFFAAAAAA)
                                  : MyColor.lightBlackColor),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            'Change My password',
                            style: MyStyle.tx16LightBlack.copyWith(
                                color: themeProvider.isDarkMode()
                                    ? const Color(0XFFAAAAAA)
                                    : MyColor.lightBlackColor),
                          ),
                          const Spacer(),
                          Image.asset('assets/images/arrow-right.png',
                              color: themeProvider.isDarkMode()
                                  ? const Color(0XFFAAAAAA)
                                  : MyColor.lightBlackColor)
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.dialog(
                          AlertDialog(
                            title: const Text('Delete Account'),
                            content: const Text(
                                'Are you sure you want to delete your account?'),
                            actions: [
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      MyColor.greenColor.withValues(alpha: .5),
                                ),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: MyColor.whiteColor,
                                  ),
                                ),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      MyColor.redColor.withValues(alpha: .5),
                                ),
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(
                                    color: MyColor.whiteColor,
                                  ),
                                ),
                                onPressed: () {
                                  auth.deActivateAccount();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(Iconsax.trash, color: MyColor.redColor),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            'Delete My Account',
                            style: MyStyle.tx16LightBlack.copyWith(
                              color: MyColor.redColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // const SizedBox(
                    //   height: 24,
                    // ),
                    // Row(
                    //   children: [
                    //     Image.asset('assets/images/notification-01.png',
                    //         color: themeProvider.isDarkMode()
                    //             ? const Color(0XFFAAAAAA)
                    //             : MyColor.lightBlackColor),
                    //     const SizedBox(
                    //       width: 12,
                    //     ),
                    //     Text(
                    //       'Notification settings',
                    //       style: MyStyle.tx16LightBlack.copyWith(
                    //           color: themeProvider.isDarkMode()
                    //               ? const Color(0XFFAAAAAA)
                    //               : MyColor.lightBlackColor),
                    //     ),
                    //     const Spacer(),
                    //     Image.asset('assets/images/arrow-right.png',
                    //         color: themeProvider.isDarkMode()
                    //             ? const Color(0XFFAAAAAA)
                    //             : MyColor.lightBlackColor)
                    //   ],
                    // ),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
