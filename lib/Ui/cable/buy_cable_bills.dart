import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Models/cable_varaitaions.dart';
import 'package:jost_pay_wallet/Models/network_provider.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/service_provider.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/AddFunds.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Buy/widget/balance_action_card.dart';
import 'package:jost_pay_wallet/Ui/cable/cable_summary.dart';
import 'package:jost_pay_wallet/Ui/cable/widget/cable_provider_sheet.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/NewColor.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/common/text_field.dart';
import 'package:jost_pay_wallet/utils/toast.dart';
import 'package:provider/provider.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';

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
  bool saveDetails = false;

  @override
  void initState() {
    super.initState();
    var model = Provider.of<AccountProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      model.getCableServiceDetail();
    });
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
        resolveCardNumber();
      });
    }
  }

  void resolveCardNumber() async {
    final model = Provider.of<ServiceProvider>(context, listen: false);
    if (_controller.text.isEmpty ||
        phone.text.isEmpty ||
        selectedItem == -1 ||
        _controller.text.length < 10) {
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
                        'Buy Cable Bills',
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
                                                      color: MyColor.greenColor,
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
                          height: 10,
                        ),
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
                                    hintText: 'Enter IUC /Smart Card Number',
                                    suffixIcon: PopupMenuButton(
                                      color: themedata.secondary,
                                      constraints: const BoxConstraints(
                                        maxHeight: 150,
                                      ),
                                      itemBuilder: (context) => [
                                        ...model.cableServiceModel!.details!
                                            .map((e) => PopupMenuItem(
                                                  value: e.id,
                                                  onTap: () {
                                                    _controller.text =
                                                        e.smartCard ?? '';
                                                    phone.text = e.phone ?? '';
                                                    int index = services
                                                        .indexWhere((element) =>
                                                            element['name']
                                                                .toString()
                                                                .toLowerCase() ==
                                                            e.networkName!
                                                                .toLowerCase());
                                                    setState(() {
                                                      selectedItem = index;
                                                    });
                                                    log('selectedItem: $selectedItem');
                                                    resolveCardNumber();
                                                  },
                                                  child: Text(
                                                    '${e.networkName} - ${e.smartCard}',
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
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Select Package',
                          style: MyStyle.tx12Black.copyWith(
                            fontWeight: FontWeight.w400,
                            color: themedata.tertiary,
                          ),
                        ),
                        const SizedBox(height: 10),
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
                        const SizedBox(height: 10),
                        if (selectedPlan != null)
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
                          enabled: false,
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
                                  selectedItem != 3 && cableMerchant.isEmpty) {
                                ErrorToast('Please fill all fields');
                              } else if (selectedItem == -1) {
                                ErrorToast('Please select network');
                              } else {
                                if (num.parse(amount.text) > model.balance!) {
                                  ErrorToast('Insufficient balance');
                                } else {
                                  Get.to(CableSummaryScreen(
                                    saveDetails: saveDetails,
                                    data: {
                                      'id': selectedPlan!.variationCode,
                                      'img': services[selectedItem]['img'],
                                      'service_id': services[selectedItem]
                                          ['serviceId'],
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
