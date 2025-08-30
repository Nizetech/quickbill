import 'dart:developer';

import 'package:country_state_picker/country_state_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:jost_pay_wallet/common/text_field.dart';
import 'package:jost_pay_wallet/common/upgrader.dart';
import 'package:jost_pay_wallet/utils/toast.dart';
import 'package:provider/provider.dart';

class VirtualAccountCreation extends StatefulWidget {
  const VirtualAccountCreation({super.key});

  @override
  State<VirtualAccountCreation> createState() => _VirtualAccountCreationState();
}

class _VirtualAccountCreationState extends State<VirtualAccountCreation> {
  TextEditingController passwordController = TextEditingController();

  String countryValue = "";

  // final LocalAuthentication auth = LocalAuthentication();
  late String deviceId;
  bool fingerOn = false;
  String isLogin = "";

  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _titleController = TextEditingController();
  final _lastName = TextEditingController();
  final _firstName = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _dateController = TextEditingController();
  final _addressLine1Controller = TextEditingController();
  final _addressLine2Controller = TextEditingController();
  final _cityController = TextEditingController();
  final _genderController = TextEditingController();
  String selectedCountryCode = '234';
  String selectedCountry = '';
  String selectedState = '';

  List<String> title = [
    'Mr',
    'Mrs',
    'Miss',
  ];
  List<String> gender = [
    'Male',
    'Female',
  ];

  void _validateForm(AccountProvider model) async {
    // log("${_emailController.text.trim()},\n ${_firstName.text.trim()},\n ${_lastName.text.trim()},\n ${selectedCountry},\n ${selectedState},\n ${_cityController.text.trim()},\n ${_addressLine1Controller.text.trim()},\n ${_addressLine2Controller.text.trim()},\n ${_dateController.text.trim()},\n ${_timeController.text.trim()},\n ${_phoneNumberController.text.trim()} \n State: $selectedState \n Country: $selectedCountry \n City: ${_cityController.text.trim()} \n Address Line 1: ${_addressLine1Controller.text.trim()} \n Address Line 2: ${_addressLine2Controller.text.trim()} \n Date of Birth: ${_dateController.text.trim()} \n Title: ${_timeController.text.trim()} \n Phone Number: ${_phoneNumberController.text.trim()}");
    Map<String, dynamic> data = {
      "user_id": model.userModel?.user?.id,
      "first_name": _firstName.text.trim(),
      "last_name": _lastName.text.trim(),
      "email": _emailController.text.trim(),
      "phone": _phoneNumberController.text.trim(),
      "address1": _addressLine1Controller.text.trim(),
      "address2": _addressLine2Controller.text.trim(),
      "city": _cityController.text.trim(),
      "state": selectedState,
      // "country": selectedCountry.toUpperCase(),
      "birthday": _dateController.text.trim(),
      "title": _titleController.text.trim(),
      "gender": _genderController.text.trim(),
    };
    log(data.toString());
    if (_formKey.currentState?.validate() != true) {
      return;
    }
    if (selectedCountry.isEmpty) {
      ErrorToast('Please select a country');
      return;
    } else if (selectedState.isEmpty) {
      ErrorToast('Please select a state');
      return;
    } else if (_titleController.text.trim().isEmpty) {
      ErrorToast('Please select a title');
      return;
    } else if (_genderController.text.trim().isEmpty) {
      ErrorToast('Please select a gender');
      return;
    } else if (_dateController.text.trim().isEmpty) {
      ErrorToast('Please select a date of birth');
      return;
    } else {
      model.createVirtualAccount(
          data: data,
          onSuccess: () {
            // Get.to(const PaymentPayment());
            model.getUserProfile(onSuccess: () {
              Get.close(2);
              SuccessToast('Virtual account created successfully');
            });
          });
    }
  }

  @override
  void initState() {
    super.initState();
    final account = context.read<AccountProvider>();
    _firstName.text = account.userModel?.user?.firstName ?? '';
    _lastName.text = account.userModel?.user?.lastName ?? '';
    _emailController.text = account.userModel?.user?.email ?? '';
    _phoneNumberController.text = account.userModel?.user?.phoneNumber ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AccountProvider>();
    final themeProvider = Provider.of<ThemeProvider>(context);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      body: Consumer<AccountProvider>(builder: (context, ctr, _) {
        return AppUpgrader(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () => Get.back(),
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
                          'Create Virtual Account',
                          style: MyStyle.tx18Black.copyWith(
                            color: themedata.tertiary,
                          ),
                        ),
                      ),
                      const Spacer(), // Adds flexible space after the text
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                Text(
                                  'First Name',
                                  style: NewStyle.tx14SplashWhite.copyWith(
                                      color: themedata.tertiary,
                                      fontWeight: FontWeight.w700,
                                      height: 2),
                                ),
                                CustomTextField(
                                  text: 'Enter your first name',
                                  controller: _firstName,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter the valid name';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  'Last Name',
                                  style: NewStyle.tx14SplashWhite.copyWith(
                                      color: themedata.tertiary,
                                      fontWeight: FontWeight.w700,
                                      height: 2),
                                ),
                                CustomTextField(
                                  text: 'Enter your last name',
                                  controller: _lastName,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter the valid name';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  'Email',
                                  style: NewStyle.tx14SplashWhite.copyWith(
                                      color: themedata.tertiary,
                                      fontWeight: FontWeight.w700,
                                      height: 2),
                                ),
                                CustomTextField(
                                  text: 'Enter your email address',
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  enabled: false,
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  'Phone Number',
                                  style: NewStyle.tx14SplashWhite.copyWith(
                                      color: themedata.tertiary,
                                      fontWeight: FontWeight.w700,
                                      height: 2),
                                ),
                                CustomTextField(
                                  text: 'Enter your phone number',
                                  controller: _phoneNumberController,
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a valid phone number';
                                    } else if (value.length < 10) {
                                      return 'Please enter a valid phone number';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  'Address Line 1',
                                  style: NewStyle.tx14SplashWhite.copyWith(
                                      color: themedata.tertiary,
                                      fontWeight: FontWeight.w700,
                                      height: 2),
                                ),
                                CustomTextField(
                                  text: 'Enter your address line 1',
                                  controller: _addressLine1Controller,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a valid address line 1';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  'Address Line 2',
                                  style: NewStyle.tx14SplashWhite.copyWith(
                                      color: themedata.tertiary,
                                      fontWeight: FontWeight.w700,
                                      height: 2),
                                ),
                                CustomTextField(
                                  text: 'Enter your address line 2',
                                  controller: _addressLine2Controller,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a valid address line 2';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  'Date of Birth',
                                  style: NewStyle.tx14SplashWhite.copyWith(
                                      color: themedata.tertiary,
                                      fontWeight: FontWeight.w700,
                                      height: 2),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1800),
                                        lastDate: DateTime.now(),
                                        builder: (context, child) {
                                          return Theme(
                                            data: Theme.of(context).copyWith(
                                              colorScheme: ColorScheme.light(
                                                primary: MyColor.progressBar,
                                              ),
                                              dialogBackgroundColor:
                                                  MyColor.mainWhiteColor,
                                            ),
                                            child: child!,
                                          );
                                        }).then((value) {
                                      if (value != null) {
                                        setState(() {
                                          _dateController.text =
                                              DateFormat('dd/MM/yyyy')
                                                  .format(value);
                                        });
                                      }
                                    });
                                  },
                                  child: CustomTextField(
                                    controller: _dateController,
                                    text: "Select Date",
                                    suffixIcon: Icons.expand_more,
                                    enabled: false,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  'Title',
                                  style: NewStyle.tx14SplashWhite.copyWith(
                                      color: themedata.tertiary,
                                      fontWeight: FontWeight.w700,
                                      height: 2),
                                ),
                                PopupMenuButton(
                                  color: themeProvider.isDarkMode()
                                      ? const Color(0XFF33353C)
                                      : MyColor.textFieldFillColor,
                                  position: PopupMenuPosition.under,
                                  itemBuilder: (_) => <PopupMenuItem<String>>[
                                    ...title.map((e) => PopupMenuItem<String>(
                                        value: e.toString(),
                                        child: Text(
                                          e.toString(),
                                          style: MyStyle.tx14Black.copyWith(
                                            color: themedata.tertiary,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ))),
                                  ],
                                  onSelected: (val) {
                                    setState(() {
                                      _titleController.text = val.toString();
                                    });
                                  },
                                  child: CustomTextField(
                                    text: "Select Title",
                                    controller: _titleController,
                                    suffixIcon: Icons.expand_more,
                                    enabled: false,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  'Gender',
                                  style: NewStyle.tx14SplashWhite.copyWith(
                                      color: themedata.tertiary,
                                      fontWeight: FontWeight.w700,
                                      height: 2),
                                ),
                                PopupMenuButton(
                                  color: themeProvider.isDarkMode()
                                      ? const Color(0XFF33353C)
                                      : MyColor.textFieldFillColor,
                                  position: PopupMenuPosition.under,
                                  itemBuilder: (_) => <PopupMenuItem<String>>[
                                    ...gender.map((e) => PopupMenuItem<String>(
                                        value: e.toString(),
                                        child: Text(
                                          e.toString(),
                                          style: MyStyle.tx14Black.copyWith(
                                            color: themedata.tertiary,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ))),
                                  ],
                                  onSelected: (val) {
                                    setState(() {
                                      _genderController.text = val.toString();
                                    });
                                  },
                                  child: CustomTextField(
                                    text: "Select Gender",
                                    controller: _genderController,
                                    suffixIcon: Icons.expand_more,
                                    enabled: false,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                CountryStatePicker(
                                  hintTextStyle: TextStyle(
                                    fontSize: 13,
                                  ),
                                  dropdownColor: themeProvider.isDarkMode()
                                      ? const Color(0XFF33353C)
                                      : MyColor.textFieldFillColor,
                                  itemTextStyle: TextStyle(
                                    color: themedata.tertiary,
                                  ),
                                  countryLabel: Text(
                                    'Country',
                                    style: NewStyle.tx14SplashWhite.copyWith(
                                        color: themedata.tertiary,
                                        fontWeight: FontWeight.w700,
                                        height: 2),
                                  ),
                                  stateLabel: Text(
                                    'State',
                                    style: NewStyle.tx14SplashWhite.copyWith(
                                        color: themedata.tertiary,
                                        fontWeight: FontWeight.w700,
                                        height: 2),
                                  ),
                                  onCountryChanged: (ct) => setState(() {
                                    selectedCountry = ct;
                                  }),
                                  onStateChanged: (st) => setState(() {
                                    selectedState = st;
                                  }),
                                  inputDecoration: InputDecoration(
                                    enabledBorder: _buildEnabledBorder(
                                        themeProvider.isDarkMode()),
                                    focusedBorder: _buildEnabledBorder(
                                        themeProvider.isDarkMode()),
                                    border: _buildEnabledBorder(
                                        themeProvider.isDarkMode()),
                                    hintText: 'Select Country',
                                    hintStyle: TextStyle(
                                      color: themedata.tertiary,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  'City',
                                  style: NewStyle.tx14SplashWhite.copyWith(
                                      color: themedata.tertiary,
                                      fontWeight: FontWeight.w700,
                                      height: 2),
                                ),
                                CustomTextField(
                                  text: 'Enter your city',
                                  controller: _cityController,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a valid city';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          CustomButton(
                              text: 'Create Account',
                              isLoading: model.isLoading,
                              onTap: () {
                                _validateForm(model);
                              }),
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
      }),
    );
  }

  OutlineInputBorder _buildEnabledBorder(bool isDark) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        width: 1.2,
        color: !isDark ? const Color(0xffE9EBF8) : const Color(0xff1B1B1B),
      ),
    );
  }
}
