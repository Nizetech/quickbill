import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quick_bills/Models/data_plans_model.dart';
import 'package:quick_bills/Models/network_provider.dart';
import 'package:quick_bills/Provider/account_provider.dart';
import 'package:quick_bills/Ui/Dashboard/Buy/confirm_data_purchase.dart';
import 'package:quick_bills/Ui/Dashboard/Buy/widget/package_sheet.dart';
import 'package:quick_bills/Ui/Dashboard/Settings/edit_profile.dart';
import 'package:quick_bills/Values/MyColor.dart';
import 'package:quick_bills/Values/MyStyle.dart';
import 'package:quick_bills/common/amount_chip.dart';
import 'package:quick_bills/common/appbar.dart';
import 'package:quick_bills/common/button.dart';
import 'package:quick_bills/common/text_field.dart';
import 'package:quick_bills/utils/data.dart';
import 'package:quick_bills/utils/toast.dart';
import 'package:provider/provider.dart';

class BuyData extends StatefulWidget {
  // final String? phone;
  // final String? network;
  const BuyData({
    super.key,
    //  this.phone, this.network
  });

  @override
  State<BuyData> createState() => _BuyDataState();
}

class _BuyDataState extends State<BuyData> {
  final _controller = TextEditingController();
  final package = TextEditingController();
  final amount = TextEditingController();
  bool saveDetails = true;
  int selectedDay = 0;

  int selectedItem = -1;
  String selectedBundle = '';
  Plan? selectedPlan;

  bool permissionDenied = false;

  @override
  void initState() {
    var model = Provider.of<AccountProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (model.networkProviderModel == null) {
        await model.getNetworkProviders(callback: () {
        });
      } 
    });
    super.initState();
  }

  // void loadInitData() {
  //   var model = Provider.of<AccountProvider>(context, listen: false);
  //   model.setDataPlanModelToNull();
  //   setState(() {
  // if (widget.network != null) {
  //   selectedItem = model.networkProviderModel!.networks!.indexWhere(
  //       (element) =>
  //           element.network!.toLowerCase() ==
  //           widget.network!.toLowerCase());
  //   selectedNetwork = model.networkProviderModel!.networks![selectedItem];
  // }
  // if (widget.network != null && widget.network != null) {
  //   model.getDataPlans(networkId: widget.network!.toLowerCase());
  // }
  //     if (widget.phone != null) {
  //       _controller.text = widget.phone!;
  //     }
  //   });
  // }

  Network? selectedNetwork;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AccountProvider>();
    return Scaffold(
      appBar: appBar(title: 'Purchase Data'),
      body: Consumer<AccountProvider>(builder: (context, ctrl, _) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 24, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                                                    }),
                                                    ctrl.getDataPlans(
                                                        networkId: model
                                                            .networkProviderModel!
                                                            .networks![index]
                                                            .networkId
                                                            .toString())
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
                                                                        'img'],
                                                              ),
                                                            ),
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
                                                            color: MyColor
                                                                .primaryColor
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
                                                color: MyColor.blackColor),
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
                        requiredLabel('Select Package'),
                        GestureDetector(
                          onTap: model.dataPlansModel == null
                              ? null
                              : () {
                                  showPackageSheet(
                                      onProviderSelected: (plan) {
                                        selectedPlan = plan;
                                        package.text =
                                            plan.name?.split('-').first ?? '';
                                        amount.text = plan.price.toString();
                                      },
                                      context: context);
                                },
                          child: CustomTextField(
                            text: 'Select Package',
                            controller: package,
                            keyboardType: TextInputType.number,
                            enabled: false,
                            suffixIcon: Icons.arrow_drop_down,
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
                            keyboardType: TextInputType.number,
                            enabled: false,
                          ),
                        
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                CustomButton(
                  text: 'Confirm',
                  onTap: () {
                    if (selectedPlan == null) {
                      ErrorToast('Please select a package');
                    } else {
                      Get.to(ConfirmDataPurchase(
                        saveDetails: saveDetails,
                        plan: selectedPlan!,
                        phone: _controller.text,
                        network: selectedNetwork!,
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
