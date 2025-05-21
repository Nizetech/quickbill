import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/Account_Provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Settings/edit_profile.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';
import '../../../bottom_nav.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      body: Consumer<AccountProvider>(builder: (context, model, _) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 68),
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
              const SizedBox(
                height: 24,
              ),
              Center(
                child: Column(
                  children: [
                    Container(
                      
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF2777CD),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(60)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Image.asset(
                          'assets/images/avatar.jpeg',
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(36, -24),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Color(0xFF2777CD),
                            borderRadius: BorderRadius.circular(60)),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Text(
                'Personal Information',
                style: MyStyle.tx18Black.copyWith(color: themedata.tertiary),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: themeProvider.isDarkMode()
                            ? MyColor.borderDarkColor
                            : MyColor.borderColor,
                        width: 1),
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                  child: Column(
                    children: [
                     
                      Row(
                        children: [
                          Text(
                            'Your name',
                            style: MyStyle.tx14Black
                                .copyWith(color: MyColor.signGray),
                          ),
                          const Spacer(),
                          Text(
                            "${model.userModel?.user?.firstName?.capitalizeFirst ?? ""} ${model.userModel?.user?.lastName ?? ""}",
                            style: MyStyle.tx14Black
                                .copyWith(color: themedata.tertiary),
                          )
                        ],
                      ),
                      // const SizedBox(
                      //   height: 24,
                      // ),
                      // Row(
                      //   children: [
                      //     Text('Reg Date',
                      //         style: MyStyle.tx14Black
                      //             .copyWith(color: MyColor.signGray)),
                      //     const Spacer(),
                      //     Text('Jul 31th 2024',
                      //         style: MyStyle.tx14Black
                      //             .copyWith(color: themedata.tertiaryFixed))
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              Text(
                'Contact Info',
                style: MyStyle.tx18Black.copyWith(color: themedata.tertiary),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: themeProvider.isDarkMode()
                            ? MyColor.borderDarkColor
                            : MyColor.borderColor,
                        width: 1),
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                  child: Column(
                    children: [
                     
                      Row(
                        children: [
                          Text(
                            'Phone number',
                            style: MyStyle.tx14Black
                                .copyWith(color: MyColor.signGray),
                          ),
                          const Spacer(),
                          Text(
                            model.userModel?.user?.phoneNumber ?? "",
                            style: MyStyle.tx14Black.copyWith(
                                color: themedata.tertiary,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text('Email',
                              style: MyStyle.tx14Black
                                  .copyWith(color: MyColor.signGray)),
                          const Spacer(),
                          Text(model.userModel?.user?.email ?? "",
                              style: MyStyle.tx14Black.copyWith(
                                  color: themedata.tertiary,
                                  fontWeight: FontWeight.w500))
                        ],
                      ),
                    
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: themeProvider.isDarkMode()
                            ? MyColor.borderDarkColor
                            : MyColor.borderColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => Get.to(EditProfileScreen()),
                  child: Text(
                    "Edit",
                    style: MyStyle.tx16Green.copyWith(fontFamily: 'Roboto'),
                  ),
                ),
              )
            ],
          ),
        );
      }
      ),
    );
  }
}
