import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
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
import 'package:jost_pay_wallet/common/text_field.dart';
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
  bool saveDetails = false;
  int selectedDay = 0;

  int selectedItem = -1;
  String selectedBundle = '';

  final FlutterNativeContactPicker _contactPicker =
      FlutterNativeContactPicker();
  bool permissionDenied = false;

  @override
  void initState() {
    var model = Provider.of<AccountProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      model.getDataServiceDetail();
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
                                  child: UnderlineTextfield(
                                    controller: _controller,
                                    hintText: 'Enter Mobile number',
                                    suffixIcon: PopupMenuButton(
                                      color: themedata.secondary,
                                      constraints: const BoxConstraints(
                                        maxHeight: 150,
                                      ),
                                      itemBuilder: (context) => [
                                        ...model.dataServiceModel!.details!
                                            .map((e) => PopupMenuItem(
                                                  value: e.id,
                                                  onTap: () {
                                                    _controller.text =
                                                        e.phone ?? '';
                                                  },
                                                  child: Text(
                                                    e.phone ?? '',
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
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          BuyDataConfirm(
                                                      saveDetails: saveDetails,
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
                                    ),
                                  ),
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
