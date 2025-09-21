import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Wallet/widget/select_bank_sheet.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:jost_pay_wallet/common/text_field.dart';
import 'package:jost_pay_wallet/utils/toast.dart';
import 'package:provider/provider.dart';

class DepositDetails extends StatefulWidget {
  final String title;
  final bool isCard;
  const DepositDetails({super.key, required this.title, this.isCard = false});

  @override
  State<DepositDetails> createState() => _DepositDetailsState();
}

class _DepositDetailsState extends State<DepositDetails> {
  @override
  void initState() {
    final model = Provider.of<AccountProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      model.getBanks();
    });
    super.initState();
  }

  final amount = TextEditingController();
  final bank = TextEditingController();
  String bankID = '';

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      body: Consumer<AccountProvider>(builder: (context, model, _) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
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
                        widget.title,
                        style: MyStyle.tx18Black
                            .copyWith(color: themedata.tertiary),
                      ),
                    ),
                    const Spacer(), // Adds flexible space after the text
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: MyColor.greenColor.withValues(alpha: .1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "This is a manual bank deposit option and may take up to 24 hours to reflect in your balance. For faster deposits, choose the Bank Transfer (Automatic) via a virtual account or use the card deposit option.",
                            style: MyStyle.tx14Black
                                .copyWith(color: MyColor.greenColor),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text.rich(
                          TextSpan(
                            text: 'Amount ',
                            style: MyStyle.tx14Black.copyWith(
                                color: themedata.tertiary,
                                fontWeight: FontWeight.w500),
                            children: [
                              TextSpan(
                                text: '(Min: 100 NGN)',
                                style: MyStyle.tx14Black.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        CustomTextField(
                          text: 'Enter amount',
                          controller: amount,
                       
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Bank',
                          style: MyStyle.tx14Black.copyWith(
                              color: themedata.tertiary,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            bankSelectionSheet(
                              themeProvider: themeProvider,
                              onSelect: (value) {
                                setState(() {
                                  bank.text = value['name']!;
                                  bankID = value['id']!;
                                });
                              },
                            );
                          },
                          child: CustomTextField(
                            text: 'Select a bank',
                            controller: bank,
                            enabled: false,
                            suffixIcon: Icons.keyboard_arrow_down_rounded,
                          ),
                        ),
                        SizedBox(height: 40),
                        CustomButton(
                          text: 'Proceed',
                          onTap: () {
                            if (model.userModel?.user?.idVerified == false &&
                                num.parse(amount.text) > 20000) {
                              ErrorToast(
                                  "You must complete full verification on your account before you can deposit more than 20,000 NGN.");
                              return;
                            } else
                            if (amount.text.isEmpty || bank.text.isEmpty) {
                              ErrorToast('Please fill all fields');
                            } else if (int.parse(amount.text) <= 100) {
                              ErrorToast('Amount must be greater than 100');
                            } else {
                              model.getDepositInvoice(
                                bankID: bankID,
                                amount: amount.text,
                              );
                            }
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
      ),
    );
  }
}
