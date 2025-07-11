import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/common/success_screen.dart';
import 'package:provider/provider.dart';

class SocialSuccessScreen extends StatefulWidget {
  final bool isGiftCard;
  const SocialSuccessScreen({super.key, this.isGiftCard = false});

  @override
  State<SocialSuccessScreen> createState() => _SocialSuccessScreenState();
}

class _SocialSuccessScreenState extends State<SocialSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AccountProvider>(context, listen: false);
    return SuccessScreen(
      title: widget.isGiftCard
          ? "Gift card purchased successfully"
          : "Social boost order placed successfully.",
      subtitle: widget.isGiftCard
          ? "GiftCard orders are usually completed within 24 hours."
          : "SocialBoost orders complete within minutes to hours.",   
      onTap: () {
        if (widget.isGiftCard) {
                    model.getGiftCradHistory(isLoading: false);
                  } else {
                    model.getSociaBoostHistory(isLoading: false);
                  }
                  Get.close(4);
      },
    );
  }
}
