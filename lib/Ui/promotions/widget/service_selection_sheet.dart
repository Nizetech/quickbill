import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Models/social_services.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';

void serviceSelectionSheet({
  required ThemeProvider themeProvider,
  required Function(Service) onSelect,
  required List<Service>? services,
}) {
  final themedata = Theme.of(Get.context!).colorScheme;
  showModalBottomSheet(
    isScrollControlled: true,
    context: Get.context!,
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.6,
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: themeProvider.isDarkMode()
              ? MyColor.dark02Color
              : MyColor.mainWhiteColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Text(
              'Select Service',
              style: MyStyle.tx16Black.copyWith(
                color: themedata.tertiary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: services!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      onSelect(services[index]);
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        services[index].serviceName!,
                        style: MyStyle.tx16Black.copyWith(
                          color: themedata.tertiary,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      );
    },
  );
}
