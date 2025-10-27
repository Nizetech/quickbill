import 'package:flutter/material.dart';
import 'package:quick_bills/Provider/account_provider.dart';
import 'package:quick_bills/Provider/auth_provider.dart';
import 'package:quick_bills/Values/MyColor.dart';
import 'package:quick_bills/Values/MyStyle.dart';
import 'package:quick_bills/common/appbar.dart';
import 'package:quick_bills/common/button.dart';
import 'package:quick_bills/common/text_field.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final auth = Provider.of<AccountProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      firstName.text = auth.userModel!.user!.firstName!;
      lastName.text = auth.userModel!.user!.lastName!;
      phoneNumber.text = auth.userModel!.user!.phoneNumber!;
      email.text = auth.userModel!.user!.email!;
     
      setState(() {});
    });
  }

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final phoneNumber = TextEditingController();
  final email = TextEditingController();

  void _validateForm(AuthProvider model, AccountProvider account) async {
    if (_formKey.currentState?.validate() ?? false) {
      // loginAccount();
      model.updateProfile(account: account, {
        "first_name": firstName.text.trim(),
        "last_name": lastName.text.trim(),
        "phone": phoneNumber.text.trim(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Update Info'),
      body: Consumer<AuthProvider>(builder: (context, model, _) {
        return Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          'Update Profile',
                          style: MyStyle.tx16Black.copyWith(
                            color: MyColor.blackColor,
                          ),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          'Update your profile below',
                          style: MyStyle.tx16Gray.copyWith(
                            color: MyColor.blackColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 20),
                        requiredLabel('First Name'),
                        CustomTextField(
                          text: 'Enter your first name',
                          controller: firstName,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your first name';
                            }
                            return null;
                          },
                        ),
                    
                        const SizedBox(height: 20),
                        requiredLabel('Last Name'),
                        CustomTextField(
                          text: 'Enter your last name',
                          controller: lastName,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your last name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        requiredLabel('Email address'),
                        CustomTextField(
                          text: 'Enter your email address',
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          enabled: false,
                        ),
                        const SizedBox(height: 20),
                        requiredLabel('Phone Number'),
                        CustomTextField(
                          text: 'Enter your phone number',
                          controller: phoneNumber,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                        ),    
                     
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                CustomButton(
                    radius: 40,
                    text: 'Update Profile',
                    onTap: () =>
                        _validateForm(model, context.read<AccountProvider>()),
                    isLoading: model.isLoading),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      }),
    );
  }
}

requiredLabel(String title) => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text.rich(TextSpan(
          text: title,
          style: MyStyle.tx14Black.copyWith(
            color: MyColor.blackColor,
            fontWeight: FontWeight.w400,
          ),
          children: [
            TextSpan(
              text: ' *',
              style: MyStyle.tx16Black.copyWith(
                color: MyColor.redColor,
              ),
            )
          ])),
    );
