import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Home/widget/states.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';

void showStateSheet({
  required Function(String) onStateSelected,
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
            'Select State',
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
              itemCount: states.length,
              separatorBuilder: (context, index) => Divider(
                color: themeProvider.isDarkMode()
                    ? MyColor.borderDarkColor
                    : MyColor.borderColor,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      onStateSelected(states[index]);
                      Get.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      child: Text(
                        states[index],
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
