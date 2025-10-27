import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_bills/Models/data_plans_model.dart';
import 'package:quick_bills/Provider/account_provider.dart';
import 'package:quick_bills/Values/Helper/helper.dart';
import 'package:quick_bills/Values/MyColor.dart';
import 'package:quick_bills/Values/MyStyle.dart';
import 'package:provider/provider.dart';

void showPackageSheet({
  required Function(Plan plan) onProviderSelected,
  required BuildContext context,
}) {
  final model = Get.context!.read<AccountProvider>();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(30),
      ),
    ),
    builder: (context) => Container(
      height: 550,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: MyColor.mainWhiteColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Select Package',
            style: MyStyle.tx18Black.copyWith(
              fontWeight: FontWeight.w600,
              color: MyColor.dark01Color,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              itemCount: model.dataPlansModel!.plans!.length,
              separatorBuilder: (context, index) =>
                  Divider(color: MyColor.borderColor),
              itemBuilder: (context, index) {
                var plan = model.dataPlansModel!.plans![index];
                return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      onProviderSelected(plan);
                      Get.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              plan.name ?? '',
                              style: MyStyle.tx12Black.copyWith(
                                fontWeight: FontWeight.w400,
                                color: MyColor.dark01Color,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "₦${formatNumberWithOutDecimal(plan.price!.toString())}",
                            style: MyStyle.tx12Black.copyWith(
                              fontWeight: FontWeight.w400,
                              color: MyColor.dark01Color,
                            ),
                          ),
                        ],
                      ),
                    ));
              },
            ),
          ),
        ],
      ),
    ),
  );
}
