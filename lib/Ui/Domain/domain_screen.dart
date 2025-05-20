import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

class DomainScreen extends StatefulWidget {
  const DomainScreen({super.key});

  @override
  State<DomainScreen> createState() => _DomainScreenState();
}

class _DomainScreenState extends State<DomainScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
        backgroundColor: themeProvider.isDarkMode()
            ? MyColor.dark02Color
            : MyColor.mainWhiteColor,
        body: Padding(
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
                        'Domain',
                        style: MyStyle.tx18Black
                            .copyWith(color: themedata.tertiary),
                      ),
                    ),
                    const Spacer(), // Adds flexible space after the text
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              barrierColor:
                                  const Color(0xffBCBCBC).withOpacity(0.5),
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => const DomainModalSheet(),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                bottom: 12, right: 24, left: 15, top: 19),
                            decoration: BoxDecoration(
                              color: themeProvider.isDarkMode()
                                  ? const Color(0xff101010)
                                  : const Color(0xffFCFCFC),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: themeProvider.isDarkMode()
                                      ? MyColor.outlineDasheColor
                                          .withOpacity(0.3)
                                      : const Color(0xffE9EBF8)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Domain and Expiry
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    DotLabel(
                                        text: "Domain",
                                        value: "Jostpayhostmain.com"),
                                    DotLabel(
                                        text: "Expiry date",
                                        value: "Feb, 24 2026"),
                                  ],
                                ),
                                const SizedBox(height: 22),

                                // Services and SSL
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Dot(
                                                  color: themeProvider
                                                          .isDarkMode()
                                                      ? MyColor.whiteColor
                                                      : MyColor.dark01Color),
                                              const SizedBox(width: 6),
                                              Text(
                                                "Services",
                                                style:
                                                    MyStyle.tx14Black.copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color: themeProvider
                                                          .isDarkMode()
                                                      ? MyColor.whiteColor
                                                      : const Color(0xff6E6D7A),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                top: 8,
                                                bottom: 8,
                                                left: 16,
                                                right: 10),
                                            decoration: BoxDecoration(
                                              color: themeProvider.isDarkMode()
                                                  ? MyColor.dark02Color
                                                  : MyColor.mainWhiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              border: Border.all(
                                                color: themeProvider
                                                        .isDarkMode()
                                                    ? const Color(0xff1B1B1B)
                                                    : const Color(0xffE9EBF8),
                                              ),
                                            ),
                                            child: Row(
                                              spacing: 9,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SvgPicture.asset(themeProvider
                                                        .isDarkMode()
                                                    ? 'assets/images/svg/home-dark.svg'
                                                    : 'assets/images/svg/home.svg'),
                                                SvgPicture.asset(themeProvider
                                                        .isDarkMode()
                                                    ? 'assets/images/svg/lock-dark.svg'
                                                    : 'assets/images/svg/lock.svg'),
                                                SvgPicture.asset(themeProvider
                                                        .isDarkMode()
                                                    ? 'assets/images/svg/security-dark.svg'
                                                    : 'assets/images/svg/security.svg'),
                                                Container(
                                                  width: 23,
                                                  height: 23,
                                                  margin: const EdgeInsets.only(
                                                      left: 4),
                                                  // padding: const EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: themeProvider
                                                            .isDarkMode()
                                                        ? const Color(
                                                            0xff151515)
                                                        : const Color(
                                                            0xffF5F6F8),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: SvgPicture.asset(
                                                      width: 8,
                                                      height: 6,
                                                      color: themeProvider
                                                              .isDarkMode()
                                                          ? MyColor
                                                              .mainWhiteColor
                                                          : const Color(
                                                              0xff6E6D7A),
                                                      'assets/images/svg/down.svg'),
                                                )
                                              ],
                                            ),
                                          )
                                        ]),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 28),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Dot(
                                                    color: themeProvider
                                                            .isDarkMode()
                                                        ? MyColor.whiteColor
                                                        : MyColor.dark01Color),
                                                const SizedBox(width: 6),
                                                Text(
                                                  "SSL",
                                                  style: MyStyle.tx14Black
                                                      .copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    color: themeProvider
                                                            .isDarkMode()
                                                        ? MyColor.whiteColor
                                                        : const Color(
                                                            0xff6E6D7A),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 4),
                                              decoration: BoxDecoration(
                                                color: const Color(0xff12B76A)
                                                    .withOpacity(0.09),
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  "SSL",
                                                  style: MyStyle.tx14Green,
                                                ),
                                              ),
                                            )
                                          ]),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 24),

                                // Manage Details Button
                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        barrierColor: const Color(0xffBCBCBC)
                                            .withOpacity(0.5),
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        builder: (context) =>
                                            const DomainModalSheet(),
                                      );
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
                                          horizontal: 24, vertical: 14),
                                    ),
                                    child: Text("Manage details",
                                        style: MyStyle.tx14Black.copyWith(
                                          fontFamily: 'SF Pro Rounded',
                                          color: themeProvider.isDarkMode()
                                              ? MyColor.mainWhiteColor
                                              : MyColor.dark01Color,
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Divider(
                          color: themeProvider.isDarkMode()
                              ? const Color(0xff1B1B1B)
                              : const Color(0xffE9EBF8),
                          thickness: 0.6,
                          indent: 13,
                          endIndent: 13,
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              barrierColor:
                                  const Color(0xffBCBCBC).withOpacity(0.5),
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => const DomainModalSheet(),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                bottom: 12, right: 24, left: 15, top: 19),
                            decoration: BoxDecoration(
                              color: themeProvider.isDarkMode()
                                  ? const Color(0xff101010)
                                  : const Color(0xffFCFCFC),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: themeProvider.isDarkMode()
                                      ? MyColor.outlineDasheColor
                                          .withOpacity(0.3)
                                      : const Color(0xffE9EBF8)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Domain and Expiry
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    DotLabel(
                                        text: "Domain", value: "digitng.com"),
                                    DotLabel(
                                        text: "Expiry date",
                                        value: "Feb, 24 2026"),
                                  ],
                                ),
                                const SizedBox(height: 22),

                                // Services and SSL
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Dot(
                                                  color: themeProvider
                                                          .isDarkMode()
                                                      ? MyColor.whiteColor
                                                      : MyColor.dark01Color),
                                              const SizedBox(width: 6),
                                              Text(
                                                "Services",
                                                style:
                                                    MyStyle.tx14Black.copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color: themeProvider
                                                          .isDarkMode()
                                                      ? MyColor.whiteColor
                                                      : const Color(0xff6E6D7A),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                top: 8,
                                                bottom: 8,
                                                left: 16,
                                                right: 10),
                                            decoration: BoxDecoration(
                                              color: themeProvider.isDarkMode()
                                                  ? MyColor.dark02Color
                                                  : MyColor.mainWhiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              border: Border.all(
                                                color: themeProvider
                                                        .isDarkMode()
                                                    ? const Color(0xff1B1B1B)
                                                    : const Color(0xffE9EBF8),
                                              ),
                                            ),
                                            child: Row(
                                              spacing: 9,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SvgPicture.asset(themeProvider
                                                        .isDarkMode()
                                                    ? 'assets/images/svg/home-dark.svg'
                                                    : 'assets/images/svg/home.svg'),
                                                SvgPicture.asset(themeProvider
                                                        .isDarkMode()
                                                    ? 'assets/images/svg/lock-dark.svg'
                                                    : 'assets/images/svg/lock.svg'),
                                                SvgPicture.asset(themeProvider
                                                        .isDarkMode()
                                                    ? 'assets/images/svg/lock-dark.svg'
                                                    : 'assets/images/svg/lock.svg'),
                                                SvgPicture.asset(themeProvider
                                                        .isDarkMode()
                                                    ? 'assets/images/svg/lock-dark.svg'
                                                    : 'assets/images/svg/lock.svg'),
                                                SvgPicture.asset(themeProvider
                                                        .isDarkMode()
                                                    ? 'assets/images/svg/security-dark.svg'
                                                    : 'assets/images/svg/security.svg'),
                                                Container(
                                                  width: 23,
                                                  height: 23,
                                                  margin: const EdgeInsets.only(
                                                      left: 4),
                                                  // padding: const EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: themeProvider
                                                            .isDarkMode()
                                                        ? const Color(
                                                            0xff151515)
                                                        : const Color(
                                                            0xffF5F6F8),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: SvgPicture.asset(
                                                      width: 8,
                                                      height: 6,
                                                      color: themeProvider
                                                              .isDarkMode()
                                                          ? MyColor
                                                              .mainWhiteColor
                                                          : const Color(
                                                              0xff6E6D7A),
                                                      'assets/images/svg/down.svg'),
                                                )
                                              ],
                                            ),
                                          )
                                        ]),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 28),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Dot(
                                                    color: themeProvider
                                                            .isDarkMode()
                                                        ? MyColor.whiteColor
                                                        : MyColor.dark01Color),
                                                const SizedBox(width: 6),
                                                Text(
                                                  "SSL",
                                                  style: MyStyle.tx14Black
                                                      .copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    color: themeProvider
                                                            .isDarkMode()
                                                        ? MyColor.whiteColor
                                                        : const Color(
                                                            0xff6E6D7A),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 4),
                                              decoration: BoxDecoration(
                                                color: const Color(0xff12B76A)
                                                    .withOpacity(0.09),
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  "SSL",
                                                  style: MyStyle.tx14Green,
                                                ),
                                              ),
                                            )
                                          ]),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 24),

                                // Manage Details Button
                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        barrierColor: const Color(0xffBCBCBC)
                                            .withOpacity(0.5),
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        builder: (context) =>
                                            const DomainModalSheet(),
                                      );
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide.none,
                                      backgroundColor:
                                          themeProvider.isDarkMode()
                                              ? const Color(0xff0B930B)
                                              : MyColor.greenColor,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 14),
                                    ),
                                    child: Text("Manage details",
                                        style: MyStyle.tx14Black.copyWith(
                                          fontFamily: 'SF Pro Rounded',
                                          color: MyColor.mainWhiteColor,
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 9),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              barrierColor:
                                  const Color(0xffBCBCBC).withOpacity(0.5),
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => const DomainModalSheet(),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                bottom: 12, right: 24, left: 15, top: 19),
                            decoration: BoxDecoration(
                              color: themeProvider.isDarkMode()
                                  ? const Color(0xff101010)
                                  : const Color(0xffFCFCFC),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: themeProvider.isDarkMode()
                                      ? MyColor.outlineDasheColor
                                          .withOpacity(0.3)
                                      : const Color(0xffE9EBF8)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Domain and Expiry
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    DotLabel(
                                        text: "Domain", value: "digitng.com"),
                                    DotLabel(
                                        text: "Expiry date",
                                        value: "Feb, 24 2026"),
                                  ],
                                ),
                                const SizedBox(height: 22),

                                // Services and SSL
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Dot(
                                                  color: themeProvider
                                                          .isDarkMode()
                                                      ? MyColor.whiteColor
                                                      : MyColor.dark01Color),
                                              const SizedBox(width: 6),
                                              Text(
                                                "Services",
                                                style:
                                                    MyStyle.tx14Black.copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color: themeProvider
                                                          .isDarkMode()
                                                      ? MyColor.whiteColor
                                                      : const Color(0xff6E6D7A),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                top: 8,
                                                bottom: 8,
                                                left: 16,
                                                right: 10),
                                            decoration: BoxDecoration(
                                              color: themeProvider.isDarkMode()
                                                  ? MyColor.dark02Color
                                                  : MyColor.mainWhiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              border: Border.all(
                                                color: themeProvider
                                                        .isDarkMode()
                                                    ? const Color(0xff1B1B1B)
                                                    : const Color(0xffE9EBF8),
                                              ),
                                            ),
                                            child: Row(
                                              spacing: 9,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SvgPicture.asset(themeProvider
                                                        .isDarkMode()
                                                    ? 'assets/images/svg/home-dark.svg'
                                                    : 'assets/images/svg/home.svg'),
                                                Container(
                                                  width: 23,
                                                  height: 23,
                                                  margin: const EdgeInsets.only(
                                                      left: 4),
                                                  // padding: const EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: themeProvider
                                                            .isDarkMode()
                                                        ? const Color(
                                                            0xff151515)
                                                        : const Color(
                                                            0xffF5F6F8),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: SvgPicture.asset(
                                                      width: 8,
                                                      height: 6,
                                                      color: themeProvider
                                                              .isDarkMode()
                                                          ? MyColor
                                                              .mainWhiteColor
                                                          : const Color(
                                                              0xff6E6D7A),
                                                      'assets/images/svg/down.svg'),
                                                )
                                              ],
                                            ),
                                          )
                                        ]),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 28),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Dot(
                                                    color: themeProvider
                                                            .isDarkMode()
                                                        ? MyColor.whiteColor
                                                        : MyColor.dark01Color),
                                                const SizedBox(width: 6),
                                                Text(
                                                  "SSL",
                                                  style: MyStyle.tx14Black
                                                      .copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    color: themeProvider
                                                            .isDarkMode()
                                                        ? MyColor.whiteColor
                                                        : const Color(
                                                            0xff6E6D7A),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 4),
                                              decoration: BoxDecoration(
                                                color: const Color(0xff12B76A)
                                                    .withOpacity(0.09),
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  "SSL",
                                                  style: MyStyle.tx14Green,
                                                ),
                                              ),
                                            )
                                          ]),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 24),

                                // Manage Details Button
                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        barrierColor: const Color(0xffBCBCBC)
                                            .withOpacity(0.5),
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        builder: (context) =>
                                            const DomainModalSheet(),
                                      );
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide.none,
                                      backgroundColor:
                                          themeProvider.isDarkMode()
                                              ? const Color(0xff0B930B)
                                              : MyColor.greenColor,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 14),
                                    ),
                                    child: Text("Manage details",
                                        style: MyStyle.tx14Black.copyWith(
                                          fontFamily: 'SF Pro Rounded',
                                          color: MyColor.mainWhiteColor,
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: themeProvider.isDarkMode()
                                    ? const Color(0xff1B1B1B)
                                    : const Color(0xffE9EBF8),
                              ),
                              backgroundColor: themeProvider.isDarkMode()
                                  ? MyColor.dark02Color
                                  : MyColor.mainWhiteColor,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 14),
                            ),
                            child: Text("Show all",
                                style: MyStyle.tx14Black.copyWith(
                                  fontFamily: 'SF Pro Rounded',
                                  color: themeProvider.isDarkMode()
                                      ? const Color(0xffCBD2EB)
                                      : MyColor.blackColor,
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}

class DotLabel extends StatelessWidget {
  final String text;
  final String value;
  final Color? labelColor;
  final Color? textColor;
  final Color? dotColor;
  final TextStyle? textStyle;
  final TextStyle? labelStyle;

  const DotLabel({
    super.key,
    required this.text,
    required this.value,
    this.dotColor,
    this.labelColor,
    this.textColor,
    this.textStyle,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          Dot(
              color: dotColor ??
                  (themeProvider.isDarkMode()
                      ? MyColor.whiteColor
                      : MyColor.dark01Color)),
          const SizedBox(width: 6),
          Text(
            text,
            style: labelStyle ??
                (MyStyle.tx14Black.copyWith(
                  fontWeight: FontWeight.w500,
                  color: labelColor ??
                      (themeProvider.isDarkMode()
                          ? MyColor.whiteColor
                          : const Color(0xff6E6D7A)),
                )),
          ),
        ],
      ),
      const SizedBox(height: 8),
      Text(
        value,
        style: textStyle ??
            MyStyle.tx16Black.copyWith(
              fontWeight: FontWeight.w400,
              color: textColor ??
                  (themeProvider.isDarkMode()
                      ? const Color(0xffCBD2EB)
                      : const Color(0xff141B34)),
            ),
      ),
    ]);
  }
}

class Dot extends StatelessWidget {
  final Color color;
  final double? size;
  const Dot({super.key, required this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size ?? 7,
      height: size ?? 7,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

class DomainModalSheet extends StatefulWidget {
  const DomainModalSheet({super.key});

  @override
  State<DomainModalSheet> createState() => _DomainModalSheetState();
}

bool _autoRenew = true;
bool _autoRenew2 = true;

class _DomainModalSheetState extends State<DomainModalSheet> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final isDark = themeProvider.isDarkMode();
    final themedata = Theme.of(context).colorScheme;

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 0.95,
      minChildSize: 0.4,
      builder: (_, controller) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14)
              .copyWith(right: 21),
          decoration: BoxDecoration(
            color: isDark ? MyColor.dark02Color : MyColor.mainWhiteColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: ListView(
            controller: controller,
            children: [
              Center(
                child: Container(
                  width: 107,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xff8F8F90)
                        : const Color(0xffE5E4E4),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // 👇 Put the content shown in the image here
              DomainInfoCard(
                title: "Jostpayhostmain.com",
                subtitle: "Domain name",
                statusIcon: isDark
                    ? "assets/images/svg/home-dark.svg"
                    : "assets/images/svg/home.svg",
                status: "Active",
                expiryDate: "Feb, 24 2026",
                autoRenew: _autoRenew,
                onToggleRenew: (value) {
                  setState(() {
                    _autoRenew = value;
                  });
                },
              ),
              const SizedBox(height: 35),
              DomainInfoCard(
                title: "Domain Privacy",
                subtitle: "",
                status: "ON",
                statusIcon: isDark
                    ? "assets/images/svg/security-dark.svg"
                    : "assets/images/svg/security.svg",
                expiryDate: "Feb, 24 2026",
                autoRenew: _autoRenew2,
                onToggleRenew: (value) {
                  setState(() {
                    _autoRenew2 = value;
                  });
                },
              ),
              // const SizedBox(height: 16),
              // DomainInfoCard(
              //   title: "Positivessl",
              //   subtitle: "Ssl Certificate",
              //   status: "Active",
              //   expiryDate: "Feb, 24 2026",
              //   autoRenew: false,
              // ),
              const SizedBox(height: 22),
              YearDropdown(),
              const SizedBox(height: 26),

              Divider(
                color: themeProvider.isDarkMode()
                    ? const Color(0xff1B1B1B)
                    : const Color(0xffE9EBF8),
                thickness: 0.6,
                indent: 3,
                endIndent: 3,
              ),

              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            isDark
                                ? "assets/images/svg/lock-dark.svg"
                                : "assets/images/svg/lock.svg",
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Positivessl",
                            style: MyStyle.tx18Black.copyWith(
                                fontWeight: FontWeight.w400,
                                color: themedata.tertiary),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Text(
                          "SSl Certificate",
                          style: MyStyle.tx14Grey.copyWith(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff6B7280)),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/images/svg/circle.svg",
                                width: 22,
                                height: 22,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                "ACTIVE",
                                style: MyStyle.tx14Grey.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff6B7280)),
                              )
                            ],
                          )),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 102,
                        height: 38,
                        decoration: BoxDecoration(
                          color: const Color(0xff12B76A).withOpacity(0.09),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Center(
                          child: Text(
                            "Active",
                            style: MyStyle.tx14Green,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      DotLabel(
                        text: "Expiry date",
                        value: "Feb 24, 2026",
                        labelStyle: MyStyle.tx14Black.copyWith(
                            fontStyle: FontStyle.italic,
                            color: const Color(0xff6B7280),
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: themeProvider.isDarkMode()
                          ? const Color(0xff1B1B1B)
                          : const Color(0xffE9EBF8),
                    ),
                    backgroundColor: themeProvider.isDarkMode()
                        ? MyColor.dark02Color
                        : MyColor.mainWhiteColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 14),
                  ),
                  child: Text("Manage details",
                      style: MyStyle.tx14Black.copyWith(
                        fontFamily: 'SF Pro Rounded',
                        color: themeProvider.isDarkMode()
                            ? MyColor.whiteColor
                            : MyColor.blackColor,
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class DomainInfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String status;
  final String statusIcon;
  final String expiryDate;
  final bool autoRenew;
  final void Function(bool) onToggleRenew;
  const DomainInfoCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.statusIcon,
    required this.status,
    required this.expiryDate,
    required this.autoRenew,
    required this.onToggleRenew,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final isDark = themeProvider.isDarkMode();
    final themedata = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  statusIcon,
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 6),
                Text(
                  title,
                  style: MyStyle.tx18Black.copyWith(
                      fontWeight: FontWeight.w400, color: themedata.tertiary),
                ),
              ],
            ),
            // const SizedBox(height: 2),
            if (subtitle.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  subtitle,
                  style: MyStyle.tx14Grey.copyWith(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff6B7280)),
                ),
              ),
            const SizedBox(height: 25),
            Padding(
                padding: const EdgeInsets.only(left: 30),
                child: DotLabel(
                  text: "Expiry date",
                  value: "Feb 24, 2026",
                  labelStyle: MyStyle.tx14Black.copyWith(
                      fontStyle: FontStyle.italic,
                      color: const Color(0xff6B7280),
                      fontWeight: FontWeight.w400),
                )),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 102,
              height: 38,
              decoration: BoxDecoration(
                color: const Color(0xff12B76A).withOpacity(0.09),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Text(
                  status,
                  style: MyStyle.tx14Green,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: CustomSwitch(
                value: autoRenew,
                onChanged: (value) {
                  onToggleRenew(value);
                  // Handle switch change
                },
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                "Auto Renew",
                style: MyStyle.tx14Grey.copyWith(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff6B7280)),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onChanged(!widget.value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 52,
        height: 28,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: widget.value ? const Color(0xff0B930B) : Colors.grey[400],
          borderRadius: BorderRadius.circular(18),
        ),
        child: Align(
          alignment:
              widget.value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 22,
            height: 22,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}

class YearSelector extends StatefulWidget {
  @override
  _YearSelectorState createState() => _YearSelectorState();
}

class _YearSelectorState extends State<YearSelector> {
  String? selectedYear;
  final List<String> years =
      List.generate(50, (index) => (2000 + index).toString());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade700),
        borderRadius: BorderRadius.circular(30),
        color: Colors.black,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedYear,
          hint: const Text(
            "Add Years",
            style: TextStyle(color: Colors.white),
          ),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
          dropdownColor: Colors.grey[900],
          style: const TextStyle(color: Colors.white),
          items: years.map((String year) {
            return DropdownMenuItem<String>(
              value: year,
              child: Text(year),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedYear = newValue;
            });
          },
        ),
      ),
    );
  }
}

class YearDropdown extends StatefulWidget {
  const YearDropdown({super.key});

  @override
  State<YearDropdown> createState() => _YearDropdownState();
}

class _YearDropdownState extends State<YearDropdown> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  String? selectedYear;
  bool isDropdownOpen = false;

  final List<String> years =
      List.generate(40, (index) => (2025 + index).toString());

  void toggleDropdown(BuildContext ctx) {
    if (isDropdownOpen) {
      _closeDropdown();
    } else {
      _openDropdown(ctx);
    }
  }

  void _openDropdown(BuildContext ctx) {
    final overlay = Overlay.of(context);
    _overlayEntry = _createOverlay(ctx);
    overlay.insert(_overlayEntry!);
    setState(() => isDropdownOpen = true);
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => isDropdownOpen = false);
  }

  OverlayEntry _createOverlay(BuildContext ctx) {
    final themeProvider = Provider.of<ThemeProvider>(ctx, listen: false);
    final isDark = themeProvider.isDarkMode();

    RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          // This catches taps outside to close the dropdown
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: _closeDropdown,
            child: Container(
              color: Colors.transparent,
            ),
          ),
          Positioned(
            left: offset.dx,
            top: offset.dy + size.height + 5,
            width: size.width,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              child: Material(
                elevation: 4,
                color: isDark ? MyColor.dark01Color : Colors.white,
                borderRadius: BorderRadius.circular(16),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                      maxHeight: 250), // make it scrollable
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: years.map((year) {
                      return ListTile(
                        title: Text(year,
                            style: MyStyle.tx14Grey.copyWith(
                              color: isDark
                                  ? MyColor.whiteColor
                                  : const Color(0xff6E6D7A),
                            )),
                        onTap: () {
                          setState(() {
                            selectedYear = year;
                            isDropdownOpen = false;
                          });
                          _overlayEntry?.remove();
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _closeDropdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final isDark = themeProvider.isDarkMode();
    final themedata = Theme.of(context).colorScheme;
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: () {
          toggleDropdown(context);
        },
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: isDark ? MyColor.dark02Color : MyColor.mainWhiteColor,
            border: Border.all(
                color: isDark
                    ? MyColor.outlineDasheColor.withOpacity(0.25)
                    : const Color(
                        0xffE9EBF8) // Change this to your desired color

                ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: Text(selectedYear ?? 'Add Years',
                      style: MyStyle.tx14White.copyWith(
                        color: themedata.tertiary,
                      )),
                ),
              ),
              Container(
                height: 100,
                width: 1,
                color: isDark
                    ? MyColor.outlineDasheColor.withOpacity(0.25)
                    : const Color(0xffE9EBF8),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.all(5).copyWith(left: 10),
                child: SvgPicture.asset(
                    width: 18,
                    height: 10,
                    color: const Color(0xff6E6D7A),
                    'assets/images/svg/down.svg'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
