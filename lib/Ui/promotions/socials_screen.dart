import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jost_pay_wallet/Models/social_section_model.dart';
import 'package:jost_pay_wallet/Provider/service_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

class SocialsScreen extends StatefulWidget {
  const SocialsScreen({super.key});

  @override
  State<SocialsScreen> createState() => _SocialsScreenState();
}

class _SocialsScreenState extends State<SocialsScreen> {
  @override
  void initState() {
    super.initState();
    final model = Provider.of<ServiceProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (model.socialSectionsModel == null) {
        model.getSocialSections();
      } else {
        model.getSocialSections(isLoading: false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Consumer<ServiceProvider>(builder: (context, model, _) {
        return Stack(
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
                    if (model.socialSectionsModel != null)
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: GridView.builder(
                          shrinkWrap: true,
                      
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemCount:
                              model.socialSectionsModel!.sections!.length,
                          itemBuilder: (context, index) {
                            final social =
                                model.socialSectionsModel!.sections![index];
                            return GestureDetector(
                                onTap: () {
                                  model
                                      .getSocialServices(int.parse(social.id!));
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
        );
      }
      ),
    );
  }
}

class SocialCard extends StatelessWidget {
  const SocialCard({
    super.key,
    required this.model,
  });
  final Section model;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
              imageUrl: model.sectionImage!,
              height: 40,
              width: 40,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(),
              errorWidget: (context, url, error) => Container()),
        ),
        SizedBox(
          height: 4.h,
        ),
        Text(
          model.sectionName!,
          style: MyStyle.tx16Black
              .copyWith(fontWeight: FontWeight.w400, color: theme.tertiary),
        ),
      ],
    );
  }
}
