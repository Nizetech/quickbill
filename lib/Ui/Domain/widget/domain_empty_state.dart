import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:url_launcher/url_launcher.dart';

class DomainEmptyState extends StatelessWidget {
  const DomainEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: MyColor.greenColor,
            child: Icon(
              Icons.laptop_windows_rounded,
              size: 40,
              color: themedata.onSurface,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'No Hosting, Domain or SSL Yet',
            style: MyStyle.tx16Black.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: MyColor.greenColor,
            ),
          ),
          SizedBox(height: 20),
          Text(
            textAlign: TextAlign.center,
            'You have not purchased any hosting, domain, or SSL plan yet. To get started, please visit our website to purchase a plan.',
            style: MyStyle.tx14Black.copyWith(
              fontWeight: FontWeight.w400,
              color: themedata.tertiary,
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 45,
            child: CustomButton(
              text: 'Visit Jostpay Website',
              onTap: () {
                launchUrl(Uri.parse('https://jostpay.com'));
              },
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 45,
            child: CustomButton(
              text: 'Back to Dashboard',
              onTap: () => Navigator.pop(context),
              bgColor: Colors.grey.shade200,
              textColor: themedata.tertiary,
            ),
          ),
        ],
      ),
    );
  }
}
