import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Models/country_model.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/car/repair_screen.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';

void cardCountrySheet({
  required ThemeProvider themeProvider,
  required Function(Country) onSelect,
  required List<Country>? countries,
}) {
  final themedata = Theme.of(Get.context!).colorScheme;
  List<Country> filteredCountry = countries!;
  final search = TextEditingController();
  showModalBottomSheet(
    isScrollControlled: true,
    context: Get.context!,
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, setState) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
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
                'Select Country',
                style: MyStyle.tx16Black.copyWith(
                  color: themedata.tertiary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                text: 'Search country',
                enabled: true,
                controller: search,
                preffixIcon: Icons.search,
                onChanged: (value) {
                  setState(() {
                    if (value.isEmpty) {
                      filteredCountry = countries;
                    } else {
                      filteredCountry = countries
                          .where((element) => element.countryName!
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                    }
                  });
                },
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredCountry.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.back();
                        onSelect(filteredCountry[index]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 15,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: SvgPicture.network(
                                  fit: BoxFit.cover,
                                  filteredCountry[index].countryFlag!,
                                ),
                              ),
                            ),

                            // CachedNetworkImage(
                            //     imageUrl: filteredCountry[index].countryFlag!,
                            //     height: 20,
                            //     width: 20,
                            //     fit: BoxFit.cover,
                            //     placeholder: (context, url) => Container(),
                            //     errorWidget: (context, url, error) =>
                            //         Container()),
                            const SizedBox(width: 15),
                            Text(
                              filteredCountry[index].countryName!,
                              style: MyStyle.tx16Black.copyWith(
                                color: themedata.tertiary,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
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
