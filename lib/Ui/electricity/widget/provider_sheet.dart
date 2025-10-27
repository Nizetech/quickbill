import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_bills/Values/MyColor.dart';
import 'package:quick_bills/Values/MyStyle.dart';

void showElectricityProviderSheet({
  required Function(Map<String, dynamic> provider) onProviderSelected,
  required List<Map<String, dynamic>> providers,
  required BuildContext context,
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
        color: MyColor.mainWhiteColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Select Service',
            style: MyStyle.tx18Black.copyWith(
              fontWeight: FontWeight.w600,
              color: MyColor.blackColor,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              itemCount: providers.length,
              separatorBuilder: (context, index) => Divider(
                color: MyColor.borderColor,
              ),
              itemBuilder: (context, index) {
                Map<String, dynamic> provider = providers[index];
                return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      onProviderSelected(provider);
                      Get.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            provider['img'],
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            provider['name'],
                            style: MyStyle.tx12Black.copyWith(
                              fontWeight: FontWeight.w400,
                              color: MyColor.blackColor,
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
