import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Models/network_provider.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Buy/BuyDataConfirm.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Buy/widget/balance_action_card.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/utils.dart';
import 'package:jost_pay_wallet/utils/data.dart';
import 'package:jost_pay_wallet/utils/toast.dart';
import 'package:provider/provider.dart';

import '../AddFunds.dart';

class BuyData extends StatefulWidget {
  final String? phone;
  final String? network;
  const BuyData({super.key, this.phone, this.network});

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

  int selectedItem = -1;
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
                                onTap: () {},
                                // =>
                                //  Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             const BuyDataConfirm())),
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

  final FlutterNativeContactPicker _contactPicker =
      FlutterNativeContactPicker();
  bool permissionDenied = false;

  @override
  void initState() {
    var model = Provider.of<AccountProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (model.networkProviderModel == null) {
        await model.getNetworkProviders(callback: () {
          loadInitData();
        });
      } else {
        loadInitData();
      }
    });
    super.initState();
  }

  void loadInitData() {
    var model = Provider.of<AccountProvider>(context, listen: false);
    model.setDataPlanModelToNull();
    setState(() {
      if (widget.network != null) {
        selectedItem = model.networkProviderModel!.networks!.indexWhere(
            (element) =>
                element.network!.toLowerCase() ==
                widget.network!.toLowerCase());
        selectedNetwork = model.networkProviderModel!.networks![selectedItem];
      }
      if (widget.network != null && widget.network != null) {
        model.getDataPlans(network: widget.network!.toLowerCase());
      }
      if (widget.phone != null) {
        _controller.text = widget.phone!;
      }
    });
  }

  Network? selectedNetwork;
  Future _pickContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() => permissionDenied = true);
    } else {
      final contact = await _contactPicker.selectContact();
      setState(() {
        var phoneNumber = contact!.phoneNumbers!.first.replaceAll(' ', '');
        _controller.text = phoneNumber.replaceAll('+234', '0');
      });
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   final model = Provider.of<AccountProvider>(context, listen: false);
  //   WidgetsBinding.instance.addPostFrameCallback((_) async {
  //     model.setDataPlanModelToNull();
  //     if (model.networkProviderModel == null) {
  //       await model.getNetworkProviders();
  //       model.getDataPlans(
  //           network: model.networkProviderModel!.networks!.first.network!
  //               .toLowerCase());
  //     } else {
  //       await model.getNetworkProviders(isLoading: false);
  //     }
  //     // setState(() {
  //     //   selectedNetwork = model.networkProviderModel!.networks![selectedItem];
  //     // });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    final model = context.watch<AccountProvider>();
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Consumer<AccountProvider>(builder: (context, ctrl, _) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 24, right: 24),
            child: Column(
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
                        'Buy Data',
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
                BalanceActionCard(
                    title: 'Add Funds',
                    onTap: () {
                      Get.to(const AddFunds());
                    }),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Select Mobile Operator',
                            style: MyStyle.tx14Grey.copyWith(
                              color: themedata.tertiary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        if (model.networkProviderModel != null)
                          SizedBox(
                              height: 90,
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  separatorBuilder: (_, i) => SizedBox(
                                        width: 16.w,
                                      ),
                                  itemCount: model
                                      .networkProviderModel!.networks!.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    var item = data[index];
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
                                                    setState(() {
                                                      selectedItem = index;
                                                      selectedNetwork = model
                                                          .networkProviderModel!
                                                          .networks![index];
                                                      _controller.text = "";
                                                    }),
                                                    ctrl.getDataPlans(
                                                        network: model
                                                            .networkProviderModel!
                                                            .networks![index]
                                                            .network!
                                                            .toLowerCase())
                                                  },
                                              child: Stack(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: CachedNetworkImage(
                                                        imageUrl: model
                                                                .networkProviderModel!
                                                                .networks![
                                                                    index]
                                                                .logo ??
                                                            "",
                                                        height: 68,
                                                        width: 86,
                                                        fit: BoxFit.cover,
                                                        placeholder: (context,
                                                                url) =>
                                                            ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child: Image
                                                                    .asset(item[
                                                                        'img'])),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              child:
                                                                  Image.asset(
                                                                item['img'],
                                                              ),
                                                            )),
                                                  ),
                                                  if (selectedItem == index)
                                                    Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 2.r,
                                                                right: 8.r),
                                                        child: Icon(
                                                          Icons.check_circle,
                                                          color: Theme.of(
                                                                  context)
                                                              .scaffoldBackgroundColor,
                                                        ),
                                                      ),
                                                    )
                                                ],
                                              )),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            model.networkProviderModel!
                                                    .networks![index].network ??
                                                "",
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
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment
                              .end, // Aligns vertically centered
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
                                    padding: EdgeInsets.all(6.h),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: themedata.secondary,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(Icons.phone_android_rounded,
                                        size: 20, color: MyColor.greenColor),
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
                                  keyboardType: TextInputType.number,
                                  controller: _controller,
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
                            GestureDetector(
                              onTap: () async {
                                await _pickContacts();
                              },
                              child: const Text(
                                'Choose Contact',
                                style: MyStyle.tx12GreenUnder,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 48),
                        // Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: Row(
                        //     children: [
                        //       for (int i = 0; i < dayItems.length; i++) ...[
                        //         GestureDetector(
                        //           onTap: () => {
                        //             setState(() {
                        //               selectedDay = i;
                        //             })
                        //           },
                        //           child: Text(
                        //             dayItems[i],
                        //             style: MyStyle.tx12Grey.copyWith(
                        //                 color: i == selectedDay
                        //                     ? MyColor.greenColor
                        //                     : MyColor.greyColor,
                        //                 fontWeight: FontWeight.w500),
                        //           ),
                        //         ),
                        //         if (i != dayItems.length - 1) const Spacer(),
                        //       ]
                        //     ],
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 8,
                        // ),
                        if (model.dataPlansModel != null)
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: themeProvider.isDarkMode()
                                        ? MyColor.borderDarkColor
                                        : MyColor.borderColor,
                                    width: 0.2),
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              child: Column(
                                children: [
                                  Wrap(
                                      spacing: 10,
                                      runSpacing: 10,
                                      children: List.generate(
                                        model.dataPlansModel!.plans!.length,
                                        (index) {
                                          var plan = model
                                              .dataPlansModel!.plans![index];
                                          String price =
                                              formatNumber(plan.price!);
                                          return GestureDetector(
                                            onTap: () {
                                              if (_controller.text.isEmpty) {
                                                ErrorToast(
                                                    'Please enter mobile number');
                                              } else if (selectedItem == -1) {
                                                ErrorToast(
                                                    'Please select network');
                                              } else {
                                                if (num.parse(
                                                        plan.price.toString()) >
                                                    model.balance!) {
                                                  ErrorToast(
                                                      'Insufficient balance');
                                                } else {
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          BuyDataConfirm(
                                                        plan: plan,
                                                        phone: _controller.text,
                                                        network:
                                                            selectedNetwork!,
                                                      ),
                                                    ),
                                                  );
                                                }
                                              }
                                            },
                                            child: Container(
                                              width: 140,
                                              padding: EdgeInsets.all(10),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: themedata.secondary
                                                      .withValues(alpha: 0.3),
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    plan.name!,
                                                    textAlign: TextAlign.center,
                                                    style: MyStyle.tx12Black
                                                        .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: themedata.tertiary,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  // Text(
                                                  //   '${Utils.naira}$price',
                                                  //   style: MyStyle.tx12Grey,
                                                  // ),
                                                  // const SizedBox(
                                                  //   height: 4,
                                                  // ),
                                                  Container(
                                                    padding: EdgeInsets.all(10),
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            themedata.secondary,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6)),
                                                    child: Text(
                                                      '${Utils.naira}$price',
                                                      style: MyStyle.tx12Black
                                                          .copyWith(
                                                              color: MyColor
                                                                  .greenColor),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ))

                                  // InkWell(
                                  //   onTap: () => _showBottomSheet(context,
                                  //       isDarkMode:
                                  //           themeProvider.isDarkMode()),
                                  //   child: Container(
                                  //     padding: EdgeInsets.all(10),
                                  //     // width: 100,
                                  //     height: 78,
                                  //     alignment: Alignment.center,
                                  //     decoration: BoxDecoration(
                                  //         color: MyColor.greenColor,
                                  //         borderRadius:
                                  //             BorderRadius.circular(8)),
                                  //     child: Column(
                                  //       children: [

                                  //         const Text(
                                  //           '50% off',
                                  //           style: MyStyle.tx16White,
                                  //         ),
                                  //         const SizedBox(
                                  //           height: 10,
                                  //         ),
                                  //         Row(
                                  //           crossAxisAlignment:
                                  //               CrossAxisAlignment.center,
                                  //           mainAxisAlignment:
                                  //               MainAxisAlignment.center,
                                  //           children: [
                                  //             Text(
                                  //               'See other plans',
                                  //               style: MyStyle.tx12GreenUnder
                                  //                   .copyWith(
                                  //                       color: Colors.white,
                                  //                       fontSize: 9,
                                  //                       decoration:
                                  //                           TextDecoration
                                  //                               .underline,
                                  //                       decorationColor:
                                  //                           Colors.white),
                                  //             ),
                                  //             const SizedBox(
                                  //               width: 2,
                                  //             ),
                                  //             Image.asset(
                                  //                 'assets/images/arrow-tr.png')
                                  //           ],
                                  //         ),
                                  //         const Spacer(),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
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
