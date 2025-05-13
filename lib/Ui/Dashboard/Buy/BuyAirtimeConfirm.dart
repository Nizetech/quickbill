import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/AddFunds.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Buy/BuyAirtime.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Buy/BuyAirtimeConfirmDetail.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/NewColor.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';

class BuyAirtimeConfirm extends StatefulWidget {
  const BuyAirtimeConfirm({super.key});

  @override
  State<BuyAirtimeConfirm> createState() => _BuyAirtimeConfirmState();
}

class _BuyAirtimeConfirmState extends State<BuyAirtimeConfirm> {
  final TextEditingController _controller = TextEditingController();

  final List<Map<String, dynamic>> data = [
    {'img': 'assets/images/operator-1.png', 'title': 'MTN'},
    {'img': 'assets/images/operator-2.png', 'title': 'Airtel'},
    {'img': 'assets/images/operator-3.png', 'title': 'Glo'},
    {'img': 'assets/images/operator-1.png', 'title': 'MTN'},
    {'img': 'assets/images/operator-2.png', 'title': 'Airtel'},
    {'img': 'assets/images/operator-3.png', 'title': 'Glo'}
  ];

  int selectedItem = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 54,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BuyAirtime())),
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
                      'Buy Airtime',
                      style:
                          MyStyle.tx18Black.copyWith(color: themedata.tertiary),
                    ),
                  ),
                  const Spacer(), // Adds flexible space after the text
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 125,
              margin: const EdgeInsets.symmetric(horizontal: 24.0),
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
                            Image.asset(
                              'assets/images/currency.png',
                              width: 15,
                              color: themedata.tertiary,
                            ),
                            Text(
                              '10,000.',
                              style: MyStyle.tx32Black.copyWith(
                                color: themedata.tertiary,
                              ),
                            ),
                            Text(
                              '20',
                              style: MyStyle.tx20Grey.copyWith(
                                color: themedata.tertiary,
                              ),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select Mobile Operator',
                  style: MyStyle.tx12Grey.copyWith(
                    color: themedata.tertiary,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
                height: 90,
                child: ListView.builder(
                    itemCount: data.length,
                    padding: const EdgeInsets.only(left: 24),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var item = data[index];
                      return SizedBox(
                        width: 86.w,
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
                                  ? Stack(
                                      // crossAxisAlignment:
                                      //     CrossAxisAlignment.start,
                                      // mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(item['img']),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 2.r, right: 8.r),
                                            child: Icon(
                                              Icons.check_circle,
                                              // Image.asset(
                                              //   'assets/images/checked.png',
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                            ),
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
            Expanded(
                child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.end, // Aligns vertically centered
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
                              child: const Center(
                                child: Text(
                                  '***',
                                  style: MyStyle.tx16Green,
                                ),
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
                            controller: _controller,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: themedata.tertiary,
                              fontFamily: 'SF Pro Rounded',
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Enter Mobile number',
                              hintStyle: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF999999),
                                fontFamily: 'SF Pro Rounded',
                              ),

                              border: InputBorder
                                  .none, // No border for the TextFormField
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
                      const Text(
                        'Choose Contact',
                        style: MyStyle.tx12GreenUnder,
                      )
                    ],
                  ),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Best Rate',
                      style:
                          MyStyle.tx14Black.copyWith(color: themedata.tertiary),
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
                            width: 0.5),
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
                                              const Buyairtimeconfirmdetail())),
                                  child: Container(
                                    width: 100,
                                    height: 62,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: themedata.secondary,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      children: [
                                        const Spacer(),
                                        const Text(
                                          'N500',
                                          style: MyStyle.tx14Green,
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
                                            'Pay N500',
                                            style: MyStyle.tx12Black.copyWith(
                                                color: MyColor.greenColor),
                                          ),
                                        ),
                                        const Spacer(),
                                      ],
                                    ),
                                  )),
                              const Spacer(),
                              GestureDetector(
                                  onTap: () => Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Buyairtimeconfirmdetail())),
                                  child: Container(
                                    width: 100,
                                    height: 62,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: themedata.secondary,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      children: [
                                        const Spacer(),
                                        const Text(
                                          'N500',
                                          style: MyStyle.tx14Green,
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
                                            'Pay N500',
                                            style: MyStyle.tx12Black.copyWith(
                                                color: MyColor.greenColor),
                                          ),
                                        ),
                                        const Spacer(),
                                      ],
                                    ),
                                  )),
                              const Spacer(),
                              GestureDetector(
                                  onTap: () => Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Buyairtimeconfirmdetail())),
                                  child: Container(
                                    width: 100,
                                    height: 62,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: themedata.secondary,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      children: [
                                        const Spacer(),
                                        const Text(
                                          'N500',
                                          style: MyStyle.tx14Green,
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
                                            'Pay N500',
                                            style: MyStyle.tx12Black.copyWith(
                                                color: MyColor.greenColor),
                                          ),
                                        ),
                                        const Spacer(),
                                      ],
                                    ),
                                  )),
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
                                              const Buyairtimeconfirmdetail())),
                                  child: Container(
                                    width: 100,
                                    height: 62,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: themedata.secondary,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      children: [
                                        const Spacer(),
                                        const Text(
                                          'N500',
                                          style: MyStyle.tx14Green,
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
                                            'Pay N500',
                                            style: MyStyle.tx12Black.copyWith(
                                                color: MyColor.greenColor),
                                          ),
                                        ),
                                        const Spacer(),
                                      ],
                                    ),
                                  )),
                              const Spacer(),
                              GestureDetector(
                                  onTap: () => Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Buyairtimeconfirmdetail())),
                                  child: Container(
                                    width: 100,
                                    height: 62,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: themedata.secondary,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      children: [
                                        const Spacer(),
                                        const Text(
                                          'N500',
                                          style: MyStyle.tx14Green,
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
                                            'Pay N500',
                                            style: MyStyle.tx12Black.copyWith(
                                                color: MyColor.greenColor),
                                          ),
                                        ),
                                        const Spacer(),
                                      ],
                                    ),
                                  )),
                              const Spacer(),
                              GestureDetector(
                                  onTap: () => Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Buyairtimeconfirmdetail())),
                                  child: Container(
                                    width: 100,
                                    height: 62,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: themedata.secondary,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      children: [
                                        const Spacer(),
                                        const Text(
                                          'N500',
                                          style: MyStyle.tx14Green,
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
                                            'Pay N500',
                                            style: MyStyle.tx12Black.copyWith(
                                                color: MyColor.greenColor),
                                          ),
                                        ),
                                        const Spacer(),
                                      ],
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: MyColor.borderColor, width: 0.5))),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/currency.png',
                          width: 16,
                          color: themedata.tertiary,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: TextFormField(
                          // controller: _controller,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: themedata.tertiary,
                            fontFamily: 'SF Pro Rounded',
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Enter an amount',
                            hintStyle: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF999999),
                              fontFamily: 'SF Pro Rounded',
                            ),
                            border: InputBorder
                                .none, // No border for the TextFormField
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10), // Adjust as needed
                          ),
                        ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: MyColor.greenColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const Buyairtimeconfirmdetail()));
                      },
                      child: Text(
                        "Confirm",
                        style: NewStyle.btnTx16SplashBlue
                            .copyWith(color: NewColor.mainWhiteColor),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
