import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quick_bills/Models/cable_varaitaions.dart';
import 'package:quick_bills/Models/network_provider.dart';
import 'package:quick_bills/Provider/account_provider.dart';
import 'package:quick_bills/Provider/service_provider.dart';
import 'package:quick_bills/Ui/Settings/edit_profile.dart';
import 'package:quick_bills/Ui/cable/cable_summary.dart';
import 'package:quick_bills/Ui/cable/widget/cable_provider_sheet.dart';
import 'package:quick_bills/Values/MyColor.dart';
import 'package:quick_bills/Values/MyStyle.dart';
import 'package:quick_bills/Provider/theme_provider.dart';
import 'package:quick_bills/common/amount_chip.dart';
import 'package:quick_bills/common/appbar.dart';
import 'package:quick_bills/common/button.dart';
import 'package:quick_bills/common/text_field.dart';
import 'package:quick_bills/utils/toast.dart';
import 'package:provider/provider.dart';

class BuyCableBills extends StatefulWidget {
  final String? package;
  final String? network;
  final String? amount;
  const BuyCableBills({super.key, this.package, this.network, this.amount});

  @override
  State<BuyCableBills> createState() => _BuyCableBillsState();
}

class _BuyCableBillsState extends State<BuyCableBills> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  int selectedItem = -1;
  bool permissionDenied = false;
  String selectedServiceId = '';
  Network? selectedNetwork;
  Timer? _typingTimer;
  String cableMerchant = '';
  bool saveDetails = true;

  @override
  void initState() {
    super.initState();
    var model = Provider.of<AccountProvider>(context, listen: false);
   
    phone.text = model.userModel?.user?.phoneNumber?.replaceAll('+', '') ?? '';
    _controller.addListener(() {
      _onTyping();
    });
  }

  void _onTyping() {
    bool isShowmax = selectedItem == 3;
    if (isShowmax) {
      return;
    } else {
      if (_typingTimer != null && _typingTimer!.isActive ||
          _controller.text.isEmpty) {
        setState(() {
          cableMerchant = '';
        });
        _typingTimer?.cancel();
      }
      _typingTimer = Timer(Duration(seconds: 3), () {
        if (mounted) {
          resolveCardNumber();
        }
      });
    }
  }

  void resolveCardNumber() async {
    final model = Provider.of<ServiceProvider>(context, listen: false);
    if (_controller.text.isEmpty ||
        phone.text.isEmpty ||
        selectedItem == -1 ||
        _controller.text.length < 10 ||
        selectedItem == 3) {
      return;
    } else {
      Map<String, dynamic> data = {
        'card': _controller.text,
        'service_id': services[selectedItem]['serviceId'],
      };
      _focusNode.unfocus();
      model.getCableMerchant(data, callback: () {
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
      'img': 'assets/images/dstv.png',
      'serviceId': 'dstv',
      'name': 'DSTV',
    },
    {
      'img': 'assets/images/gotv.png',
      'serviceId': 'gotv',
      'name': 'GOTV',
    },
    {
      'img': 'assets/images/startime.png',
      'serviceId': 'startimes',
      'name': 'Startimes',
    },
    {
      'img': 'assets/images/showmax.png',
      'serviceId': 'showmax',
      'name': 'Showmax',
    },
  ];
  Plan? selectedPlan;
  final phone = TextEditingController();
  final amount = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: appBar(title: 'Purchase Cable Bills'),
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
                            color: themedata.tertiary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                            height: 100,
                            child: ListView.separated(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                separatorBuilder: (_, i) => SizedBox(
                                      width: 16.w,
                                    ),
                                itemCount: services.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  var item = services[index];
                                  return SizedBox(
                                    width: 86.w,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () => {
                                            setState(
                                              () {
                                                selectedItem = index;
                                                _controller.clear();
                                                amount.clear();
                                                selectedPlan = null;
                                                selectedServiceId =
                                                    item['serviceId'];
                                                selectedPlan = null;
                                                cableMerchant = '';
                                                if (selectedItem != 3) {
                                                  phone.text = model.userModel
                                                          ?.user?.phoneNumber
                                                          ?.replaceAll(
                                                              '+', '') ??
                                                      '';
                                                } else {
                                                  phone.clear();
                                                }
                                              },
                                            ),
                                            service.getCableVariations(
                                                selectedServiceId)
                                          },
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.asset(
                                                  item['img'],
                                                ),
                                              ),
                                              if (selectedItem == index)
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 2.r, right: 8.r),
                                                    child: Icon(
                                                      Icons.check_circle,
                                                      color:
                                                          MyColor.primaryColor,
                                                    ),
                                                  ),
                                                )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          item['name'],
                                          style: MyStyle.tx12Black.copyWith(
                                              fontFamily: 'SF Pro Rounded',
                                              fontWeight: FontWeight.w600,
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
                        requiredLabel('Smart Card Number'),
                        CustomTextField(
                          text: 'Enter IUC /Smart Card Number',
                          controller: _controller,
                        ),
                        const SizedBox(height: 10),
                        if (cableMerchant != '')
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            width: double.infinity,
                            alignment: Alignment.center,
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
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        requiredLabel('Choose a Package'),
                       
                        GestureDetector(
                          onTap: service.cableVariationsModel != null &&
                                  selectedItem != -1
                              ? () {
                                  showCableProviderSheet(
                                    onPlanSelected: (plan) {
                                      setState(() {
                                        selectedPlan = plan;
                                        amount.text =
                                            plan.variationAmount.toString();
                                      });
                                    },
                                    service: service,
                                    context: context,
                                    themeProvider: themeProvider,
                                  );
                                }
                              : () {},
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
                                Text(
                                  selectedPlan?.name ?? 'Please select package',
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
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            requiredLabel('Amount'),
                            AmountChip(),
                          ],
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          text: 'Enter Amount',
                          controller: amount,
                          enabled: false,
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
                CustomButton(
                  text: 'Confirm',
                  onTap: () {
                    if (amount.text.isEmpty ||
                        phone.text.isEmpty ||
                        selectedItem != 3 && cableMerchant.isEmpty) {
                      ErrorToast('Please fill all fields');
                    } else if (selectedItem == -1) {
                      ErrorToast('Please select network');
                    } else {
                      // if (num.parse(amount.text) > model.balance!) {
                      //   ErrorToast('Insufficient balance');
                      // } else {
                      Get.to(CableSummaryScreen(
                        saveDetails: saveDetails,
                        data: {
                          'id': selectedPlan!.variationCode,
                          'img': services[selectedItem]['img'],
                          'service_id': services[selectedItem]['serviceId'],
                          'name': selectedPlan!.name,
                          'phone': phone.text,
                          'amount': amount.text,
                          'showmax': selectedItem == 3,
                          'cableMerchant': cableMerchant,
                          'card': _controller.text,
                          'package': selectedPlan!.name,
                        },
                      ));
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
