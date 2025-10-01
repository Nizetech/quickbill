import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Values/utils.dart';

class ConnectWithUs extends StatefulWidget {
  const ConnectWithUs({super.key});

  @override
  State<ConnectWithUs> createState() => _ConnectWithUsState();
}

class _ConnectWithUsState extends State<ConnectWithUs> {
  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Connect with us',
          style: MyStyle.tx18Black.copyWith(color: themedata.tertiary),
        ),
        leading: Transform.translate(
          offset: const Offset(10, -8),
          child: BackBtn(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Follow us on',
              style: MyStyle.tx18Black.copyWith(
                color: themedata.tertiary,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Get the latest updates, promos and support. Tap any of the links below to follow us.',
              style: MyStyle.tx14Black.copyWith(
                color: MyColor.grey02Color,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _buildSocialMediaCard(
                  url: Utils.facebookLink,
                  img: 'assets/images/facebook.png',
                  title: 'Facebook',
                ),
                _buildSocialMediaCard(
                  url: Utils.xLink,
                  img: 'assets/images/x_icon.png',
                  title: 'X',
                ),
                _buildSocialMediaCard(
                  url: Utils.telegramLink,
                  img: 'assets/images/telegram.png',
                  title: 'Telegram',
                ),
                _buildSocialMediaCard(
                  url: Utils.instagramLink,
                  img: 'assets/images/ig_icon.jpeg',
                  title: 'Instagram',
                ),
                _buildSocialMediaCard(
                  url: Utils.tiktokLink,
                  img: 'assets/images/tiktok.png',
                  title: 'Tiktok',
                ),
                _buildSocialMediaCard(
                  url: Utils.linkedinLink,
                  img: 'assets/images/linikedIn.png',
                  title: 'LinkedIn',
                ),
                _buildSocialMediaCard(
                  url: Utils.youtubeLink,
                  img: 'assets/images/youtube.jpeg',
                  title: 'Youtube',
                ),
                _buildSocialMediaCard(
                  url: Utils.whatsappLink,
                  img: 'assets/images/whatsapp.png',
                  title: 'Whatsapp',
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: themedata.tertiary.withOpacity(0.1),
                    thickness: 1,
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  'Or',
                  style: MyStyle.tx14Black.copyWith(
                    color: themedata.tertiary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Divider(
                    color: themedata.tertiary.withOpacity(0.1),
                    thickness: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: 'Need support?\n',
                    style: MyStyle.tx14Black.copyWith(
                      color: themedata.tertiary,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                        text: 'Message us directly',
                        style: MyStyle.tx14Black.copyWith(
                          color: themedata.tertiary,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'support@jostpay.com',
                  style: MyStyle.tx14Black.copyWith(
                    color: themedata.tertiary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialMediaCard({
    required String url,
    required String img,
    required String title,
  }) {
    final themedata = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () async {
        launchUrl(Uri.parse(url));
      },
      child: Container(
        height: 105,
        width: 105,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          // color: Color(0xffF5F5F5),
          color: themedata.secondaryContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 40,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xff1877F2).withOpacity(0.1)),
                color: Theme.of(context).scaffoldBackgroundColor,
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(img)),
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: NewStyle.btnTx16SplashBlue.copyWith(
                color: themedata.tertiary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
