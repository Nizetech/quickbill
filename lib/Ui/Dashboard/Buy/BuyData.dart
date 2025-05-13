import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Buy/BuyDataConfirm.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

import '../AddFunds.dart';
import '../DashboardScreen.dart';

class BuyData extends StatefulWidget {
  const BuyData({super.key});

  @override
  State<BuyData> createState() => _BuyDataState();
}

class _BuyDataState extends State<BuyData> {
  final TextEditingController _controller = TextEditingController();
  final List<String> dayItems = [
    'Daily',
    'Daily',
    'Night',
    'Weekend',
    'Weekly',
    'Monthly',
    'Yearly'
  ];
  int selectedDay = 0;

  final List<Map<String, dynamic>> data = [
    {'img': 'assets/images/operator-1.png', 'title': 'MTN'},
    {'img': 'assets/images/operator-2.png', 'title': 'Airtel'},
    {'img': 'assets/images/operator-3.png', 'title': 'Glo'},
    {'img': 'assets/images/operator-1.png', 'title': 'MTN'},
    {'img': 'assets/images/operator-2.png', 'title': 'Airtel'},
    {'img': 'assets/images/operator-3.png', 'title': 'Glo'}
  ];

  final List<Map<String, dynamic>> bundles = [
    {'title': '1GB(1 day)', 'price': 'N350', 'reduce': '5% off'},
    {'title': '1GB(1 day)', 'price': 'N350', 'reduce': '5% off'},
    {'title': '1GB(1 day)', 'price': 'N350', 'reduce': '5% off'},
  ];

  int selectedItem = 0;
  String selectedBundle = '';

  void _showBottomSheet(BuildContext context, {bool? isDarkMode}) {
    final themedata = Theme.of(context).colorScheme;
    // final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          height: 600,
          decoration:
              BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: isDarkMode ?? false
                                ? MyColor.borderDarkColor
                                : MyColor.borderColor,
                            width: 1))),
                child: Row(
                  children: [
                    Text(
                      selectedBundle == '' ? 'Select a Bundle' : selectedBundle,
                      style: MyStyle.tx12Grey,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 35,
                        width: 35,
                        // padding: const EdgeInsets.all(13),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: themedata.secondary, shape: BoxShape.circle),
                        child: const Icon(Icons.close),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (int i = 0; i < 10; i++) ...[
                      Row(
                        children: [
                          for (int j = 0; j < 3; j++) ...[
                            InkWell(
                              onTap: () => {
                                setState(() {
                                  selectedBundle = '1GB(1 day)';
                                })
                              },
                              child: GestureDetector(
                                onTap: () => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const BuyDataConfirm())),
                                child: Container(
                                  width: 100,
                                  height: 78,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: themedata.secondary
                                          .withValues(alpha: 0.3),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Column(
                                    children: [
                                      const Spacer(),
                                      Text(
                                        '1GB(1 day)',
                                        style: MyStyle.tx12Black.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: themedata.tertiary,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      const Text(
                                        'N50',
                                        style: MyStyle.tx12Grey,
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Container(
                                        width: 72,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: themedata.secondary,
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        child: Text(
                                          '5% off',
                                          style: MyStyle.tx12Black.copyWith(
                                              color: MyColor.greenColor),
                                        ),
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                          ]
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      )
                    ]
                  ],
                ),
              ))
            ],
          ),
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // Set all corners to 0 radius
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 54, left: 24, right: 24),
        child: Column(
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
                    'Buy Data',
                    style:
                        MyStyle.tx18Black.copyWith(color: themedata.tertiary),
                  ),
                ),
                const Spacer(), // Adds flexible space after the text
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 125,
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.8,
                    color: themeProvider.isDarkMode()
                        ? MyColor.borderDarkColor
                        : MyColor.borderColor,
                  ),
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        const Text(
                          'Total balance',
                          style: MyStyle.tx12Grey,
                        ),
                        Row(
                          children: [
                            Image.asset('assets/images/currency.png',
                                width: 15, color: themedata.tertiary),
                            Text(
                              '10,000.',
                              style: MyStyle.tx32Black
                                  .copyWith(color: themedata.tertiary),
                            ),
                            Text(
                              '20',
                              style: MyStyle.tx20Grey
                                  .copyWith(color: themedata.tertiary),
                            )
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () => {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddFunds()))
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: MyColor.greenColor,
                        padding: const EdgeInsets.only(
                            top: 6, bottom: 6, left: 24, right: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Text(
                            "Add fund",
                            style: MyStyle.tx12White,
                          ),
                          Image.asset('assets/images/arrow-up.png')
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Select Mobile Operator',
                style: MyStyle.tx12Grey.copyWith(color: themedata.tertiary),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
                height: 90,
                child: ListView.builder(
                    itemCount: data.length,
                    padding: const EdgeInsets.all(0),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var item = data[index];
                      return Padding(
                        padding: EdgeInsets.only(
                            right: selectedItem == index ? 0 : 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () => {
                                setState(() {
                                  selectedItem = index;
                                })
                              },
                              child: selectedItem == index
                                  ? Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.asset(item['img']),
                                        Transform.translate(
                                          offset: Offset(-24.w, 2.h),
                                          child: Icon(
                                            Icons.check_circle,
                                            // Image.asset(
                                            //   'assets/images/checked.png',
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                          ),
                                        )
                                      ],
                                    )
                                  : Image.asset(item['img']),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              item['title'],
                              style: MyStyle.tx12Black.copyWith(
                                  fontFamily: 'SF Pro Rounded',
                                  color: selectedItem == index
                                      ? MyColor.greenColor
                                      : themedata.tertiary),
                            )
                          ],
                        ),
                      );
                    })),
            const SizedBox(
              height: 30,
            ),
            Row(
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Aligns vertically centered
              children: [
                // Container with a placeholder or icon
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 9),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    width: 1,
                    color: themeProvider.isDarkMode()
                        ? MyColor.borderDarkColor
                        : MyColor.borderColor,
                  ))),
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        padding: EdgeInsets.only(top: 6.h),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: themedata.secondary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          '***',
                          style: MyStyle.tx16Green,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                ),
                // Expanded TextFormField for mobile number input
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: themeProvider.isDarkMode()
                              ? MyColor.borderDarkColor
                              : MyColor.borderColor,
                        ),
                      ),
                    ),
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: themedata.tertiary,
                        fontFamily: 'SF Pro Rounded',
                      ),
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Enter Mobile number',
                        hintStyle: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF999999),
                          fontFamily: 'SF Pro Rounded',
                        ),
                        border:
                            InputBorder.none, // No border for the TextFormField
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10), // Adjust as needed
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                    width:
                        16), // Space between the TextFormField and the "Choose Contact" text
                // "Choose Contact" text
                Transform.translate(
                  offset: const Offset(0, 18),
                  child: const Text(
                    'Choose Contact',
                    style: MyStyle.tx12GreenUnder,
                  ),
                )
              ],
            ),
            const SizedBox(height: 48),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  for (int i = 0; i < dayItems.length; i++) ...[
                    GestureDetector(
                      onTap: () => {
                        setState(() {
                          selectedDay = i;
                        })
                      },
                      child: Text(
                        dayItems[i],
                        style: MyStyle.tx12Grey.copyWith(
                            color: i == selectedDay
                                ? MyColor.greenColor
                                : MyColor.greyColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    if (i != dayItems.length - 1) const Spacer(),
                  ]
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: themeProvider.isDarkMode()
                          ? MyColor.borderDarkColor
                          : MyColor.borderColor,
                      width: 0.2),
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const BuyDataConfirm())),
                          child: Container(
                            width: 100,
                            height: 78,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color:
                                    themedata.secondary.withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              children: [
                                const Spacer(),
                                Text(
                                  '1GB(1 day)',
                                  style: MyStyle.tx12Black.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: themedata.tertiary,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                const Text(
                                  'N50',
                                  style: MyStyle.tx12Grey,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Container(
                                  width: 72,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: themedata.secondary,
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Text(
                                    '5% off',
                                    style: MyStyle.tx12Black
                                        .copyWith(color: MyColor.greenColor),
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const BuyDataConfirm())),
                          child: Container(
                            width: 100,
                            height: 78,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color:
                                    themedata.secondary.withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              children: [
                                const Spacer(),
                                Text(
                                  '1GB(1 day)',
                                  style: MyStyle.tx12Black.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: themedata.tertiary,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                const Text(
                                  'N50',
                                  style: MyStyle.tx12Grey,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Container(
                                  width: 72,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: themedata.secondary,
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Text(
                                    '5% off',
                                    style: MyStyle.tx12Black
                                        .copyWith(color: MyColor.greenColor),
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const BuyDataConfirm())),
                          child: Container(
                            width: 100,
                            height: 78,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color:
                                    themedata.secondary.withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              children: [
                                const Spacer(),
                                Text(
                                  '1GB(1 day)',
                                  style: MyStyle.tx12Black.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: themedata.tertiary,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                const Text(
                                  'N50',
                                  style: MyStyle.tx12Grey,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Container(
                                  width: 72,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: themedata.secondary,
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Text(
                                    '5% off',
                                    style: MyStyle.tx12Black
                                        .copyWith(color: MyColor.greenColor),
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const BuyDataConfirm())),
                          child: Container(
                            width: 100,
                            height: 78,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color:
                                    themedata.secondary.withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              children: [
                                const Spacer(),
                                Text(
                                  '1GB(1 day)',
                                  style: MyStyle.tx12Black.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: themedata.tertiary,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                const Text(
                                  'N50',
                                  style: MyStyle.tx12Grey,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Container(
                                  width: 72,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: themedata.secondary,
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Text(
                                    '5% off',
                                    style: MyStyle.tx12Black
                                        .copyWith(color: MyColor.greenColor),
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const BuyDataConfirm())),
                          child: Container(
                            width: 100,
                            height: 78,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color:
                                    themedata.secondary.withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              children: [
                                const Spacer(),
                                Text(
                                  '1GB(1 day)',
                                  style: MyStyle.tx12Black.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: themedata.tertiary,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                const Text(
                                  'N50',
                                  style: MyStyle.tx12Grey,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Container(
                                  width: 72,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: themedata.secondary,
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Text(
                                    '5% off',
                                    style: MyStyle.tx12Black
                                        .copyWith(color: MyColor.greenColor),
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () => _showBottomSheet(context,
                              isDarkMode: themeProvider.isDarkMode()),
                          child: Container(
                            width: 100,
                            height: 78,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: MyColor.greenColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              children: [
                                const Spacer(),
                                const Text(
                                  '50% off',
                                  style: MyStyle.tx16White,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'See other plans',
                                        style: MyStyle.tx12GreenUnder.copyWith(
                                            color: Colors.white,
                                            fontSize: 9,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: Colors.white),
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      Image.asset('assets/images/arrow-tr.png')
                                    ],
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
