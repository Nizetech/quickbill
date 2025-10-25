import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/service_provider.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Settings/edit_profile.dart';
import 'package:jost_pay_wallet/Ui/electricity/electricity_summary.dart';
import 'package:jost_pay_wallet/Ui/electricity/widget/provider_sheet.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/common/amount_chip.dart';
import 'package:jost_pay_wallet/common/appbar.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:jost_pay_wallet/common/text_field.dart';
import 'package:jost_pay_wallet/utils/toast.dart';
import 'package:provider/provider.dart';

class BuyElectricity extends StatefulWidget {

  const BuyElectricity({super.key});

  @override
  State<BuyElectricity> createState() => _BuyElectricityState();
}

class _BuyElectricityState extends State<BuyElectricity> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  Map<String, dynamic> selectedService = {};
  Timer? _typingTimer;
  String cableMerchant = '';
  bool saveDetails = true;

  @override
  void initState() {
    super.initState();
    final account = Provider.of<AccountProvider>(context, listen: false);
   
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
    return Scaffold(
      appBar: appBar(title: 'Purchase Electricity'),
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
              
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      
                        Text(
                          'Select Service Providers',
                          style: MyStyle.tx14Grey.copyWith(
                            color: MyColor.blackColor,
                            fontWeight: FontWeight.w400,
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
                                      _controller.clear();
                                      log('selectedService: $selectedService');
                                    },
                                    providers: services,
                                    context: context,
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: MyColor.grey01Color.withOpacity(0.4),
                                    border: Border.all(
                                      color: MyColor.borderColor,
                                      width: 1,
                                    ),
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
                                          color: MyColor.blackColor,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const Spacer(),
                                      const SizedBox(width: 10),
                                      Icon(
                                        Icons.keyboard_arrow_down_sharp,
                                        color: MyColor.blackColor,
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
                                      color: MyColor.primaryColor,
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
                                    color: MyColor.primaryColor,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Text(meterTypes[selectedMeterType],
                                        style: MyStyle.tx12Black.copyWith(
                                          color: MyColor.primaryColor,
                                          fontWeight: FontWeight.w600,
                                        )),
                                    Icon(
                                      Icons.keyboard_arrow_down_sharp,
                                      color: MyColor.primaryColor,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        requiredLabel('Meter Number'),
                        CustomTextField(
                          text: 'Enter Meter Number',
                          controller: _controller,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 10),
               
                        if (cableMerchant != '')
                          Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: MyColor.primaryColor,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              cableMerchant,
                              style: MyStyle.tx12Black.copyWith(
                                fontWeight: FontWeight.w600,
                                color: MyColor.primaryColor,
                              ),
                            ),
                          ),
                    
                        requiredLabel('Phone Number'),
                   
                        CustomTextField(
                          text: 'Enter Phone Number',
                          controller: phone,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            requiredLabel('Amount'),
                            AmountChip(),
                          ],
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          text: 'Enter an Amount',
                          controller: amount,
                          keyboardType: TextInputType.number,
                        ),
                      
                      ],
                    ),
                  ),
                ),
                CustomButton(
                  text: 'Confirm',
                  onTap: () {
                    if (amount.text.isEmpty || phone.text.isEmpty) {
                      ErrorToast('Please fill all fields');
                    } else {
                      // if (num.parse(amount.text) > model.balance!) {
                      //   ErrorToast('Insufficient balance');
                      // } else
                      if (selectedMeterType == 0 &&
                          num.parse(amount.text) < 2000) {
                        ErrorToast('Minimum amount is 2000');
                      } else if (selectedMeterType == 1 &&
                          num.parse(amount.text) < 5000) {
                        ErrorToast('Minimum amount is 5000');
                      } else {
                        Get.to(ElectricitySummaryScreen(
                          saveDetails: saveDetails,
                          data: {
                            'service_id': selectedService['serviceId'],
                            'name': selectedService['name'],
                            'phone': phone.text,
                            'amount': amount.text,
                            'merchant': cableMerchant,
                            'meter_number': _controller.text,
                            'img': selectedService['img'],
                            'meter_type': meterTypes[selectedMeterType],
                          },
                        ));
                      }
                    }
                  },
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      }),
    );
  }
}
