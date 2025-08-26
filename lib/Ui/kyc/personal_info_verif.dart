import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/kyc/id_verif.dart';
import 'package:jost_pay_wallet/Ui/kyc/start_face_detection.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:jost_pay_wallet/common/text_field.dart';
import 'package:jost_pay_wallet/utils/toast.dart';
import 'package:provider/provider.dart';

class PersonalInfoVerif extends StatefulWidget {
  final bool isBasic;
  const PersonalInfoVerif({super.key, required this.isBasic});

  @override
  State<PersonalInfoVerif> createState() => _PersonalInfoVerifState();
}

class _PersonalInfoVerifState extends State<PersonalInfoVerif> {
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final phone = TextEditingController();
  String selectedCode = '';
  @override
  void initState() {
    super.initState();
    final account = Provider.of<AccountProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      firstName.text = account.userModel?.user?.firstName ?? '';
      lastName.text = account.userModel?.user?.lastName ?? '';
      phone.text =
          account.userModel?.user?.phoneNumber?.replaceAll('+', '') ?? '';
      selectedCode = account.userModel?.user?.country ?? 'NG';
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      body: Consumer<AccountProvider>(builder: (context, model, _) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        style: MyStyle.tx18Black.copyWith(
                          color: themedata.tertiary,
                        ),
                      ),
                    ),
                    const Spacer(), // Adds flexible space after the text
                  ],
                ),
                const SizedBox(height: 30),
                Text(
                  'First Name (as it appears on your ID)',
                  style: NewStyle.tx14SplashWhite.copyWith(
                      color: themedata.tertiary,
                      fontWeight: FontWeight.w700,
                      height: 2),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  text: 'Enter your first name',
                  controller: firstName,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 20),
                Text(
                  'Last Name (as it appears on your ID)',
                  style: NewStyle.tx14SplashWhite.copyWith(
                      color: themedata.tertiary,
                      fontWeight: FontWeight.w700,
                      height: 2),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  text: 'Enter your last name',
                  controller: lastName,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 20),
                Text(
                  'Country',
                  style: NewStyle.tx14SplashWhite.copyWith(
                      color: themedata.tertiary,
                      fontWeight: FontWeight.w700,
                      height: 2),
                ),
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
                        textStyle:
                            TextStyle(fontSize: 16, color: themedata.tertiary),
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
                              color: const Color(0xFF8C98A8).withOpacity(0.2),
                            ),
                          ),
                        ),
                      ),
                      onSelect: (Country country) => setState(() {
                        selectedCode = country.countryCode;
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
                          selectedCode,
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
                const SizedBox(height: 20),
                Text(
                  'Phone',
                  style: NewStyle.tx14SplashWhite.copyWith(
                      color: themedata.tertiary,
                      fontWeight: FontWeight.w700,
                      height: 2),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  text: 'Enter your phone number',
                  controller: phone,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 40),
                CustomButton(
                  text: 'Continue',
                  onTap: () {
                    if (firstName.text.isNotEmpty &&
                        lastName.text.isNotEmpty &&
                        selectedCode.isNotEmpty &&
                        phone.text.isNotEmpty) {
                      model.addKycData(
                        {
                          'first_name': firstName.text,
                          'last_name': lastName.text,
                          'country': selectedCode,
                          'phone': phone.text,
                          'verify_type': widget.isBasic ? 0 : 1,
                          if (widget.isBasic) ...{
                            'verify_option': '',
                            'verify_image': '',
                          },
                          'verify_status':
                              widget.isBasic ? 'approved' : 'pending',
                        },
                      );
                      if (!widget.isBasic) {
                        Get.to(() => const IdVerification());
                      } else {
                        Get.to(() => const StartFaceDetection());
                      }
                    } else {
                      ErrorToast('Please fill all the fields');
                    }
                  },
                  radius: 60,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
