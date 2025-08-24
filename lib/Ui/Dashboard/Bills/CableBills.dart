import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/AddFunds.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Electricity/ElectricityConfirm.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/NewColor.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';

import '../../../bottom_nav.dart';

class CableBills extends StatefulWidget {
  const CableBills({super.key});


  @override
  State<CableBills> createState() => _CableBillsState();
}

class _CableBillsState extends State<CableBills> {

  final TextEditingController _controller = TextEditingController();
  final List<String> dayItems = ['Daily', 'Daily', 'Night', 'Weekend', 'Weekly', 'Monthly', 'Yearly'];
  final List<String> _items = ['Yanga', 'Yanga1', 'Yanga2', 'Yanga3'];
  final List<String> _packageItems = ['Package', 'Package1', 'Package2', 'Package3'];
  int selectedDay = 0;
  String _selectedItem = 'Yanga';
  String _selectedPackageItem = '';

  final List<Map<String,dynamic>> data = [
    {
      'img': 'assets/images/cable-1.png',
      'title': 'DSTV'
    },
    {
      'img': 'assets/images/cable-2.png',
      'title': 'Startimes'
    },
    {
      'img': 'assets/images/cable-3.png',
      'title': 'GOTV'
    },
    {
      'img': 'assets/images/cable-1.png',
      'title': 'DSTV'
    },
    {
      'img': 'assets/images/cable-2.png',
      'title': 'Startimes'
    },
    {
      'img': 'assets/images/cable-3.png',
      'title': 'GOTV'
    },
  ];
  int selectedItem = 0;
  String selectedBundle = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                          builder: (context) => const BottomNav())),
                  child: Image.asset(
                    'assets/images/arrow_left.png',
                  ),
                ),
                const Spacer(),
                Transform.translate(
                  offset: const Offset(-20, 0),
                  child: const Text(
                    'Cable Bills',
                    style: MyStyle.tx18Black,
                  ),
                ),
                const Spacer(), // Adds flexible space after the text
              ],
            ),
            const SizedBox(height: 30,),
            Container(
              height: 125,
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 0.8,
                      color: MyColor.borderColor
                  ),
                  borderRadius: BorderRadius.circular(16)
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        const Text('Total balance', style: MyStyle.tx12Grey,),
                        Row(
                          children: [
                            Image.asset('assets/images/currency.png', width: 15,),
                            const Text('10,000.', style: MyStyle.tx32Black,),
                            const Text('20', style: MyStyle.tx20Grey,)
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
                        padding: const EdgeInsets.only(top: 6, bottom: 6, left: 24, right: 12),
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
            const SizedBox(height: 30,),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Select service provider', style: MyStyle.tx12Grey,),
            ),
            const SizedBox(height: 8,),
            SizedBox(
                height: 90,
                child: ListView.builder(
                    itemCount: data.length,
                    padding: const EdgeInsets.all(0),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var item = data[index];
                      return Padding(
                        padding: EdgeInsets.only(right: selectedItem == index ? 0 : 15),
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
                              child: selectedItem == index ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(item['img']),
                                  Transform.translate(offset: const Offset(-18, 4), child: Image.asset('assets/images/checked.png',),)
                                ],
                              ) : Image.asset(item['img']),
                            ),
                            const SizedBox(height: 4,),
                            Text(item['title'], style: MyStyle.tx12Black.copyWith(
                                fontFamily: 'SF Pro Rounded',
                                color: selectedItem == index ? MyColor.greenColor : MyColor.blackColor
                            ),)
                          ],
                        ),
                      );
                    }
                )
            ),
            const SizedBox(height: 30,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center, // Aligns vertically centered
              children: [
                // Container with a placeholder or icon
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 9),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 1,
                              color: MyColor.borderColor
                          )
                      )
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: MyColor.grey01Color,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          '***',
                          style: MyStyle.tx16Green,
                        ),
                      ),
                      const SizedBox( width: 20,)
                    ],
                  ),
                ),
                // Expanded TextFormField for mobile number input
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: MyColor.borderColor,
                        ),
                      ),
                    ),
                    child: TextFormField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Enter IUC /Smart Card Number',
                        hintStyle: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF999999),
                          fontFamily: 'SF Pro Rounded',
                        ),
                        border: InputBorder.none, // No border for the TextFormField
                        contentPadding: EdgeInsets.symmetric(vertical: 10), // Adjust as needed
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  width: 110, // Set the width of the dropdown button
                  height: 44, // Set the height of the dropdown button
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: MyColor.greenColor,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: const Center(
                        child: Text(
                          'Select a color',
                          style: MyStyle.tx12Green,
                        ),
                      ),
                      value: _selectedItem,
                      style: MyStyle.tx12Green,
                      icon: Image.asset(
                        'assets/images/arrow-green.png',
                        width: 24,
                        height: 24,
                      ),
                      items: _items.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Center(
                            child: Text(
                              value,
                              style: MyStyle.tx12Green,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedItem = newValue ?? '';
                        });
                      },
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Select service provider', style: MyStyle.tx12Grey,),
            ),
            const SizedBox(height: 8,),
            Container(
              width: double.infinity,
              color: MyColor.grey01Color,
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: DropdownButton<String>(
                hint: const Text('Please select your package', style: MyStyle.tx12Grey,),
                isExpanded: true,
                items: _packageItems.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                underline: Container(),
                icon: Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset('assets/images/arrow-down.png'),
                ),
                iconSize: 24,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedPackageItem =
                        newValue ?? ''; // Update the selected item
                  });
                },
              ),
            ),
            const Spacer(),
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
                          builder: (context) => const ElectricityConfirm()));
                },
                child: Text(
                  "Confirm",
                  style: NewStyle.btnTx16SplashBlue
                      .copyWith(color: NewColor.mainWhiteColor),
                ),
              ),
            ),
            const SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }
}
