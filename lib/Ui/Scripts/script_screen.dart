import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Models/script_model.dart';
import 'package:jost_pay_wallet/Provider/service_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Domain/widget/dot.dart';
import 'package:jost_pay_wallet/Ui/Scripts/script_detail_screen.dart';
import 'package:jost_pay_wallet/Ui/Scripts/script_summary.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/common/text_field.dart';
import 'package:provider/provider.dart';

class ScriptScreen extends StatefulWidget {
  const ScriptScreen({super.key});

  @override
  State<ScriptScreen> createState() => _ScriptScreenState();
}

class _ScriptScreenState extends State<ScriptScreen> {
  final FocusNode _focusNode = FocusNode();
  List<Script> script = [];
  @override
  void initState() {
    super.initState();
    final model = Provider.of<ServiceProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // if (model.scriptModel == null) {
      await model.getScripts();
      script = model.scriptModel!.scripts!;
      // } else {
      //   await model.getScripts(isLoading: false);
      //   script = model.scriptModel!.scripts!;
      // }
      setState(() {});
    });
  }

  final _controller = TextEditingController();
  // final List<String> tags = [
  //   'Calendars',
  //   'Database abstraction',
  //   'Help & Support',
  //   'Security',
  //   'Authentication',
  //   'API Integration',
  // ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final isDark = themeProvider.isDarkMode();
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode()
          ? MyColor.dark02Color
          : MyColor.mainWhiteColor,
      body: Consumer<ServiceProvider>(builder: (context, model, _) {
        return SafeArea(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20)
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
                          style: MyStyle.tx18Black
                              .copyWith(color: themedata.tertiary),
                        ),
                      ),
                      const Spacer(), // Adds flexible space after the text
                    ],
                  ),
                  const SizedBox(height: 20),

                  CustomTextField(
                    enabled: true,
                    focusNode: _focusNode,
                    text: 'Search any sort of script here',
                    controller: _controller,
                    onChanged: (val) {
                      if (val.isNotEmpty) {
                        setState(() {
                          script = model.scriptModel!.scripts!
                              .where((element) => element.title!
                                  // .toJson()
                                  // .toString()
                                  .toLowerCase()
                                  .contains(val.toLowerCase()))
                              .toList();
                        });
                      } else {
                        setState(() {
                          script = model.scriptModel!.scripts!;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 13),
                  // Container(
                  //   height: 65,
                  //   decoration: BoxDecoration(
                  //     color: isDark
                  //         ? const Color(0xff101010)
                  //         : const Color(0xffFCFCFC),
                  //     border: Border(
                  //       bottom: BorderSide(
                  //         color: isDark
                  //             ? const Color(0xff1B1B1B)
                  //             : const Color(0xffE9EBF8),
                  //         width: 1.5,
                  //       ),
                  //     ),
                  //   ),
                  //   alignment: Alignment.center,
                  //   child: ListView.separated(
                  //     scrollDirection: Axis.horizontal,
                  //     itemCount: tags.length,
                  //     padding: const EdgeInsets.symmetric(horizontal: 13),
                  //     separatorBuilder: (_, __) => const SizedBox(width: 10),
                  //     itemBuilder: (context, index) {
                  //       return Align(
                  //         alignment: Alignment.center,
                  //         child: Material(
                  //           color: Colors.transparent,
                  //           child: InkWell(
                  //             borderRadius: BorderRadius.circular(24),
                  //             onTap: () {},
                  //             child: Container(
                  //               height: 35,
                  //               padding: const EdgeInsets.symmetric(
                  //                 horizontal: 18,
                  //               ),
                  //               decoration: BoxDecoration(
                  //                 color: isDark
                  //                     ? const Color(0xff0D0D0D)
                  //                     : MyColor.mainWhiteColor,
                  //                 border: Border.all(
                  //                     color: isDark
                  //                         ? MyColor.mainWhiteColor
                  //                             .withOpacity(0.1)
                  //                         : const Color(0xff121212)
                  //                             .withOpacity(0.1)),
                  //                 borderRadius: BorderRadius.circular(24),
                  //               ),
                  //               child: Center(
                  //                 child: Text(
                  //                   tags[index],
                  //                   style: MyStyle.tx12Green.copyWith(
                  //                       color: themedata.tertiary,
                  //                       fontWeight: FontWeight.w500),
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                  // const SizedBox(height: 15),
                  Expanded(
                      child: ListView.separated(
                    itemCount: script.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 18),
                    itemBuilder: (context, index) {
                      final item = script[index];
                      List tags = item.scriptCategories!.split(',');

                      return GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //   builder: (context) => const ScriptDetailScreen(),
                          // ));
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
                                    ? MyColor.outlineDasheColor
                                        .withOpacity(0.25)
                                    : const Color(0xffE9EBF8)),
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: item.image!,
                                   
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(width: 2),
                                    Text(
                                      item.title!,
                                      style: MyStyle.tx18Grey.copyWith(
                                        color: themedata.tertiary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Spacer(),
                                    SvgPicture.asset(
                                        "assets/images/svg/Star.svg",
                                        color: isDark
                                            ? const Color(0xff0B930B)
                                            : MyColor.greenColor),
                                    const SizedBox(width: 4),
                                    Text(
                                      "(${item.reviews})",
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
                                  children: [
                                    ...tags.map((tag) {
                                      return Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Dot(color: MyColor.dark01Color),
                                          const SizedBox(width: 4),
                                          Text(
                                            tag,
                                            style: (MyStyle.tx14Black.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xff6E6D7A),
                                            )),
                                          ),
                                        ],
                                      );
                                    })
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
                                    Expanded(
                                      flex: 3,
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/images/svg/naira.svg",
                                            color: themedata.tertiary,
                                          ),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              formatNumber(
                                                  num.parse(item.price!)),
                                              style: MyStyle.tx20Grey.copyWith(
                                                color: themedata.tertiary,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 14,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            !isDark
                                                ? "assets/images/svg/package-dark.svg"
                                                : "assets/images/svg/package.svg",
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "${item.sales} sales",
                                            style: MyStyle.tx18Grey.copyWith(
                                              color: themedata.tertiary,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
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
                                          model.getScriptDetails(item.id!, () {
                                            Get.to(ScriptDetailScreen(
                                              data: {
                                                "reviews": item.reviews,
                                                "sales": item.sales,
                                              },
                                            ));
                                          });
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
                                      if (Platform.isAndroid)
                                      OutlinedButton(
                                        onPressed: () {
                                          Get.to(BuyScriptSummary(data: {
                                            "image": item.image,
                                            "category": item.scriptCategories,
                                            "title": item.title,
                                            "price": item.price,
                                            "id": item.id,
                                          }));
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
      }),
    );
  }
}
