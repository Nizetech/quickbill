
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Models/network_provider.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/AddFunds.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Buy/BuyAirtimeConfirmDetail.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Buy/widget/balance_action_card.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/NewColor.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/utils/data.dart';
import 'package:jost_pay_wallet/utils/toast.dart';
import 'package:provider/provider.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';

class BuyAirtimeConfirm extends StatefulWidget {
  final String? phone;
  final String? network;
  const BuyAirtimeConfirm({super.key, this.phone, this.network});

  @override
  State<BuyAirtimeConfirm> createState() => _BuyAirtimeConfirmState();
}

class _BuyAirtimeConfirmState extends State<BuyAirtimeConfirm> {
  final _controller = TextEditingController();
  final _amount = TextEditingController();

  final FlutterNativeContactPicker _contactPicker =
      FlutterNativeContactPicker();
  int selectedItem = -1;
  bool permissionDenied = false;

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
  void initState() {
    super.initState();
    var model = Provider.of<AccountProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (widget.network != null) {
          selectedItem = model.networkProviderModel!.networks!
              .indexWhere((element) => element.network == widget.network);
          selectedNetwork = model.networkProviderModel!.networks![selectedItem];
        }

        if (widget.phone != null) {
          _controller.text = widget.phone!;
        }

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      body: Consumer<AccountProvider>(builder: (context, model, _) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 14,
              left: 24,
              right: 24,
            ),
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
                        'Buy Airtime',
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
                            'Select Mobile Operator',
                            style: MyStyle.tx14Grey.copyWith(
                              color: themedata.tertiary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
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
                                                  })
                                                },
                                            child: Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: CachedNetworkImage(
                                                      imageUrl: model
                                                              .networkProviderModel!
                                                              .networks![index]
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
                                                            child: Image.asset(
                                                              item['img'],
                                                            ),
                                                          )),
                                                ),
                                                if (selectedItem == index)
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 2.r, right: 8.r),
                                                      child: Icon(
                                                        Icons.check_circle,
                                                        color: Theme.of(context)
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
                          height: 30,
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
                                  ),
                                ),
                              ),
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
                                    child: const Icon(
                                        Icons.phone_android_rounded,
                                        size: 20,
                                        color: MyColor.greenColor),
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
                                  keyboardType: TextInputType.number,
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
                            const SizedBox(width: 16),
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
                        const SizedBox(height: 24),
                        // Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: Text(
                        //     'Best Rate',
                        //     style: MyStyle.tx14Black
                        //         .copyWith(color: themedata.tertiary),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 8,
                        // ),
                        // Container(
                        //   decoration: BoxDecoration(
                        //       border: Border.all(
                        //           color: themeProvider.isDarkMode()
                        //               ? MyColor.borderDarkColor
                        //               : MyColor.borderColor,
                        //           width: 0.5),
                        //       borderRadius: BorderRadius.circular(5)),
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(20),
                        //     child: Column(
                        //       children: [
                        //         Row(
                        //           children: [
                        //             GestureDetector(
                        //                 onTap: () => Navigator.pushReplacement(
                        //                     context,
                        //                     MaterialPageRoute(
                        //                         builder: (context) =>
                        //                             const Buyairtimeconfirmdetail())),
                        //                 child: Container(
                        //                   width: 100,
                        //                   height: 62,
                        //                   alignment: Alignment.center,
                        //                   decoration: BoxDecoration(
                        //                       color: themedata.secondary,
                        //                       borderRadius:
                        //                           BorderRadius.circular(8)),
                        //                   child: Column(
                        //                     children: [
                        //                       const Spacer(),
                        //                       const Text(
                        //                         'N500',
                        //                         style: MyStyle.tx14Green,
                        //                       ),
                        //                       const SizedBox(
                        //                         height: 4,
                        //                       ),
                        //                       Container(
                        //                         width: 72,
                        //                         alignment: Alignment.center,
                        //                         decoration: BoxDecoration(
                        //                             color: themedata.secondary,
                        //                             borderRadius:
                        //                                 BorderRadius.circular(6)),
                        //                         child: Text(
                        //                           'Pay N500',
                        //                           style: MyStyle.tx12Black
                        //                               .copyWith(
                        //                                   color:
                        //                                       MyColor.greenColor),
                        //                         ),
                        //                       ),
                        //                       const Spacer(),
                        //                     ],
                        //                   ),
                        //                 )),
                        //             const Spacer(),
                        //             GestureDetector(
                        //                 onTap: () => Navigator.pushReplacement(
                        //                     context,
                        //                     MaterialPageRoute(
                        //                         builder: (context) =>
                        //                             const Buyairtimeconfirmdetail())),
                        //                 child: Container(
                        //                   width: 100,
                        //                   height: 62,
                        //                   alignment: Alignment.center,
                        //                   decoration: BoxDecoration(
                        //                       color: themedata.secondary,
                        //                       borderRadius:
                        //                           BorderRadius.circular(8)),
                        //                   child: Column(
                        //                     children: [
                        //                       const Spacer(),
                        //                       const Text(
                        //                         'N500',
                        //                         style: MyStyle.tx14Green,
                        //                       ),
                        //                       const SizedBox(
                        //                         height: 4,
                        //                       ),
                        //                       Container(
                        //                         width: 72,
                        //                         alignment: Alignment.center,
                        //                         decoration: BoxDecoration(
                        //                             color: themedata.secondary,
                        //                             borderRadius:
                        //                                 BorderRadius.circular(6)),
                        //                         child: Text(
                        //                           'Pay N500',
                        //                           style: MyStyle.tx12Black
                        //                               .copyWith(
                        //                                   color:
                        //                                       MyColor.greenColor),
                        //                         ),
                        //                       ),
                        //                       const Spacer(),
                        //                     ],
                        //                   ),
                        //                 )),
                        //             const Spacer(),
                        //             GestureDetector(
                        //                 onTap: () => Navigator.pushReplacement(
                        //                     context,
                        //                     MaterialPageRoute(
                        //                         builder: (context) =>
                        //                             const Buyairtimeconfirmdetail())),
                        //                 child: Container(
                        //                   width: 100,
                        //                   height: 62,
                        //                   alignment: Alignment.center,
                        //                   decoration: BoxDecoration(
                        //                       color: themedata.secondary,
                        //                       borderRadius:
                        //                           BorderRadius.circular(8)),
                        //                   child: Column(
                        //                     children: [
                        //                       const Spacer(),
                        //                       const Text(
                        //                         'N500',
                        //                         style: MyStyle.tx14Green,
                        //                       ),
                        //                       const SizedBox(
                        //                         height: 4,
                        //                       ),
                        //                       Container(
                        //                         width: 72,
                        //                         alignment: Alignment.center,
                        //                         decoration: BoxDecoration(
                        //                             color: themedata.secondary,
                        //                             borderRadius:
                        //                                 BorderRadius.circular(6)),
                        //                         child: Text(
                        //                           'Pay N500',
                        //                           style: MyStyle.tx12Black
                        //                               .copyWith(
                        //                                   color:
                        //                                       MyColor.greenColor),
                        //                         ),
                        //                       ),
                        //                       const Spacer(),
                        //                     ],
                        //                   ),
                        //                 )),
                        //           ],
                        //         ),
                        //         const SizedBox(
                        //           height: 12,
                        //         ),
                        //         Row(
                        //           children: [
                        //             GestureDetector(
                        //                 onTap: () => Navigator.pushReplacement(
                        //                     context,
                        //                     MaterialPageRoute(
                        //                         builder: (context) =>
                        //                             const Buyairtimeconfirmdetail())),
                        //                 child: Container(
                        //                   width: 100,
                        //                   height: 62,
                        //                   alignment: Alignment.center,
                        //                   decoration: BoxDecoration(
                        //                       color: themedata.secondary,
                        //                       borderRadius:
                        //                           BorderRadius.circular(8)),
                        //                   child: Column(
                        //                     children: [
                        //                       const Spacer(),
                        //                       const Text(
                        //                         'N500',
                        //                         style: MyStyle.tx14Green,
                        //                       ),
                        //                       const SizedBox(
                        //                         height: 4,
                        //                       ),
                        //                       Container(
                        //                         width: 72,
                        //                         alignment: Alignment.center,
                        //                         decoration: BoxDecoration(
                        //                             color: themedata.secondary,
                        //                             borderRadius:
                        //                                 BorderRadius.circular(6)),
                        //                         child: Text(
                        //                           'Pay N500',
                        //                           style: MyStyle.tx12Black
                        //                               .copyWith(
                        //                                   color:
                        //                                       MyColor.greenColor),
                        //                         ),
                        //                       ),
                        //                       const Spacer(),
                        //                     ],
                        //                   ),
                        //                 )),
                        //             const Spacer(),
                        //             GestureDetector(
                        //                 onTap: () => Navigator.pushReplacement(
                        //                     context,
                        //                     MaterialPageRoute(
                        //                         builder: (context) =>
                        //                             const Buyairtimeconfirmdetail())),
                        //                 child: Container(
                        //                   width: 100,
                        //                   height: 62,
                        //                   alignment: Alignment.center,
                        //                   decoration: BoxDecoration(
                        //                       color: themedata.secondary,
                        //                       borderRadius:
                        //                           BorderRadius.circular(8)),
                        //                   child: Column(
                        //                     children: [
                        //                       const Spacer(),
                        //                       const Text(
                        //                         'N500',
                        //                         style: MyStyle.tx14Green,
                        //                       ),
                        //                       const SizedBox(
                        //                         height: 4,
                        //                       ),
                        //                       Container(
                        //                         width: 72,
                        //                         alignment: Alignment.center,
                        //                         decoration: BoxDecoration(
                        //                             color: themedata.secondary,
                        //                             borderRadius:
                        //                                 BorderRadius.circular(6)),
                        //                         child: Text(
                        //                           'Pay N500',
                        //                           style: MyStyle.tx12Black
                        //                               .copyWith(
                        //                                   color:
                        //                                       MyColor.greenColor),
                        //                         ),
                        //                       ),
                        //                       const Spacer(),
                        //                     ],
                        //                   ),
                        //                 )),
                        //             const Spacer(),
                        //             GestureDetector(
                        //                 onTap: () => Navigator.pushReplacement(
                        //                     context,
                        //                     MaterialPageRoute(
                        //                         builder: (context) =>
                        //                             const Buyairtimeconfirmdetail())),
                        //                 child: Container(
                        //                   width: 100,
                        //                   height: 62,
                        //                   alignment: Alignment.center,
                        //                   decoration: BoxDecoration(
                        //                       color: themedata.secondary,
                        //                       borderRadius:
                        //                           BorderRadius.circular(8)),
                        //                   child: Column(
                        //                     children: [
                        //                       const Spacer(),
                        //                       const Text(
                        //                         'N500',
                        //                         style: MyStyle.tx14Green,
                        //                       ),
                        //                       const SizedBox(
                        //                         height: 4,
                        //                       ),
                        //                       Container(
                        //                         width: 72,
                        //                         alignment: Alignment.center,
                        //                         decoration: BoxDecoration(
                        //                             color: themedata.secondary,
                        //                             borderRadius:
                        //                                 BorderRadius.circular(6)),
                        //                         child: Text(
                        //                           'Pay N500',
                        //                           style: MyStyle.tx12Black
                        //                               .copyWith(
                        //                                   color:
                        //                                       MyColor.greenColor),
                        //                         ),
                        //                       ),
                        //                       const Spacer(),
                        //                     ],
                        //                   ),
                        //                 )),
                        //           ],
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 18,
                        // ),
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
                                controller: _amount,
                                keyboardType: TextInputType.number,
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
                              if (_controller.text.isEmpty ||

                                  _amount.text.isEmpty) {
                                ErrorToast('Please fill all fields');
                              } else if (selectedItem == -1) {
                                ErrorToast('Please select network');
                              } else {
                                if (num.parse(_amount.text) > model.balance!) {
                                  ErrorToast('Insufficient balance');
                                } else {
                                Get.to(Buyairtimeconfirmdetail(
                                  selectedNetwork: selectedNetwork!,
                                  number: _controller.text,
                                  amount: _amount.text,
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
