import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jost_pay_wallet/Provider/service_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Paint/paint_screen.dart';
import 'package:jost_pay_wallet/Ui/Paint/widget/spray_history.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';
import '../Domain/widget/dot.dart';

class PaintHistory extends StatefulWidget {
  const PaintHistory({super.key});

  @override
  State<PaintHistory> createState() => _PaintHistoryState();
}

class _PaintHistoryState extends State<PaintHistory> {
  @override

  void initState() {
    super.initState();
    final service = Provider.of<ServiceProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      service.getCarTypes();
      service.getColorPaint();
      service.getSprayHistory();
    });
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
        body: Consumer<ServiceProvider>(builder: (context, model, _) {
          return RefreshIndicator(
            onRefresh: () async {
              model.getSprayHistory();
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
                          'Paint & Spray booth',
                          style: MyStyle.tx18Black
                              .copyWith(color: themedata.tertiary),
                        ),
                      ),
                      const Spacer(), // Adds flexible space after the text
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PaintScreen(),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 11),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? const Color(0xff181818)
                                    : const Color(0xffF4F4F4),
                                border: Border(
                                  right: BorderSide(
                                    color: isDark
                                        ? const Color(0xffC8FBC8)
                                        : const Color(0xff043704),
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isDark
                                          ? const Color(0xffC8FBC8)
                                          : const Color(0xff043704),
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/images/svg/paint.svg',
                                      width: 20,
                                      height: 20,
                                      color: isDark
                                          ? MyColor.dark02Color
                                          : MyColor.mainWhiteColor,
                                    ),
                                  ),
                                  const SizedBox(width: 11),
                                  Text("Rent Spray Booth/Hire Painter",
                                      style: MyStyle.tx16Black.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: themedata.tertiary,
                                      )),
                                  const SizedBox(width: 10),
                                  SvgPicture.asset(
                                    'assets/images/svg/line.svg',
                                    width: 28,
                                    color: isDark
                                        ? MyColor.mainWhiteColor
                                        : Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                vertical: 14, horizontal: 19),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: isDark
                                      ? const Color(0xff1B1B1B)
                                      : const Color(0xffE9EBF8),
                                  width: 2,
                                ),
                              ),
                              color: isDark
                                  ? const Color(0xff101010)
                                  : const Color(0xffFCFCFC),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Paint History",
                              style: MyStyle.tx20Grey.copyWith(
                                fontWeight: FontWeight.w400,
                                color: themedata.tertiary,
                              ),
                            ),
                          ),
                          //  // SprayHistory(),
                          if (model.sprayHistoryModel != null)
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.only(bottom: 20),
                              itemCount:
                                  model.sprayHistoryModel!.history!.length,
                              separatorBuilder: (_, i) => SizedBox(height: 16),
                              itemBuilder: (_, i) => SprayHistory(
                                history: model.sprayHistoryModel!.history![i],
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        ));
  }
}

class StatusIndicator extends StatelessWidget {
  final String text;
  final Color color;
  const StatusIndicator({
    super.key,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text,
            style: MyStyle.tx14White.copyWith(
              fontWeight: FontWeight.w400,
              color: color,
            )),
        const SizedBox(width: 8),
        Dot(
          color: color,
          size: 15,
        )
      ],
    );
  }
}
