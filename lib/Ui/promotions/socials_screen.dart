import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/promotions/social_boost.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

class SocialsScreen extends StatelessWidget {
  const SocialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: -90,
            right: -25,
            child: Container(
                height: 296,
                width: 296,
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(bottom: 32),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: MyColor.greenColor,
                ),
                child: Image.asset(
                  'assets/images/promoLogo.png',
                )),
          ),
          Positioned(
            top: 36.h,
            left: 24,
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  "assets/images/arrow_left.png",
                  fit: BoxFit.cover,
                  color: themeProvider.isDarkMode()
                      ? MyColor.mainWhiteColor
                      : MyColor.dark01Color,
                )),
          ),
          Positioned(
            top: 233,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              // physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Social Boosting',
                    style: MyStyle.tx16Green,
                  ),
                  Text(
                    'Select any social media platforms to boost!!',
                    style: MyStyle.tx18Black.copyWith(
                        fontSize: 26,
                        color: themedata.tertiary,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: GridView.builder(
                      shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemCount: socialsData.length,
                      itemBuilder: (context, index) {
                        final social = socialsData[index];
                        return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const SocialBoost(),
                              ));
                            },
                            child: SocialCard(model: social));
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SocialCard extends StatelessWidget {
  const SocialCard({
    super.key,
    required this.model,
  });
  final SocialModel model;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Column(
      children: [
        model.imagePath.endsWith('png')
            ? Image.asset(
                model.imagePath,
                height: 44.r,
                width: 44.r,
              )
            : SvgPicture.asset(
                model.imagePath,
                height: 44.r,
                width: 44.r,
              ),
        SizedBox(
          height: 4.h,
        ),
        Text(
          model.title,
          style: MyStyle.tx16Black
              .copyWith(fontWeight: FontWeight.w400, color: theme.tertiary),
        ),
      ],
    );
  }
}

class SocialModel {
  final String title, imagePath;

  SocialModel({required this.title, required this.imagePath});
}

final socialsData = [
  SocialModel(imagePath: 'assets/images/svg/youtube.svg', title: 'Youtube'),
  SocialModel(imagePath: 'assets/images/svg/threads.svg', title: 'Thread'),
  SocialModel(imagePath: 'assets/images/svg/telegram.svg', title: 'Telegram'),
  SocialModel(imagePath: 'assets/images/svg/linkedin.svg', title: 'Linkedln'),
  SocialModel(imagePath: 'assets/images/svg/spotify.svg', title: 'Spoify'),
  SocialModel(imagePath: 'assets/images/svg/pinterest.svg', title: 'Pinterest'),
  SocialModel(imagePath: 'assets/images/svg/tiktok.svg', title: 'Tiktok'),
  SocialModel(imagePath: 'assets/images/svg/twitch.svg', title: 'Twitch'),
  SocialModel(imagePath: 'assets/images/svg/snapchat.svg', title: 'SnapChat'),
  SocialModel(imagePath: 'assets/images/svg/onlyfans.svg', title: 'Onlyfan'),
  SocialModel(imagePath: 'assets/images/svg/kick.svg', title: 'Kick'),
  SocialModel(
      imagePath: 'assets/images/svg/dailymotion.svg', title: 'Daily motion'),
  SocialModel(imagePath: 'assets/images/svg/vimeo.svg', title: 'Vimeo'),
  SocialModel(imagePath: 'assets/images/svg/rumble.svg', title: 'Rumble'),
  SocialModel(imagePath: 'assets/images/svg/shopee.svg', title: 'Shopee'),
  SocialModel(imagePath: 'assets/images/svg/reddit.svg', title: 'Reddit'),
  SocialModel(imagePath: 'assets/images/svg/whatsapp.svg', title: 'What’sapp'),
  SocialModel(imagePath: 'assets/images/chizzy.png', title: 'Chzzk'),
  SocialModel(imagePath: 'assets/images/svg/bigolive.svg', title: 'Bigolive'),
  SocialModel(imagePath: 'assets/images/svg/instagram.svg', title: 'Instagram'),
  SocialModel(
      imagePath: 'assets/images/svg/google.svg', title: 'Google review'),
  SocialModel(
      imagePath: 'assets/images/svg/mobilereview.svg', title: 'Mobile review'),
  SocialModel(
      imagePath: 'assets/images/svg/website.svg', title: 'Website traffic'),
  SocialModel(imagePath: 'assets/images/svg/facebook.svg', title: 'facebook'),
  SocialModel(imagePath: 'assets/images/svg/twitter.svg', title: 'Twitter'),
];
