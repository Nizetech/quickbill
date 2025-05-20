import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Domain/domain_screen.dart';
import 'package:jost_pay_wallet/Ui/Scripts/script_detail_screen.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

class ScriptScreen extends StatefulWidget {
  const ScriptScreen({super.key});

  @override
  State<ScriptScreen> createState() => _ScriptScreenState();
}

class _ScriptScreenState extends State<ScriptScreen> {
  final FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   FocusScope.of(context).requestFocus(_focusNode);
    // });
  }

  final TextEditingController _controller =
      TextEditingController(text: "PHP script");
  final List<String> tags = [
    'Calendars',
    'Database abstraction',
    'Help & Support',
    'Security',
    'Authentication',
    'API Integration',
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final isDark = themeProvider.isDarkMode();
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode()
          ? MyColor.dark02Color
          : MyColor.mainWhiteColor,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 68)
              .copyWith(bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
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
                      'Scripts',
                      style:
                          MyStyle.tx18Black.copyWith(color: themedata.tertiary),
                    ),
                  ),
                  const Spacer(), // Adds flexible space after the text
                ],
              ),
              const SizedBox(height: 40),
              TextField(
                focusNode: _focusNode,
                controller: _controller,
                style: MyStyle.tx16Gray.copyWith(
                    color: isDark
                        ? MyColor.mainWhiteColor
                        : const Color(0xff6B7280)),
                cursorColor: const Color(0xff6E6D7A),
                decoration: InputDecoration(
                  hintText: 'PHP script',
                  hintStyle: MyStyle.tx16Gray.copyWith(
                      color: isDark
                          ? MyColor.mainWhiteColor
                          : const Color(0xff6B7280)),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: isDark
                              ? const Color(0xff1B1B1B)
                              : const Color(0xffE9EBF8))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: isDark
                              ? const Color(0xff1B1B1B)
                              : const Color(0xffE9EBF8))),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: isDark
                              ? const Color(0xff1B1B1B)
                              : const Color(0xffE9EBF8))),
                ),
              ),
              const SizedBox(height: 13),
              Container(
                height: 65,
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xff101010)
                      : const Color(0xffFCFCFC),
                  border: Border(
                    bottom: BorderSide(
                      color: isDark
                          ? const Color(0xff1B1B1B)
                          : const Color(0xffE9EBF8),
                      width: 1.5,
                    ),
                  ),
                ),
                alignment: Alignment.center,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: tags.length,
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    return Align(
                      alignment: Alignment.center,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(24),
                          onTap: () {},
                          child: Container(
                            height: 35,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                            ),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0xff0D0D0D)
                                  : MyColor.mainWhiteColor,
                              border: Border.all(
                                  color: isDark
                                      ? MyColor.mainWhiteColor.withOpacity(0.1)
                                      : const Color(0xff121212)
                                          .withOpacity(0.1)),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Center(
                              child: Text(
                                tags[index],
                                style: MyStyle.tx12Green.copyWith(
                                    color: themedata.tertiary,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                  child: ListView.separated(
                itemCount: 4,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 18),
                itemBuilder: (context, index) {
                  if (index == 3) {
                    return const SizedBox(
                      height: 100,
                    );
                  }
                  return GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ScriptDetailScreen(),
                      ));
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                          bottom: 22, right: 8, left: 7, top: 8),
                      decoration: BoxDecoration(
                        color: themeProvider.isDarkMode()
                            ? const Color(0xff101010)
                            : const Color(0xffFCFCFC),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: themeProvider.isDarkMode()
                                ? MyColor.outlineDasheColor.withOpacity(0.25)
                                : const Color(0xffE9EBF8)),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/images/script.png",
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 12),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(width: 2),
                                Text(
                                  "Bulk sms complete solution",
                                  style: MyStyle.tx18Grey.copyWith(
                                    color: themedata.tertiary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Spacer(),
                                SvgPicture.asset("assets/images/svg/Star.svg",
                                    color: isDark
                                        ? const Color(0xff0B930B)
                                        : MyColor.greenColor),
                                const SizedBox(width: 4),
                                Text(
                                  "(44)",
                                  style: MyStyle.tx18Grey.copyWith(
                                    color: const Color(0xff83899F),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 15),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              direction: Axis.horizontal,
                              alignment: WrapAlignment.start,
                              crossAxisAlignment: WrapCrossAlignment.start,

                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Dot(color: MyColor.dark01Color),
                                    const SizedBox(width: 4),
                                    Text(
                                      "Laravel",
                                      style: (MyStyle.tx14Black.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff6E6D7A),
                                      )),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Dot(color: MyColor.dark01Color),
                                    const SizedBox(width: 4),
                                    Text(
                                      "CSS",
                                      style: (MyStyle.tx14Black.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff6E6D7A),
                                      )),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Dot(color: MyColor.dark01Color),
                                    const SizedBox(width: 4),
                                    Text(
                                      "PHP",
                                      style: (MyStyle.tx14Black.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff6E6D7A),
                                      )),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Dot(color: MyColor.dark01Color),
                                    const SizedBox(width: 4),
                                    Text(
                                      "Boostrap",
                                      style: (MyStyle.tx14Black.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff6E6D7A),
                                      )),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Dot(color: MyColor.dark01Color),
                                    const SizedBox(width: 4),
                                    Text(
                                      "JavaScript",
                                      style: (MyStyle.tx14Black.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff6E6D7A),
                                      )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 19),
                            Divider(
                              color: isDark
                                  ? const Color(0xff1B1B1B)
                                  : const Color(0xffE9EBF8),
                              height: 0.5,
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/svg/naira.svg",
                                  color: themedata.tertiary,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "1,000,000",
                                  style: MyStyle.tx20Grey.copyWith(
                                    color: themedata.tertiary,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  width: 14,
                                ),
                                SvgPicture.asset(
                                  !isDark
                                      ? "assets/images/svg/package-dark.svg"
                                      : "assets/images/svg/package.svg",
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "73 sales",
                                  style: MyStyle.tx18Grey.copyWith(
                                    color: themedata.tertiary,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Divider(
                              color: isDark
                                  ? const Color(0xff1B1B1B)
                                  : const Color(0xffE9EBF8),
                              height: 0.5,
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  OutlinedButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            const ScriptDetailScreen(),
                                      ));
                                    },
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor:
                                          themeProvider.isDarkMode()
                                              ? MyColor.dark02Color
                                              : MyColor.mainWhiteColor,
                                      side: BorderSide(
                                          color: themeProvider.isDarkMode()
                                              ? MyColor.outlineDasheColor
                                                  .withOpacity(0.25)
                                              : const Color(0xffE9EBF8),
                                          width: 0.8),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 38, vertical: 11),
                                    ),
                                    child: Text("Preview",
                                        style: MyStyle.tx14Black.copyWith(
                                          fontFamily: 'SF Pro Rounded',
                                          color: themeProvider.isDarkMode()
                                              ? MyColor.mainWhiteColor
                                              : MyColor.dark01Color,
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            const ScriptDetailScreen(),
                                      ));
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide.none,
                                      backgroundColor:
                                          themeProvider.isDarkMode()
                                              ? const Color(0xff0B930B)
                                              : MyColor.greenColor,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 38, vertical: 11),
                                    ),
                                    child: Text("Buy Now",
                                        style: MyStyle.tx14Black.copyWith(
                                          fontFamily: 'SF Pro Rounded',
                                          color: MyColor.mainWhiteColor,
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ),
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
