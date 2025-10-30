import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quick_bills/Models/network_provider.dart';
import 'package:quick_bills/Provider/account_provider.dart';
import 'package:quick_bills/Ui/airtime/confirm_airtime_details.dart';
import 'package:quick_bills/Ui/Settings/edit_profile.dart';
import 'package:quick_bills/Values/MyColor.dart';
import 'package:quick_bills/Values/MyStyle.dart';
import 'package:quick_bills/common/amount_chip.dart';
import 'package:quick_bills/common/appbar.dart';
import 'package:quick_bills/common/button.dart';
import 'package:quick_bills/common/text_field.dart';
import 'package:quick_bills/utils/data.dart';
import 'package:quick_bills/utils/toast.dart';
import 'package:provider/provider.dart';

class PurchaseAirtime extends StatefulWidget {
  final String? phone;
  final String? network;
  final String? amount;
  const PurchaseAirtime({super.key, this.phone, this.network, this.amount});

  @override
  State<PurchaseAirtime> createState() => _PurchaseAirtimeState();
}

class _PurchaseAirtimeState extends State<PurchaseAirtime> {
  final _controller = TextEditingController();
  final _amount = TextEditingController();

  int selectedItem = -1;
  bool permissionDenied = false;
  bool saveDetails = true;

  Network? selectedNetwork;

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
      if (widget.phone != null && widget.amount != null) {
        _controller.text = widget.phone!;
        _amount.text = widget.amount!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: 'Purchase Airtime',
      ),
      body: Consumer<AccountProvider>(builder: (context, model, _) {
        return Padding(
          padding: const EdgeInsets.only(
            top: 14,
            left: 24,
            right: 24,
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select Mobile Operator',
                        style: MyStyle.tx14Black.copyWith(
                          fontWeight: FontWeight.w400,
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
                                                            child: Image.asset(
                                                              item['img'],
                                                            ),
                                                          ),
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
                                                  : MyColor.grey03Color),
                                        )
                                      ],
                                    ),
                                  );
                                })),
                      const SizedBox(
                        height: 30,
                      ),
                      requiredLabel('Phone number'),
                      CustomTextField(
                        text: 'Enter Mobile number',
                        controller: _controller,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 20),
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
                        controller: _amount,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildAmountChip(
                              amount: '100',
                              onTap: () {
                                _amount.text = '100';
                              }),
                          _buildAmountChip(
                              amount: '500',
                              onTap: () {
                                _amount.text = '500';
                              }),
                          _buildAmountChip(
                              amount: '1000',
                              onTap: () {
                                _amount.text = '1000';
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              CustomButton(
                  text: 'Confirm',
                  onTap: () {
                    if (_controller.text.isEmpty ||
                        _amount.text.isEmpty ||
                        num.parse(_amount.text) < 10) {
                      ErrorToast('Please fill all fields');
                    } else if (selectedItem == -1) {
                      ErrorToast('Please select network');
                    } else {
                      // if (num.parse(_amount.text) > model.balance!) {
                      //   ErrorToast('Insufficient balance');
                      // }
                      // else {
                      Get.to(
                        ConfirmAirtimeDetails(
                          selectedNetwork: selectedNetwork!,
                          number: _controller.text,
                          amount: _amount.text,
                          saveDetails: saveDetails,
                        ),
                      );
                      // }
                    }
                  }),
              const SizedBox(height: 40),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildAmountChip({
    required String amount,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          color: MyColor.lightGreen,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Text(
          '₦ $amount',
          style: MyStyle.tx14Black.copyWith(
            fontWeight: FontWeight.w400,
            color: MyColor.greenColor,
          ),
        ),
      ),
    );
  }
}
