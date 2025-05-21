import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Domain/domain_screen.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

class RewardRecordScreen extends StatefulWidget {
  const RewardRecordScreen({super.key});

  @override
  State<RewardRecordScreen> createState() => _RewardRecordScreenState();
}

class _RewardRecordScreenState extends State<RewardRecordScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isSelected = true;
  bool isSelected2 = false;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    final isDark = themeProvider.isDarkMode();
    return Scaffold(
        backgroundColor: themeProvider.isDarkMode()
            ? MyColor.dark02Color
            : MyColor.mainWhiteColor,
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 68)
                .copyWith(bottom: 0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                      'Rewards',
                      style: MyStyle.tx18Black.copyWith(
                          color: themedata.tertiary,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const Spacer(), // Adds flexible space after the text
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isSelected = true;
                        isSelected2 = false;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1.5,
                                color: isSelected
                                    ? (isDark
                                        ? const Color(0xff0B930B)
                                        : MyColor.greenColor)
                                    : isDark
                                        ? const Color(0xff1B1B1B)
                                        : const Color(0xffE9EBF8))),
                        color: isDark
                            ? const Color(0xff101010)
                            : const Color(0xffFCFCFC),
                      ),
                      child: Text(
                        "Current Task",
                        style: MyStyle.tx16Black.copyWith(
                            color: themedata.tertiary,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isSelected = false;
                        isSelected2 = true;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1.5,
                                color: isSelected2
                                    ? (isDark
                                        ? const Color(0xff0B930B)
                                        : MyColor.greenColor)
                                    : isDark
                                        ? const Color(0xff1B1B1B)
                                        : const Color(0xffE9EBF8))),
                        color: isDark
                            ? const Color(0xff101010)
                            : const Color(0xffFCFCFC),
                      ),
                      child: Text(
                        "History",
                        style: MyStyle.tx16Black.copyWith(
                            color: themedata.tertiary,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              ]),

              const SizedBox(height: 29),

              // Card

              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 17),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: isDark
                          ? MyColor.outlineDasheColor.withOpacity(0.25)
                          : const Color(0xffE9EBF8)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DotLabel(
                          text: "Reg date",
                          value: "Jan 23,2025 02:48PM",
                          dotColor: MyColor.dark01Color,
                          labelColor: const Color(0xff6E6D7A),
                          textColor: isDark
                              ? MyColor.mainWhiteColor
                              : MyColor.blackColor,
                        ),
                        DotLabel(
                          text: "First Name",
                          dotColor: MyColor.dark01Color,
                          value: "Anthonia",
                          labelColor: const Color(0xff6E6D7A),
                          textColor: isDark
                              ? MyColor.mainWhiteColor
                              : MyColor.blackColor,
                        ),
                      ],
                    ),
                    const SizedBox(height: 29),
                    Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DotLabel(
                            text: "Rewarded at",
                            value: "Jan 23,2025 04: 12PM",
                            dotColor: MyColor.dark01Color,
                            labelColor: const Color(0xff6E6D7A),
                            textColor: isDark
                                ? MyColor.mainWhiteColor
                                : MyColor.blackColor,
                          ),
                          DotLabel(
                            text: "Amount",
                            value: "300",
                            dotColor: MyColor.dark01Color,
                            labelColor: const Color(0xff6E6D7A),
                            textColor: isDark
                                ? MyColor.mainWhiteColor
                                : MyColor.blackColor,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: BorderSide.none,
                          backgroundColor:
                              const Color(0xff12B76A).withOpacity(0.09),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 10),
                        ),
                        child: Text("Funded",
                            style: MyStyle.tx16Black.copyWith(
                              color: isDark
                                  ? const Color(0xff0B930B)
                                  : MyColor.greenColor,
                              fontWeight: FontWeight.w400,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ])));
  }
}

class InfoColumn extends StatelessWidget {
  final String title;
  final String value;

  const InfoColumn({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 6),
          child: Icon(Icons.circle, size: 6, color: Colors.black54),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(fontSize: 12, color: Colors.black54)),
            const SizedBox(height: 4),
            Text(value,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          ],
        ),
      ],
    );
  }
}

class CustomUnderlineTabIndicator extends Decoration {
  final BorderSide borderSide;
  final EdgeInsetsGeometry insets;

  const CustomUnderlineTabIndicator({
    this.borderSide = const BorderSide(width: 2.0, color: Colors.green),
    this.insets = EdgeInsets.zero,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomUnderlinePainter(this, onChanged);
  }
}

class _CustomUnderlinePainter extends BoxPainter {
  final CustomUnderlineTabIndicator decoration;

  _CustomUnderlinePainter(this.decoration, VoidCallback? onChanged)
      : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect rect = offset & configuration.size!;
    final TextDirection textDirection = configuration.textDirection!;
    final Rect indicator =
        decoration.insets.resolve(textDirection).deflateRect(rect);

    final double indicatorWidth =
        configuration.size!.width / 2.2; // tight to text width
    final double dx = rect.left + (rect.width - indicatorWidth) / 2;
    final double dy = rect.bottom - decoration.borderSide.width;

    final Paint paint = decoration.borderSide.toPaint();
    canvas.drawLine(
      Offset(dx, dy),
      Offset(dx + indicatorWidth, dy),
      paint,
    );
  }
}
