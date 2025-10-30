import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quick_bills/Provider/account_provider.dart';
import 'package:quick_bills/Provider/dashboard_provider.dart';
import 'package:quick_bills/Provider/auth_provider.dart';
import 'package:quick_bills/Ui/authentication/signIn_screen.dart';
import 'package:quick_bills/Ui/authentication/change_password.dart';
import 'package:quick_bills/Ui/Dashboard/Home/widget/profile_image.dart';
import 'package:quick_bills/Ui/Settings/edit_profile.dart';
import 'package:quick_bills/Ui/Settings/support.dart';
import 'package:quick_bills/Values/MyColor.dart';
import 'package:quick_bills/Values/MyStyle.dart';
import 'package:quick_bills/common/appbar.dart';
import 'package:quick_bills/common/button.dart';
import 'package:quick_bills/constants/constants.dart';
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

  final box = Hive.box(kAppName);

  @override
  Widget build(BuildContext context) {
    final dashProvider = Provider.of<DashboardProvider>(context, listen: true);
    return Scaffold(
      appBar: appBar(title: 'My Profile'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Consumer2<AccountProvider, AuthProvider>(
          builder: (context, model, auth, _) {
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ProfileImage(size: 60),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${model.userModel?.user?.firstName?.capitalizeFirst ?? ""} ${model.userModel?.user?.lastName ?? ""}",
                              style: MyStyle.tx18Black
                                  .copyWith(color: MyColor.blackColor),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              model.userModel?.user?.phoneNumber ?? "",
                              style: MyStyle.tx12Black.copyWith(
                                fontSize: 14,
                                color: MyColor.blackColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Text(
                      "General",
                      style: MyStyle.tx16Black.copyWith(
                        fontWeight: FontWeight.w500,
                        color: MyColor.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    buildInfoCard(
                      image: "assets/images/profile.svg",
                      onTap: () {
                        Get.to(() => const EditProfileScreen());
                      },
                      title: "Update profile",
                    ),
                    Container(
                        height: 0.5,
                        decoration:
                            const BoxDecoration(color: Color(0xFFF3F4F6))),
                    const SizedBox(height: 16),
                    buildInfoCard(
                      image: "assets/images/lock.svg",
                      onTap: () => Get.to(() => const ChangePassword()),
                      title: "Change Password",
                    ),
                    const SizedBox(height: 16),
                    buildInfoCard(
                      image: "assets/images/support.svg",
                      onTap: () => Get.to(() => const SupportScreen()),
                      title: "Support",
                    ),
                    const SizedBox(height: 25),
                    Text(
                      "Legal",
                      style: MyStyle.tx16Black.copyWith(
                        fontWeight: FontWeight.w500,
                        color: MyColor.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    buildInfoCard(
                      image: "assets/images/terms.svg",
                      onTap: () => dashProvider.changeBottomIndex(7),
                      title: "Terms and Conditions",
                    ),
                    const SizedBox(height: 16),
                    buildInfoCard(
                      image: "assets/images/privacy.svg",
                      onTap: () => dashProvider.changeBottomIndex(10),
                      title: "Privacy Policy",
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                bgColor: MyColor.redColor,
                text: "Log out",
                radius: 30,
                onTap: () async {
                  await box.clear();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignInScreen(),
                      ));
                },
              ),
            ),
            const SizedBox(height: 40),
          ],
        );
      }),
    );
  }
}

Widget buildInfoCard({
  required String image,
  required VoidCallback onTap,
  required String title,
}) {
  return Container(
    padding: const EdgeInsets.only(top: 8, bottom: 8),
    child: InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xffEBEBEB)),
            child: SvgPicture.asset(image, fit: BoxFit.cover),
          ),
          const SizedBox(width: 16),
          Text(title,
              style: MyStyle.tx16Black.copyWith(
                fontWeight: FontWeight.w400,
              )),
          const Spacer(),
          Icon(
            Icons.keyboard_arrow_right,
            color: MyColor.grey,
          )
        ],
      ),
    ),
  );
}
