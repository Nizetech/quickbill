import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jost_pay_wallet/Provider/service_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Domain/widget/domain_modal_sheet.dart';
import 'package:jost_pay_wallet/Ui/Domain/widget/dot.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/common/button.dart';
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
    final model = Provider.of<ServiceProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (model.domainListModel == null) {
        model.getDomainList();
      } else {
        model.getDomainList(isLoading: false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
        backgroundColor: themeProvider.isDarkMode()
            ? MyColor.dark02Color
            : MyColor.mainWhiteColor,
        body: SafeArea(
          child: Consumer<ServiceProvider>(builder: (context, model, _) {
            return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20)
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
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: RefreshIndicator(
                          onRefresh: () async {
                            model.getDomainList();
                          },
                          child: Column(
                            children: [
                              if (model.domainListModel != null)
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  separatorBuilder: (_, i) =>
                                      SizedBox(height: 15),
                                  itemBuilder: (_, i) {
                                    final item =
                                        model.domainListModel!.domainList![i];
                                    return GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          barrierColor: const Color(0xffBCBCBC)
                                              .withOpacity(0.5),
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          builder: (context) =>
                                              DomainModalSheet(
                                            domain: item,
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            bottom: 12,
                                            right: 24,
                                            left: 15,
                                            top: 19),
                                        decoration: BoxDecoration(
                                          color: themeProvider.isDarkMode()
                                              ? const Color(0xff101010)
                                              : const Color(0xffFCFCFC),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: themeProvider.isDarkMode()
                                                  ? MyColor.outlineDasheColor
                                                      .withOpacity(0.3)
                                                  : const Color(0xffE9EBF8)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Domain and Expiry
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                DotLabel(
                                                    text: "Domain",
                                                    value: item.dns!),
                                                DotLabel(
                                                    text: "Expiry date",
                                                    value: item.expiryAt!),
                                              ],
                                            ),
                                            const SizedBox(height: 22),

                                            // Services and SSL
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Dot(
                                                              color: themeProvider
                                                                      .isDarkMode()
                                                                  ? MyColor
                                                                      .whiteColor
                                                                  : MyColor
                                                                      .dark01Color),
                                                          const SizedBox(
                                                              width: 6),
                                                          Text(
                                                            "Services",
                                                            style: MyStyle
                                                                .tx14Black
                                                                .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: themeProvider
                                                                      .isDarkMode()
                                                                  ? MyColor
                                                                      .whiteColor
                                                                  : const Color(
                                                                      0xff6E6D7A),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 8,
                                                                bottom: 8,
                                                                left: 16,
                                                                right: 10),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: themeProvider
                                                                  .isDarkMode()
                                                              ? MyColor
                                                                  .dark02Color
                                                              : MyColor
                                                                  .mainWhiteColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                          border: Border.all(
                                                            color: themeProvider
                                                                    .isDarkMode()
                                                                ? const Color(
                                                                    0xff1B1B1B)
                                                                : const Color(
                                                                    0xffE9EBF8),
                                                          ),
                                                        ),
                                                        child: Row(
                                                          spacing: 9,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
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
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 4),
                                                              // padding: const EdgeInsets.all(5),
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: themeProvider
                                                                        .isDarkMode()
                                                                    ? const Color(
                                                                        0xff151515)
                                                                    : const Color(
                                                                        0xffF5F6F8),
                                                              ),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 28),
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Dot(
                                                                color: themeProvider
                                                                        .isDarkMode()
                                                                    ? MyColor
                                                                        .whiteColor
                                                                    : MyColor
                                                                        .dark01Color),
                                                            const SizedBox(
                                                                width: 6),
                                                            Text(
                                                              "SSL",
                                                              style: MyStyle
                                                                  .tx14Black
                                                                  .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: themeProvider
                                                                        .isDarkMode()
                                                                    ? MyColor
                                                                        .whiteColor
                                                                    : const Color(
                                                                        0xff6E6D7A),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 8),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      20,
                                                                  vertical: 4),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: const Color(
                                                                    0xff12B76A)
                                                                .withOpacity(
                                                                    0.09),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                          ),
                                                          child: const Center(
                                                            child: Text(
                                                              "SSL",
                                                              style: MyStyle
                                                                  .tx14Green,
                                                            ),
                                                          ),
                                                        )
                                                      ]),
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 24),
                                            CustomButton(
                                                radius: 60,
                                                text: "Manage details",
                                                onTap: () {
                                                  showModalBottomSheet(
                                                    context: context,
                                                    barrierColor:
                                                        const Color(0xffBCBCBC)
                                                            .withOpacity(0.5),
                                                    isScrollControlled: true,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    builder: (context) =>
                                                        DomainModalSheet(
                                                      domain: item,
                                                    ),
                                                  );
                                                })
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount:
                                      model.domainListModel!.domainList!.length,
                                ),
                              const SizedBox(height: 24),
                              // SizedBox(
                              //   width: double.infinity,
                              //   child: OutlinedButton(
                              //     onPressed: () {},
                              //     style: OutlinedButton.styleFrom(
                              //       side: BorderSide(
                              //         color: themeProvider.isDarkMode()
                              //             ? const Color(0xff1B1B1B)
                              //             : const Color(0xffE9EBF8),
                              //       ),
                              //       backgroundColor: themeProvider.isDarkMode()
                              //           ? MyColor.dark02Color
                              //           : MyColor.mainWhiteColor,
                              //       padding: const EdgeInsets.symmetric(
                              //           horizontal: 24, vertical: 14),
                              //     ),
                              //     child: Text("Show all",
                              //         style: MyStyle.tx14Black.copyWith(
                              //           fontFamily: 'SF Pro Rounded',
                              //           color: themeProvider.isDarkMode()
                              //               ? const Color(0xffCBD2EB)
                              //               : MyColor.blackColor,
                              //           fontWeight: FontWeight.w600,
                              //         )),
                              //   ),
                              // ),
                              // const SizedBox(height: 100),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ));
          }),
        ));
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
  final int flex;

  const DotLabel({
    super.key,
    required this.text,
    required this.value,
    this.flex = 1,
    this.dotColor,
    this.labelColor,
    this.textColor,
    this.textStyle,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    return Expanded(
      flex: flex,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform.translate(
            offset: const Offset(0, 5),
            child: Dot(
                color: dotColor ??
                    (themeProvider.isDarkMode()
                        ? MyColor.whiteColor
                        : MyColor.dark01Color)),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DotLabelFlexFree extends StatelessWidget {
  final String text;
  final String value;
  final Color? labelColor;
  final Color? textColor;
  final Color? dotColor;
  final TextStyle? textStyle;
  final TextStyle? labelStyle;

  const DotLabelFlexFree({
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Transform.translate(
          offset: const Offset(0, 5),
          child: Dot(
              color: dotColor ??
                  (themeProvider.isDarkMode()
                      ? MyColor.whiteColor
                      : MyColor.dark01Color)),
        ),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
          ],
        ),
      ],
    );
  }
}
