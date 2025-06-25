import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';

void selectRepaireOption({
  required ThemeProvider themeProvider,
  required Function(String) onSelect,
}) {
  final themedata = Theme.of(Get.context!).colorScheme;
  List<Map<String, dynamic>> repairTypes = [
    {
      "title": "Vehicle Repair",
      "subtitle": "Transmission, Body, Wheels, Electrical, Frame, Engine",
    },
    {
      "title": "General Serving",
    },
    {
      "title": "Pick Up from Port",
      "subtitle": "Savage Repairs, Complete Repairs",
    },
  ];
  showModalBottomSheet(
    context: Get.context!,
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, setState) {
        return Container(
          height: 300,
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
                'Choose Repair Option',
                style: MyStyle.tx16Black.copyWith(
                  color: themedata.tertiary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: repairTypes.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        repairTypes[index]['title'],
                        style: MyStyle.tx16Black.copyWith(
                          color: themedata.tertiary,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: repairTypes[index]['subtitle'] == null
                          ? null
                          : Text(
                              repairTypes[index]['subtitle'],
                              style: MyStyle.tx16Black.copyWith(
                                color: themedata.tertiary,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                      onTap: () {
                        onSelect(repairTypes[index]['title']);
                        Get.back();
                      },
                    );
                  },
                ),
              )
            ],
          ),
        );
      });
    },
  );
}

void statusSheet({
  required ThemeProvider themeProvider,
  required Function(String) onSelect,
}) {
  final themedata = Theme.of(Get.context!).colorScheme;
  List statusType = ['Run & drive', 'Non-runner'];
  showModalBottomSheet(
    context: Get.context!,
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, setState) {
        return Container(
          height: 300,
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
                'Choose Vehicle Status',
                style: MyStyle.tx16Black.copyWith(
                  color: themedata.tertiary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: statusType.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        statusType[index],
                        style: MyStyle.tx16Black.copyWith(
                          color: themedata.tertiary,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      onTap: () {
                        onSelect(statusType[index]);
                        Get.back();
                      },
                    );
                  },
                ),
              )
            ],
          ),
        );
      });
    },
  );
}
