import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_bills/Models/cable_varaitaions.dart';
import 'package:quick_bills/Provider/service_provider.dart';
import 'package:quick_bills/Provider/theme_provider.dart';
import 'package:quick_bills/Values/MyColor.dart';
import 'package:quick_bills/Values/MyStyle.dart';

void showCableProviderSheet({
  required Function(Plan) onPlanSelected,
  required ServiceProvider service,
  required BuildContext context,
  required ThemeProvider themeProvider,
}) {
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
        color: themeProvider.isDarkMode()
            ? MyColor.dark01Color
            : MyColor.mainWhiteColor,
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
              color: themeProvider.isDarkMode()
                  ? MyColor.mainWhiteColor
                  : MyColor.dark01Color,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              itemCount: service.cableVariationsModel!.plans.length,
              separatorBuilder: (context, index) => Divider(
                color: themeProvider.isDarkMode()
                    ? MyColor.borderDarkColor
                    : MyColor.borderColor,
              ),
              itemBuilder: (context, index) {
                Plan plan = service.cableVariationsModel!.plans[index];
                return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      onPlanSelected(plan);
                      Get.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      child: Text(
                        plan.name,
                        style: MyStyle.tx12Black.copyWith(
                          fontWeight: FontWeight.w400,
                          color: themeProvider.isDarkMode()
                              ? MyColor.mainWhiteColor
                              : MyColor.dark01Color,
                        ),
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
