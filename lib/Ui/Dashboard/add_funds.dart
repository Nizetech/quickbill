import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_bills/Ui/Dashboard/Home/deposit_summary.dart';
import 'package:quick_bills/Values/MyStyle.dart';
import 'package:quick_bills/Values/MyColor.dart';
import 'package:quick_bills/common/amount_chip.dart';
import 'package:quick_bills/common/appbar.dart';
import 'package:quick_bills/common/button.dart';
import 'package:quick_bills/common/text_field.dart';
import 'package:quick_bills/utils/toast.dart';

class AddFunds extends StatefulWidget {
  final bool isFromNav;
  const AddFunds({super.key, this.isFromNav = false});

  @override
  State<AddFunds> createState() => _AddFundsState();
}

class _AddFundsState extends State<AddFunds> {

  int isSelected = 0;
  final amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Deposit wallet', isBack: !widget.isFromNav),
      body: Padding(
        padding: const EdgeInsets.all(
          20,
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fund Wallet',
                        style: MyStyle.tx16Black.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Deposit via Card/Manually',
                        style: MyStyle.tx16Black.copyWith(
                          fontWeight: FontWeight.w400,
                          color: MyColor.grey,
                        ),
                      ),
                      const SizedBox(height: 50),
                      Text(
                        'Fund Wallet with',
                        style: MyStyle.tx16Black.copyWith(
                          fontWeight: FontWeight.w600,
                          color: MyColor.grey,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DepositType(
                            image: 'assets/images/card_fund.png',
                            onTap: (value) {
                              setState(() {
                                isSelected = 0;
                              });
                            },
                            isSelected: isSelected == 0,
                          ),
                          const SizedBox(width: 10),
                          DepositType(
                            image: 'assets/images/manual_fund.png',
                            onTap: (value) {
                              setState(() {
                                isSelected = 1;
                              });
                            },
                            isSelected: isSelected == 1,
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Amount',
                            style: MyStyle.tx14Black
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          AmountChip(),
                        ],
                      ),
                      
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        text: 'Enter amount',
                        preffixIcon: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                          child: Text(
                            '₦',
                            style: MyStyle.tx14Black.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
            CustomButton(
              text: 'Continue',
              onTap: () {
                final amount = double.tryParse(amountController.text);
                if (amount == null || amount < 0) {
                  ErrorToast('Please enter a valid amount');
                  return;
                } else {
              
                  Get.to(
                    DepositSummary(
                      amount: amount.toString(),
                      isCard: isSelected == 0,
                    ),
                  );
                }
            
              },
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

class DepositType extends StatelessWidget {
  final String image;
  final void Function(bool?)? onTap;
  final bool isSelected;
  const DepositType({
    super.key,
    required this.image,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => onTap!(isSelected),
          child: Image.asset(
            image,
            height: 120,
          ),
        ),
        Positioned(
            bottom: 0,
            left: 0,
            child: Checkbox(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              side: BorderSide(
                color: MyColor.mainWhiteColor,
                width: 2,
              ),
              activeColor: MyColor.primaryColor,
              checkColor: MyColor.mainWhiteColor,
              value: isSelected,
              onChanged: onTap,
            )),
      ],
    );
  }
}
