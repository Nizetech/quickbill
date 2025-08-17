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
import 'package:jost_pay_wallet/common/text_field.dart';
import 'package:jost_pay_wallet/utils/data.dart';
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
      if (model.networkProviderModel == null) {
        model.getNetworkProviders(callback: () {
          loadInitData();
        });
      } else {
        loadInitData();
      }
    });
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
      if (widget.package != null && widget.amount != null) {
        _controller.text = widget.package!;
        _amount.text = widget.amount!;
      }
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
                                                    })
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
                                      hintText:
                                          'Enter IUC /Smart Card Number')),
                            ),
                            const SizedBox(width: 16),
                            // "Choose Contact" text
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: MyColor.greenColor,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    'Yanga',
                                    style: MyStyle.tx12Black.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: MyColor.greenColor,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    color: MyColor.greenColor,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Select Package',
                          style: MyStyle.tx12Black.copyWith(
                            fontWeight: FontWeight.w400,
                            color: themedata.tertiary,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: MyColor.grey01Color,
                          ),
                          child: Row(
                            children: [
                              Text(
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
                                  _amount.text.isEmpty ||
                                  num.parse(_amount.text) < 10) {
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
