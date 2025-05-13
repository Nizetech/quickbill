import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../DashboardScreen.dart';

class ProfileScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  const ProfileScreen({
    super.key,
    required this.data,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String selectedAccountName = "";
  late Map<String, dynamic> profile = {};

  getWalletName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      selectedAccountName = sharedPreferences.getString('accountName') ?? "";
    });
  }

  @override
  void initState() {
    getWalletName();
    profile = widget.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      body: Padding(
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
                          builder: (context) => const DashboardScreen())),
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
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                        color: const Color(0xFF2777CD),
                        borderRadius: BorderRadius.circular(60)),
                    child: Image.asset(
                      'assets/images/avatar-lg.png',
                      width: 80,
                      height: 80,
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(36, -24),
                    child: Image.asset('assets/images/tabler_edit.png'),
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
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Text(
                          'Your name',
                          style: MyStyle.tx14Black
                              .copyWith(color: MyColor.signGray),
                        ),
                        const Spacer(),
                        Text(
                          'Yemi Oshor',
                          style: MyStyle.tx14Black
                              .copyWith(color: themedata.tertiary),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      children: [
                        Text('Reg Date',
                            style: MyStyle.tx14Black
                                .copyWith(color: MyColor.signGray)),
                        const Spacer(),
                        Text('Jul 31th 2024',
                            style: MyStyle.tx14Black
                                .copyWith(color: themedata.tertiaryFixed))
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
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
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Text(
                          'Phone number',
                          style: MyStyle.tx14Black
                              .copyWith(color: MyColor.signGray),
                        ),
                        const Spacer(),
                        Text(
                          '+234 8087654327',
                          style: MyStyle.tx14Black.copyWith(
                              color: themedata.tertiary,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      children: [
                        Text('Email',
                            style: MyStyle.tx14Black
                                .copyWith(color: MyColor.signGray)),
                        const Spacer(),
                        Text('Yemioshor82@mail.com',
                            style: MyStyle.tx14Black.copyWith(
                                color: themedata.tertiary,
                                fontWeight: FontWeight.w500))
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 110,
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
                onPressed: () {},
                child: Text(
                  "Edit",
                  style: MyStyle.tx16Green.copyWith(fontFamily: 'Roboto'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
