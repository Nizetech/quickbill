import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

void bankSelectionSheet({
  required Function(Map<dynamic, String>) onSelect,
}) {
  final themedata = Theme.of(Get.context!).colorScheme;
  final model = Provider.of<AccountProvider>(Get.context!, listen: false);
  showModalBottomSheet(
    isScrollControlled: true,
    context: Get.context!,
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.6,
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: MyColor.mainWhiteColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Text(
              'Select Bank',
              style: MyStyle.tx16Black.copyWith(
                color: themedata.tertiary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            if (model.banksModel.isNotEmpty)
            Expanded(
              child: ListView.builder(
                  itemCount: model.banksModel.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                        onSelect({
                          "id": model.banksModel[index].id!,
                          "name": model.banksModel[index].bankName!
                        });
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                          model.banksModel[index].bankName!,
                        style: MyStyle.tx16Black.copyWith(
                          color: themedata.tertiary,
                          fontWeight: FontWeight.w500,
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
