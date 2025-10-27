import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick_bills/Provider/account_provider.dart';
import 'package:quick_bills/Ui/Dashboard/Home/widget/select_bank_sheet.dart';
import 'package:quick_bills/Values/MyColor.dart';
import 'package:quick_bills/Values/MyStyle.dart';
import 'package:quick_bills/common/appbar.dart';
import 'package:quick_bills/common/button.dart';
import 'package:quick_bills/common/text_field.dart';
import 'package:quick_bills/utils/toast.dart';
import 'package:provider/provider.dart';

class DepositDetails extends StatefulWidget {
  final String amount;
  const DepositDetails({
    super.key,
    required this.amount,
  });

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
    return Scaffold(
      appBar: appBar(title: 'Select Bank'),
      body: Consumer<AccountProvider>(builder: (context, model, _) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: MyColor.primaryColor.withValues(alpha: .1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "This is a manual bank deposit option and may take up to 24 hours to reflect in your balance. For faster deposits, choose the Bank Transfer (Automatic) via a virtual account or use the card deposit option.",
                          style: MyStyle.tx14Black
                              .copyWith(color: MyColor.primaryColor),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Bank',
                        style: MyStyle.tx14Black.copyWith(
                            color: MyColor.blackColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      GestureDetector(
                        onTap: () {
                          bankSelectionSheet(
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
                    ],
                  ),
                ),
              ),
              CustomButton(
                text: 'Proceed',
                onTap: () {
                  if (bankID.isEmpty) {
                    ErrorToast('Please select a bank');
                    return;
                  } else {
                    model.getDepositInvoice(
                      bankID: bankID,
                      amount: widget.amount,
                    );
                  }
                },
              ),
              SizedBox(height: 40),
            ],
          ),
        );
      }),
    );
  }
}
