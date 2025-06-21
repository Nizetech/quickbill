import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/service_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Domain/domain_screen.dart';
import 'package:jost_pay_wallet/Ui/Scripts/script_summary.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';


class ScriptDetailScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  const ScriptDetailScreen({super.key, required this.data});

  @override
  State<ScriptDetailScreen> createState() => _ScriptDetailScreenState();
}

class _ScriptDetailScreenState extends State<ScriptDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final isDark = themeProvider.isDarkMode();
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode()
          ? MyColor.dark02Color
          : MyColor.mainWhiteColor,
      body: SafeArea(
        child: Consumer<ServiceProvider>(builder: (context, model, _) {
          return Padding(
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
                const SizedBox(height: 15),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.scriptDetailModel!.script?.title ?? "",
                        style: MyStyle.tx20Grey.copyWith(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            color: themedata.tertiary),
                      ),
                      const SizedBox(height: 20),
                      HtmlWidget(
                        model.scriptDetailModel!.script?.description ?? "",
                        textStyle: MyStyle.tx18Grey
                          ..copyWith(
                            // fontWeight: FontWeight.w500,
                            color: themeProvider.isDarkMode()
                                ? MyColor.whiteColor
                                : MyColor.blackColor,
                          ),
                      ),
                      const SizedBox(height: 34),
                      Text("Additional details",
                          style: MyStyle.tx20Grey.copyWith(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              color: themedata.tertiary)),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          DotLabel(text: "Creator", value: "JustPay"),
                          SizedBox(width: 120),
                          DotLabel(
                              text: "Updated",
                              value: formatDateYear(
                                  model.scriptDetailModel!.script!.createdAt!)),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          DotLabel(
                              text: "Reviews",
                              value: widget.data['reviews'].toString()),
                          SizedBox(width: 120),
                          DotLabel(
                              text: "Sales",
                              value: widget.data['sales'].toString()),
                        ],
                      ),
                      const SizedBox(height: 44),
                      OutlinedButton(
                        onPressed: () {
                          // showModalBottomSheet(
                          //   context: context,
                          //   barrierColor:
                          //       const Color(0xffBCBCBC).withOpacity(0.5),
                          //   isScrollControlled: true,
                          //   backgroundColor: Colors.transparent,
                          //   builder: (context) => const DomainModalSheet(),
                          // );
                          Get.to(BuyScriptSummary(data: {
                            "image": model.scriptDetailModel!.script!.image,
                            "id": model.scriptDetailModel!.script!.id,
                            "category": model
                                .scriptDetailModel!.script!.scriptCategories,
                            "title": model.scriptDetailModel!.script!.title,
                            "price": model.scriptDetailModel!.script!.price,
                          }));
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide.none,
                          backgroundColor: themeProvider.isDarkMode()
                              ? const Color(0xff0B930B)
                              : MyColor.greenColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 14),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Purchase for",
                                style: MyStyle.tx14Black.copyWith(
                                  fontFamily: 'SF Pro Rounded',
                                  color: MyColor.mainWhiteColor,
                                  fontWeight: FontWeight.w600,
                                )),
                            SvgPicture.asset(
                              "assets/images/svg/naira.svg",
                              color: MyColor.mainWhiteColor,
                            ),
                            Text(
                                formatNumber(num.parse(
                                    model.scriptDetailModel!.script?.price ??
                                        "0")),
                                style: MyStyle.tx14Black.copyWith(
                                  fontFamily: 'SF Pro Rounded',
                                  color: MyColor.mainWhiteColor,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            // Get.to(PreviewScreen(
                            //   link: model.scriptDetailModel!.script!.demoUrl!,
                            // ));
                            launchWeb(
                                model.scriptDetailModel!.script!.demoUrl!);
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            side: BorderSide(
                                color: themeProvider.isDarkMode()
                                    ? const Color(0xff0B930B)
                                    : MyColor.greenColor,
                                width: 0.6),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 14),
                          ),
                          child: Text("View Demo",
                              style: MyStyle.tx14Black.copyWith(
                                fontFamily: 'SF Pro Rounded',
                                color: themeProvider.isDarkMode()
                                    ? const Color(0xff0B930B)
                                    : MyColor.greenColor,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ))
              ],
            ),
          );
        }),
      ),
    );
  }
}
