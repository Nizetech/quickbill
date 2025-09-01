import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/service_provider.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/AddFunds.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Buy/widget/balance_action_card.dart';
import 'package:jost_pay_wallet/Ui/electricity/electricity_summary.dart';
import 'package:jost_pay_wallet/Ui/electricity/widget/provider_sheet.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/NewColor.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/common/text_field.dart';
import 'package:jost_pay_wallet/utils/toast.dart';
import 'package:provider/provider.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';

class BuyElectricity extends StatefulWidget {
  final String? package;
  final String? network;
  final String? amount;
  const BuyElectricity({
    super.key,
    this.package,
    this.network,
    this.amount,
  });

  @override
  State<BuyElectricity> createState() => _BuyElectricityState();
}

class _BuyElectricityState extends State<BuyElectricity> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  Map<String, dynamic> selectedService = {};
  Timer? _typingTimer;
  String cableMerchant = '';
  bool saveDetails = false;

  @override
  void initState() {
    super.initState();
    final account = Provider.of<AccountProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      account.getElectServiceDetail();
    });
    _controller.addListener(_onTyping);
    phone.text = account.userModel?.user?.phoneNumber ?? '';
  }

  void _onTyping() {
    if (_typingTimer != null && _typingTimer!.isActive ||
        _controller.text.isEmpty) {
      setState(() {
        cableMerchant = '';
      });
      _typingTimer?.cancel();
    }
    _typingTimer = Timer(Duration(seconds: 3), () {
      resolveMeterNumber();
    });
  }

  void resolveMeterNumber() async {
    final model = Provider.of<ServiceProvider>(context, listen: false);
    if (_controller.text.isEmpty || _controller.text.length < 10) {
      return;
    } else {
      Map<String, dynamic> data = {
        'meter_number': _controller.text,
        'service_id': selectedService['serviceId'],
        'meter_type': meterTypes[selectedMeterType].toLowerCase(),
      };
      _focusNode.unfocus();
      model.getElectricityMerchant(data, callback: () {
        setState(() {
          cableMerchant = model.merchantModel!.res.content.customerName ?? '';
        });
      });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onTyping);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> services = [
    {
      'serviceId': 'ikeja-electric',
      'name': 'Ikeja Electric',
      'img': 'assets/images/ikeja.png',
    },
    {
      'serviceId': 'kano-electric',
      'name': 'Kano Electric',
      'img': 'assets/images/kano.png',
    },
    {
      'serviceId': 'eko-electric',
      'name': 'Eko Electric',
      'img': 'assets/images/eko.png',
    },
    {
      'serviceId': 'portharcourt-electric',
      'name': 'P.Harcourt Electric',
      'img': 'assets/images/pharcort.png',
    },
    {
      'serviceId': 'jos-electric',
      'name': 'Jos Electric',
      'img': 'assets/images/jos.png',
    },
    {
      'serviceId': 'ibadan-electric',
      'name': 'Ibadan Electric',
      'img': 'assets/images/ibadan.png',
    },
    {
      'serviceId': 'kaduna-electric',
      'name': 'Kaduna Electric',
      'img': 'assets/images/kaduna.png',
    },
    {
      'serviceId': 'abuja-electric',
      'name': 'Abuja Electric',
      'img': 'assets/images/abuja.png',
    },
    {
      'serviceId': 'enugu-electric',
      'name': 'Enugu Electric',
      'img': 'assets/images/enugu.png',
    },
    {
      'serviceId': 'benin-electric',
      'name': 'Benin Electric',
      'img': 'assets/images/benin.png',
    },
    {
      'serviceId': 'aba-electric',
      'name': 'Aba Electric',
      'img': 'assets/images/aba.png'
    },
    {
      'serviceId': 'yola-electric',
      'name': 'Yola Electric',
      'img': 'assets/images/yola.png',
    },
  ];

  List meterTypes = [
    'Prepaid',
    'Postpaid',
  ];
  int selectedMeterType = 0;
  final phone = TextEditingController();
  final amount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      body: Consumer2<AccountProvider, ServiceProvider>(
          builder: (context, model, service, _) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 14,
              left: 24,
              right: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () => Get.back(),
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
                        'Electricity',
                        style: MyStyle.tx18Black
                            .copyWith(color: themedata.tertiary),
                      ),
                    ),
                    const Spacer(), // Adds flexible space after the text
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BalanceActionCard(
                            title: 'Add Funds',
                            onTap: () {
                              Get.to(const AddFunds());
                            }),
                        const SizedBox(
                          height: 30,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Select Service Providers',
                            style: MyStyle.tx14Grey.copyWith(
                              color: themedata.tertiary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  showElectricityProviderSheet(
                                    onProviderSelected: (provider) {
                                      setState(() {
                                        selectedService = provider;
                                        cableMerchant = '';
                                      });
                                      log('selectedService: $selectedService');
                                    },
                                    providers: services,
                                    context: context,
                                    themeProvider: themeProvider,
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: themeProvider.isDarkMode()
                                        ? MyColor.dark01Color
                                        : MyColor.grey01Color,
                                  ),
                                  child: Row(

                                    children: [
                                      if (selectedService.isNotEmpty)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Image.asset(
                                            selectedService['img'] ?? '',
                                            width: 20,
                                            height: 20,
                                          ),
                                        ),
                                     
                                      Text(
                                        selectedService['name'] ??
                                            'Please select package',
                                        style: MyStyle.tx12Black.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: themedata.tertiary,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const Spacer(),
                                      const SizedBox(width: 10),
                                      Icon(
                                        Icons.keyboard_arrow_down_sharp,
                                        color: themedata.tertiary,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10
                            ),
                            PopupMenuButton(
                              itemBuilder: (context) => meterTypes.map((e) {
                                return PopupMenuItem(
                                  value: meterTypes.indexOf(e),
                                  child: Text(
                                    e,
                                    style: MyStyle.tx12Black.copyWith(
                                      color: MyColor.greenColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onSelected: (value) {
                                setState(() {
                                  selectedMeterType = value;
                                });
                                if (selectedService.isNotEmpty) {
                                  resolveMeterNumber();
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: MyColor.greenColor,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Text(meterTypes[selectedMeterType],
                                        style: MyStyle.tx12Black.copyWith(
                                          color: MyColor.greenColor,
                                          fontWeight: FontWeight.w600,
                                        )),
                                    Icon(
                                      Icons.keyboard_arrow_down_sharp,
                                      color: MyColor.greenColor,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment
                              .end, // Aligns vertically centered
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 9),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 1,
                                    color: themeProvider.isDarkMode()
                                        ? MyColor.borderDarkColor
                                        : MyColor.borderColor,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color:
                                          themedata.secondary.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Image.asset(
                                      'assets/images/star.png',
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  )
                                ],
                              ),
                            ),
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
                                child: UnderlineTextfield(
                                    controller: _controller,
                                    hintText: 'Enter Meter Number',
                                    suffixIcon: PopupMenuButton(
                                      color: themedata.secondary,
                                      constraints: const BoxConstraints(
                                        maxHeight: 150,
                                      ),
                                      itemBuilder: (context) => [
                                        ...model.electServiceModel!.details!
                                            .map((e) => PopupMenuItem(
                                                  value: e.id,
                                                  onTap: () {
                                                    _controller.text =
                                                        e.meterNumber ?? '';
                                                    phone.text = e.phone ?? '';
                                                    selectedMeterType =
                                                        e.meterType == 'Prepaid'
                                                            ? 0
                                                            : 1;
                                                    int index = services
                                                        .indexWhere((element) =>
                                                            element['serviceId']
                                                                .toString()
                                                                .toLowerCase() ==
                                                            e.discoName!
                                                                .toLowerCase());
                                                    setState(() {
                                                      selectedService =
                                                          services[index];
                                                    });
                                                    // log('selectedItem: $selectedItem');
                                                    // resolveCardNumber();
                                                  },
                                                  child: Text(
                                                    '${e.discoType} - ${e.meterNumber}',
                                                    style: MyStyle.tx12Black
                                                        .copyWith(
                                                      color: themedata.tertiary,
                                                    ),
                                                  ),
                                                )),
                                      ],
                                      child: Icon(
                                        Icons.bookmark_outline_rounded,
                                        color: MyColor.greenColor,
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        if (cableMerchant != '')
                          Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: MyColor.greenColor,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              cableMerchant,
                              style: MyStyle.tx12Black.copyWith(
                                fontWeight: FontWeight.w600,
                                color: MyColor.greenColor,
                              ),
                            ),
                          ),
                        const SizedBox(height: 10),
                        Text(
                          'Phone Number',
                          style: MyStyle.tx12Black.copyWith(
                            fontWeight: FontWeight.w400,
                            color: themedata.tertiary,
                          ),
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          text: 'Enter Phone Number',
                          controller: phone,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Amount',
                          style: MyStyle.tx12Black.copyWith(
                            fontWeight: FontWeight.w400,
                            color: themedata.tertiary,
                          ),
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          text: 'Enter Amount',
                          controller: amount,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              'Save details for next purchase',
                              style: MyStyle.tx12Black.copyWith(
                                color: themedata.tertiary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            Transform.scale(
                              scale: 0.8,
                              child: CupertinoSwitch(
                                value: saveDetails,
                                activeColor: MyColor.greenColor,
                                onChanged: (value) {
                                  setState(() {
                                    saveDetails = value;
                                  });
                                  print('saveDetails: $saveDetails');
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
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
                              if (amount.text.isEmpty ||
                                  phone.text.isEmpty ||
                                  cableMerchant.isEmpty) {
                                ErrorToast('Please fill all fields');
                              } else {
                                if (num.parse(amount.text) > model.balance!) {
                                  ErrorToast('Insufficient balance');
                                } else if (selectedMeterType == 0 &&
                                    num.parse(amount.text) < 2000) {
                                  ErrorToast('Minimum amount is 2000');
                                } else if (selectedMeterType == 1 &&
                                    num.parse(amount.text) < 5000) {
                                  ErrorToast('Minimum amount is 5000');
                                } else {
                                  Get.to(ElectricitySummaryScreen(
                                    saveDetails: saveDetails,
                                    data: {
                                      'service_id':
                                          selectedService['serviceId'],
                                      'name': selectedService['name'],
                                      'phone': phone.text,
                                      'amount': amount.text,
                                      'merchant': cableMerchant,
                                      'meter_number': _controller.text,
                                      'img': selectedService['img'],
                                      'meter_type':
                                          meterTypes[selectedMeterType],
                                    },
                                  ));
                                }
                              }
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
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
