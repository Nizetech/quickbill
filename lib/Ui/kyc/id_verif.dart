import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/kyc/id_verif_info.dart';
import 'package:jost_pay_wallet/Ui/kyc/widget/info_wrap.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:provider/provider.dart';

class IdVerification extends StatefulWidget {
  const IdVerification({super.key});

  @override
  State<IdVerification> createState() => _IdVerificationState();
}

class _IdVerificationState extends State<IdVerification> {
  final List<Map> idTypes = [
    {
      'name': 'National ID',
      'img': 'assets/images/national.svg',
      'dk_img': 'assets/images/national_dr.svg',
    },
    {
      'name': 'Passport',
      'img': 'assets/images/pass.svg',
      'image': 'assets/images/pass_dr.png',
    },
    {
      'name': 'Driver\'s License',
      'img': 'assets/images/license.svg',
      'dk_img': 'assets/images/license_dr.svg',
    },
    {
      'name': 'Voter\'s Card',
      'img': 'assets/images/national.svg',
      'dk_img': 'assets/images/national_dr.svg',
    },
  ];
  int selectedIndex = -1;
  String selectedCountry = 'Nigeria';
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    final account = Provider.of<AccountProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      'assets/images/arrow_left.png',
                      color: themeProvider.isDarkMode()
                          ? MyColor.mainWhiteColor
                          : MyColor.dark01Color,
                    ),
                  ),
                  const Spacer(),
                  Transform.translate(
                    offset: const Offset(-20, 0),
                    child: Text(
                      'KYC Verification',
                      style:
                          MyStyle.tx18Black.copyWith(color: themedata.tertiary),
                    ),
                  ),
                  const Spacer(), // Adds flexible space after the text
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      InfoWrap(
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/warning.svg',
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                  'ID Verification: kindly provide your valid government  \nID card for further verification',
                                  style: MyStyle.tx14Black.copyWith(
                                    color: themedata.tertiary,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text('Government ID Verification',
                          style: MyStyle.tx18Black.copyWith(
                            color: themedata.tertiary,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          )),
                      const SizedBox(height: 5),
                      Text(
                        'We accept the following document',
                        style: MyStyle.tx14Black.copyWith(
                          color: MyColor.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 30),
                      ListView.separated(
                        itemCount: idTypes.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (_, i) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: MyColor.grey01Color.withOpacity(0.2),
                              ),
                            ),
                            child: Row(
                              children: [
                                idTypes[index]['dk_img'] == null
                                    ? Image.asset(
                                        idTypes[index]['image'],
                                      )
                                    : SvgPicture.asset(
                                        themeProvider.isDarkMode()
                                            ? idTypes[index]['dk_img']
                                            : idTypes[index]['img'],
                                      ),
                                const SizedBox(width: 10),
                                Text(idTypes[index]['name'],
                                    style: MyStyle.tx14Black.copyWith(
                                      color: themedata.tertiary,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    )),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  },
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.transparent,
                                      border: selectedIndex != index
                                          ? Border.all(
                                              color: themedata.tertiary,
                                              width: 2,
                                            )
                                          : null,
                                    ),
                                    child: selectedIndex == index
                                        ? Icon(
                                            Icons.check_circle,
                                            color: MyColor.greenColor,
                                            size: 23,
                                          )
                                        : const SizedBox.shrink(),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Text('Document issued country',
                          style: MyStyle.tx18Black.copyWith(
                            color: themedata.tertiary,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          )),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          showCountryPicker(
                            context: context,
                            countryListTheme: CountryListThemeData(
                              flagSize: 25,
                              backgroundColor: themeProvider.isDarkMode()
                                  ? MyColor.dark01Color
                                  : MyColor.mainWhiteColor,
                              searchTextStyle: TextStyle(
                                color: themedata.tertiary,
                              ),
                              textStyle: TextStyle(
                                  fontSize: 16, color: themedata.tertiary),
                              bottomSheetHeight: 500,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                              inputDecoration: InputDecoration(
                                hintText: 'Search',
                                hintStyle: TextStyle(
                                  color: themedata.tertiary,
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: themedata.tertiary,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: MyColor.borderColor,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: MyColor.borderColor,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: const Color(0xFF8C98A8)
                                        .withOpacity(0.2),
                                  ),
                                ),
                              ),
                            ),
                            onSelect: (Country country) => setState(() {
                              selectedCountry = country.name;
                            }),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 17,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: MyColor.borderColor.withValues(alpha: 0.2),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedCountry,
                                style: MyStyle.tx12Black.copyWith(
                                  color: themedata.tertiary,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                              const Spacer(),
                              Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: themedata.tertiary,
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 30),
                      CustomButton(
                        text: 'Continue',
                        onTap: () {
                          account.addKycData({
                            'national_id': selectedIndex == 0
                                ? 'national_id'
                                : selectedIndex == 1
                                    ? 'passport'
                                    : selectedIndex == 2
                                        ? 'driver_license'
                                        : 'voter_card',
                            'country': selectedCountry,
                          });
                          Get.to(() => const IdVerificationInfo());
                        },
                        radius: 60,
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
