import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Provider/Account_Provider.dart';
import 'package:jost_pay_wallet/Provider/Auth_provider.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:jost_pay_wallet/common/button.dart';
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
      setState(() {});
    });
  }

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final phoneNumber = TextEditingController();

  void _validateForm(AuthProvider model, AccountProvider account) async {
    if (_formKey.currentState?.validate() ?? false) {
      // loginAccount();
      model.updateProfile(account: account, {
        "first_name": "${firstName.text.trim()} ",
        "last_name": lastName.text.trim(),
        "phone": phoneNumber.text.trim(),
      });
    } else {
      // Form is invalid, no action needed here since warnings are shown automatically
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackBtn(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Consumer<AuthProvider>(builder: (context, model, _) {
        return Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Edit Profile',
                  style: NewStyle.tx28White
                      .copyWith(fontSize: 24, color: MyColor.blackColor),
                ),
                const SizedBox(height: 7),
                const Text(
                  'Edit your profile details',
                  style: MyStyle.tx16Gray,
                ),
                const SizedBox(height: 10),
                Text(
                  'First Name',
                  style: NewStyle.tx14SplashWhite.copyWith(
                      color: MyColor.lightBlackColor,
                      fontWeight: FontWeight.w700,
                      height: 2),
                ),
                TextFormField(
                  style: MyStyle.tx14Black,
                  controller: firstName,
                  decoration: NewStyle.authInputDecoration
                      .copyWith(hintText: 'Enter your first name'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  'Last Name',
                  style: NewStyle.tx14SplashWhite.copyWith(
                      color: MyColor.lightBlackColor,
                      fontWeight: FontWeight.w700,
                      height: 2),
                ),
                TextFormField(
                  style: MyStyle.tx14Black,
                  controller: lastName,
                  decoration: NewStyle.authInputDecoration
                      .copyWith(hintText: 'Enter your last name'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  'Phone Number',
                  style: NewStyle.tx14SplashWhite.copyWith(
                      color: MyColor.lightBlackColor,
                      fontWeight: FontWeight.w700,
                      height: 2),
                ),
                TextFormField(
                  style: MyStyle.tx14Black,
                  controller: phoneNumber,
                  decoration: NewStyle.authInputDecoration
                      .copyWith(hintText: '8061560000'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomButton(
                    text: 'Update Profile',
                    onTap: () =>
                        _validateForm(model, context.read<AccountProvider>()),
                    isLoading: model.isLoading),
              ],
            ),
          ),
        );
      }),
    );
  }
}
