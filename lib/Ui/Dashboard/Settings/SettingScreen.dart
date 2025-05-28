import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/DashboardProvider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Authentication/SignInScreen.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/HelpSupport.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Settings/ProfileScreen.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Settings/Rewards/reward_screen.dart';
import 'package:jost_pay_wallet/Ui/Static/AccountSetting.dart';
import 'package:jost_pay_wallet/Ui/Support/about_scren.dart';
import 'package:jost_pay_wallet/Ui/Support/privacy_screen.dart';
import 'package:jost_pay_wallet/Ui/Support/terms_screen.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/utils.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    super.initState();
    var accountProvider = Provider.of<AccountProvider>(context, listen: false);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (accountProvider.userModel == null) {
        accountProvider.getUserProfile();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    final dashProvider = Provider.of<DashboardProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Consumer<AccountProvider>(builder: (context, model, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 68),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => dashProvider.changeBottomIndex(0),
                    child: Image.asset(
                      'assets/images/arrow_left.png',
                      color: themeProvider.isDarkMode()
                          ? MyColor.mainWhiteColor
                          : MyColor.dark01Color,
                    ),
                  ),
                  const Spacer(),
                  Transform.translate(
                    offset: const Offset(-20, 0),
                    child: Text(
                      'Profile',
                      style:
                          MyStyle.tx18Black.copyWith(color: themedata.tertiary),
                    ),
                  ),
                  const Spacer(), // Adds flexible space after the text
                ],
              ),
              const SizedBox(height: 30),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    'assets/images/avatar.jpeg',
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: Text(
                  "${model.userModel?.user?.firstName?.capitalizeFirst ?? ""} ${model.userModel?.user?.lastName ?? ""}",
                  style: MyStyle.tx18Black.copyWith(color: themedata.tertiary),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Center(
                child: Text(
                  model.userModel?.user?.email ?? "",
                  style: MyStyle.tx12Black.copyWith(
                      color: themeProvider.isDarkMode()
                          ? const Color(0XFFCBD2EB)
                          : const Color(0xff30333A)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfileScreen(),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              child: Image.asset(
                                "assets/images/user-edit-01.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text("Edit Information",
                                style: MyStyle.tx14Black.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: themeProvider.isDarkMode()
                                      ? const Color(0XFFCBD2EB)
                                      : const Color(0xff30333A),
                                )),
                            const Spacer(),
                            Image.asset(
                              "assets/images/right.png",
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    Container(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RewardScreen(),
                              ));
                        },
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              child: Image.asset(
                                "assets/images/gift.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text("Referral Code",
                                style: MyStyle.tx14Black.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: themeProvider.isDarkMode()
                                      ? const Color(0XFFCBD2EB)
                                      : const Color(0xff30333A),
                                )),
                            const Spacer(),
                            Image.asset(
                              "assets/images/right.png",
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                        height: 0.5,
                        decoration:
                            const BoxDecoration(color: Color(0xFFF3F4F6))),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: InkWell(
                        onTap: () {
                          dashProvider.changeBottomIndex(5);
                        },
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              child: Image.asset(
                                "assets/images/google-doc.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text("Terms",
                                style: MyStyle.tx14Black.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: themeProvider.isDarkMode()
                                      ? const Color(0XFFCBD2EB)
                                      : const Color(0xff30333A),
                                )),
                            const Spacer(),
                            Image.asset(
                              "assets/images/right.png",
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 8,
                    // ),
                    Container(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: InkWell(
                        onTap: () => dashProvider.changeBottomIndex(6),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              child: Image.asset(
                                "assets/images/document-attachment.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text("Privacy",
                                style: MyStyle.tx14Black.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: themeProvider.isDarkMode()
                                      ? const Color(0XFFCBD2EB)
                                      : const Color(0xff30333A),
                                )),
                            const Spacer(),
                            Image.asset(
                              "assets/images/right.png",
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 8,
                    // ),
                    Container(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Accountsetting(),
                              ));
                        },
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              child: Image.asset(
                                "assets/images/settings-02.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text("Settings",
                                style: MyStyle.tx14Black.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: themeProvider.isDarkMode()
                                      ? const Color(0XFFCBD2EB)
                                      : const Color(0xff30333A),
                                )),
                            const Spacer(),
                            Image.asset(
                              "assets/images/right.png",
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                        height: 0.5,
                        decoration:
                            const BoxDecoration(color: Color(0xFFF3F4F6))),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: InkWell(
                        onTap: () => dashProvider.changeBottomIndex(7),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              child: Image.asset(
                                "assets/images/help-square.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text("About Us",
                                style: MyStyle.tx14Black.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: themeProvider.isDarkMode()
                                      ? const Color(0XFFCBD2EB)
                                      : const Color(0xff30333A),
                                )),
                            const Spacer(),
                            Image.asset(
                              "assets/images/right.png",
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 8,
                    // ),
                    Container(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Helpsupport(),
                              ));
                        },
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              child: Image.asset(
                                "assets/images/message-question.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text("Help & Support",
                                style: MyStyle.tx14Black.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: themeProvider.isDarkMode()
                                      ? const Color(0XFFCBD2EB)
                                      : const Color(0xff30333A),
                                )),
                            const Spacer(),
                            Image.asset(
                              "assets/images/right.png",
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 8,
                    // ),
                    Container(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignInScreen(),
                              ));
                        },
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              child: Image.asset(
                                "assets/images/logout-05.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text("Sign out",
                                style: MyStyle.tx14Black.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red,
                                )),
                            const Spacer(),
                            Image.asset(
                              "assets/images/right.png",
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ))
            ],
          ),
        );
      }),
    );
  }
}
