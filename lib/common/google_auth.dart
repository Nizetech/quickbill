import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jost_pay_wallet/Provider/DashboardProvider.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/auth_provider.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:jost_pay_wallet/constants/constants.dart';
import 'package:provider/provider.dart';

class GoogleAuth extends StatefulWidget {
  final String text;
  final bool isLogin;
  const GoogleAuth({
    super.key,
    required this.text,
    this.isLogin = true,
  });

  @override
  State<GoogleAuth> createState() => _GoogleAuthState();
}

class _GoogleAuthState extends State<GoogleAuth> {
  final box = Hive.box(kAppName);
  @override
  Widget build(BuildContext context) {
    final model = context.read<AuthProvider>();
    final dash = context.read<DashboardProvider>();
    final account = context.read<AccountProvider>();
    return Column(
      children: [
        if (widget.isLogin) _buildOrDivider(widget.isLogin),
        GestureDetector(
          onTap: () async {
            model.googleAuth(
              fcmToken: box.get(kDeviceToken),
              dashProvider: dash,
              account: account,
            );
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Color(0xffF5F5F5),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Color(0xff1877F2).withOpacity(0.1)),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: SvgPicture.asset('assets/images/g_icon.svg'),
                ),
                Spacer(),
                Text(
                  widget.text,
                  style: NewStyle.btnTx16SplashBlue.copyWith(
                      color: Color(0xff656464),
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
        if (!widget.isLogin) _buildOrDivider(widget.isLogin),
      ],
    );
  }

  Widget _buildOrDivider(bool isLogin) {
    return Column(
      children: [
        if (isLogin) const SizedBox(height: 5) else const SizedBox(height: 10),
        Row(
          children: [
            _buildDivider(),
            const SizedBox(width: 10),
            Text(
              'Or',
              style: NewStyle.btnTx16SplashBlue.copyWith(
                  fontSize: 14,
                  color: Color(0xff656464),
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(width: 10),
            _buildDivider(),
          ],
        ),
        // if (!isLogin) const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildDivider() {
    return Expanded(
        child: Divider(
      color: Colors.grey[200],
    ));
  }
}
