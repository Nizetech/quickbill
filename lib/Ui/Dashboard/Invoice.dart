import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Provider/DashboardProvider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:provider/provider.dart';

class Invoice extends StatefulWidget {
  const Invoice({super.key});

  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> data = [
    {
      'name': 'Azeez Maxwell',
      'amount': 'N 7,120.00',
      'date': 'JNYUFDESA 2024-06-22',
      'status': 'Awaiting payment'
    },
    {
      'name': 'Azeez Maxwell',
      'amount': 'N 7,120.00',
      'date': 'JNYUFDESA 2024-06-22',
      'status': 'Payment overdue'
    },
    {
      'name': 'Azeez Maxwell',
      'amount': 'N 7,120.00',
      'date': 'JNYUFDESA 2024-06-22',
      'status': 'Payment pending'
    },
    {
      'name': 'Azeez Maxwell',
      'amount': 'N 7,120.00',
      'date': 'JNYUFDESA 2024-06-22',
      'status': 'Awaiting payment'
    },
  ];
  final Map<dynamic, dynamic> colorSetting = {
    'Awaiting payment': MyColor.orangeColor,
    'Payment overdue': MyColor.redColor,
    'Payment pending': MyColor.yellowColor
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;

    final dashProvider = Provider.of<DashboardProvider>(context, listen: true);
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(
          top: 70.0, // Top padding
          left: 24.0, // Left padding
          right: 24.0,
        ), // Padding around the widget
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Image widget
            Container(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: ()=>       dashProvider.changeBottomIndex(0),
                      child: Image.asset(
                        'assets/images/arrow_left.png',
                        color: themeProvider.isDarkMode()
                            ? MyColor.mainWhiteColor
                            : MyColor.dark01Color,
                      ),
                    ),
                    const Spacer(), // Adds flexible space between the image and the text
                    Text(
                      'Invoice',
                      style: MyStyle.tx18Black.copyWith(
                        color: themedata.tertiary,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: 104,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: MyColor.splashBtn,
                          borderRadius: BorderRadius.circular(22.5)),
                      child: const Text(
                        'Create new',
                        style: MyStyle.tx14White,
                      ),
                    ) // Adds flexible space after the text
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                  controller: _controller,
                  decoration: NewStyle.authInputDecoration.copyWith(
                    hintText: 'Search Invoices',
                    fillColor: themeProvider.isDarkMode()
                        ? const Color(0XFF33353C)
                        : MyColor.textFieldFillColor,
                  ),
                )),
                const SizedBox(
                  width: 12,
                ),
                Container(
                  width: 64,
                  height: 56,
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(
                        color: MyColor.borderColor,
                        width: 1,
                      )),
                  child: Image.asset(
                    'assets/images/filter.png',
                    width: 20.3,
                    height: 20.3,
                    color: themedata.tertiary,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              // child: SingleChildScrollView(
              child: ListView.builder(
                  itemCount: data.length,
                  padding: const EdgeInsets.all(0),
                  itemBuilder: (context, index) {
                    var list = data[index];
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: index == 0
                                  ? const BorderRadius.only(
                                      topLeft: Radius.circular(9),
                                      topRight: Radius.circular(9))
                                  : index == data.length - 1
                                      ? const BorderRadius.only(
                                          bottomLeft: Radius.circular(9),
                                          bottomRight: Radius.circular(9))
                                      : BorderRadius.circular(0),
                              border: Border.all(
                                color: themeProvider.isDarkMode()
                                    ? MyColor.borderDarkColor
                                    : MyColor
                                        .borderColor, // Set the color of the border
                                width: 0.5,
                              )),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      list['name'],
                                      style: MyStyle.tx12Black.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: themedata.tertiary),
                                    ),
                                    const SizedBox(
                                      height: 9,
                                    ),
                                    Text(
                                      list['date'],
                                      style: MyStyle.tx12Black.copyWith(
                                          color: themeProvider.isDarkMode()
                                              ? const Color(0XFFCBD2EB)
                                              : const Color(0xff30333A)),
                                    )
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        list['amount'],
                                        style: MyStyle.tx12Black.copyWith(
                                            color: themedata.tertiary),
                                      ),
                                      const SizedBox(
                                        height: 9,
                                      ),
                                      Container(
                                          width: 104,
                                          decoration: BoxDecoration(
                                              color:
                                                  colorSetting[list['status']],
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              boxShadow: const [
                                                MyStyle.widgetShadow
                                              ]),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 2),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(list['status'],
                                                    style: MyStyle.tx12White),
                                              ],
                                            ),
                                          ))
                                    ])
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
              // ),
            ),
            const SizedBox(
              height: 90,
            )
          ],
        ),
      ),
    );
  }
}
