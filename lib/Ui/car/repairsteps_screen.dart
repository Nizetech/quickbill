import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Domain/domain_screen.dart';
import 'package:jost_pay_wallet/Ui/car/cardetail_screen.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

class RepairstepsScreen extends StatefulWidget {
  const RepairstepsScreen({super.key});

  @override
  State<RepairstepsScreen> createState() => _RepairstepsScreenState();
}

class _RepairstepsScreenState extends State<RepairstepsScreen> {
  @override
  void initState() {
    super.initState();
  }

  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<Map<String, dynamic>> steps = [
    {
      'title': 'Electrical',
      'items': [
        {'name': 'Collision module', 'price': 'N20,000'},
        {'name': 'Programing', 'price': 'N20,000'},
        {'name': 'Sensor', 'price': 'N13,000'},
      ]
    },
    {
      'title': 'Mechanical',
      'items': [
        {'name': 'Engine seat', 'price': 'N12,000'},
        {'name': 'Engine oil 5w 30', 'price': 'N25,000'},
      ]
    },
    {
      'title': 'Panel work',
      'items': [
        {'name': 'Fendor', 'price': 'N12,000'},
      ]
    },
    {
      'title': 'Washing',
      'items': [
        {'name': 'Complete wash', 'price': 'N10,000'},
      ]
    },
  ];

  void nextPage() {
    if (_currentIndex < 3) {
      _controller.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  Widget buildItem(
    String name,
    String price,
  ) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final isDark = themeProvider.isDarkMode();
    final themedata = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name,
                style: MyStyle.tx16Black.copyWith(
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff6E6D7A),
                )),
            Text(price,
                style: MyStyle.tx16Black.copyWith(
                  fontWeight: FontWeight.w600,
                  color: themedata.tertiary,
                )),
          ],
        ),
        const SizedBox(height: 7),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              color: isDark ? MyColor.dark02Color : MyColor.mainWhiteColor),
          child: Text("Skip",
              style: MyStyle.tx14Black.copyWith(
                fontWeight: FontWeight.w500,
                color: isDark ? const Color(0xff0B930B) : MyColor.greenColor,
              )),
        ),
        const SizedBox(height: 10),
        Divider(
          height: 0.7,
          color: isDark ? const Color(0xff1B1B1B) : const Color(0xffE9EBF8),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget buildStep(int index) {
    final step = steps[index];

    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    final isDark = themeProvider.isDarkMode();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xff181818) : const Color(0xffF4F4F4),
          ),
          child: Row(
            children: [
              Container(
                padding: index + 1 != 1
                    ? const EdgeInsets.all(5)
                    : const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDark
                      ? const Color(0xffC8FBC8)
                      : const Color(0xff043704),
                ),
                child: index + 1 != 1
                    ? Icon(Icons.check,
                        size: 13,
                        color: isDark
                            ? MyColor.dark02Color
                            : MyColor.mainWhiteColor)
                    : Text(
                        "${index + 1}",
                        style: MyStyle.tx16Black.copyWith(
                          fontWeight: FontWeight.w400,
                          color: isDark
                              ? MyColor.dark02Color
                              : MyColor.mainWhiteColor,
                        ),
                      ),
              ),
              if (index + 1 != 1) ...[
                const SizedBox(width: 10),
                Container(height: 20, color: const Color(0xffB3D6B3), width: 2),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color:
                        isDark ? MyColor.dark02Color : MyColor.mainWhiteColor,
                    shape: BoxShape.circle,
                  ),
                  child: Text(index + 2 > 4 ? "4" : "${index + 2}",
                      style: MyStyle.tx16Black.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: themedata.tertiary,
                      )),
                ),
              ],
              const SizedBox(width: 11),
              Text(index == 0 ? "Section" : step['title'],
                  style: MyStyle.tx16Black.copyWith(
                    fontWeight: FontWeight.w400,
                    color: themedata.tertiary,
                  )),
              const Spacer(),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color:
                          isDark ? MyColor.dark02Color : MyColor.mainWhiteColor,
                      shape: BoxShape.circle,
                    ),
                    child: Text(index + 2 > 4 ? "4" : "${index + 2}",
                        style: MyStyle.tx16Black.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: themedata.tertiary,
                        )),
                  ),
                  const SizedBox(width: 10),
                  Container(
                      height: 20, color: const Color(0xffB3D6B3), width: 2),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color:
                          isDark ? MyColor.dark02Color : MyColor.mainWhiteColor,
                      shape: BoxShape.circle,
                    ),
                    child: Text("4",
                        style: MyStyle.tx16Black.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: themedata.tertiary,
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xff0D0D0D) : MyColor.mainWhiteColor,
            border: Border.all(
                color:
                    isDark ? const Color(0xff1B1B1B) : const Color(0xffE9EBF8)),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            step['title'],
            style: MyStyle.tx12Green.copyWith(
                color: themedata.tertiary, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 25),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color:
                    isDark ? const Color(0xff101010) : const Color(0xffFCFCFC),
                border: Border.all(
                    color: isDark
                        ? const Color(0xff1B1B1B)
                        : const Color(0xffE9EBF8))),
            child: Column(
              children: [
                ...step['items']
                    .map<Widget>((item) => buildItem(
                          item['name'],
                          item['price'],
                        ))
                    .toList(),
              ],
            )),
        const SizedBox(height: 23),
        if (index != 3)
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                nextPage();
                setState(() => _currentIndex++);
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide.none,
                backgroundColor: themeProvider.isDarkMode()
                    ? const Color(0xff0B930B)
                    : MyColor.greenColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 11),
              ),
              child: Text("Next",
                  style: MyStyle.tx14Black.copyWith(
                    fontFamily: 'SF Pro Rounded',
                    color: MyColor.mainWhiteColor,
                    fontWeight: FontWeight.w600,
                  )),
            ),
          )
        else
          Column(
            children: [
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 19),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xff101010)
                      : const Color(0xffFCFCFC),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Section",
                      style: MyStyle.tx16Black.copyWith(
                        color: const Color(0xff6E6D7A),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "3 Services",
                      style: MyStyle.tx16Black.copyWith(
                        color: themedata.tertiary,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 19),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Cost",
                      style: MyStyle.tx16Black.copyWith(
                        color: const Color(0xff6E6D7A),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "N250,000",
                      style: MyStyle.tx16Black.copyWith(
                        color: themedata.tertiary,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
                color:
                    isDark ? const Color(0xff1B1B1B) : const Color(0xffE9EBF8),
              ),
              const SizedBox(height: 38),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide.none,
                  backgroundColor: themeProvider.isDarkMode()
                      ? const Color(0xff0B930B)
                      : MyColor.greenColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 11),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/images/svg/share.svg",
                      color: MyColor.mainWhiteColor,
                    ),
                    const SizedBox(width: 12),
                    Text("Share invoice",
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
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: BorderSide(
                        color: themeProvider.isDarkMode()
                            ? const Color(0xff0B930B)
                            : MyColor.greenColor,
                        width: 0.6),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 11),
                  ),
                  child: Text("Back to history",
                      style: MyStyle.tx14Black.copyWith(
                        fontFamily: 'SF Pro Rounded',
                        color: themeProvider.isDarkMode()
                            ? const Color(0xff0B930B)
                            : MyColor.greenColor,
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ),
            ],
          )
      ],
    );
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
                      if (_currentIndex > 0) {
                        _controller.previousPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut);
                        setState(() => _currentIndex--);
                      } else {
                        Navigator.pop(context);
                      }
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
                      'Repair/Service History',
                      style:
                          MyStyle.tx18Black.copyWith(color: themedata.tertiary),
                    ),
                  ),
                  const Spacer(), // Adds flexible space after the text
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: steps.length,
                  itemBuilder: (context, index) => buildStep(index),
                ),
              ),
            ],
          )),
    );
  }
}
