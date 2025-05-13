import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/promotions/socials_screen.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:provider/provider.dart';

class PromoScreen extends StatelessWidget {
  const PromoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/promoBanner.png'),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Follow the follow to win Big!',
                      style: MyStyle.tx18Black.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                    const SizedBox(
                      height: 27,
                    ),
                    Text(
                      'For every airtime and data purchase, you qualify for a promo! If you have a promo code, tap submit to enter for a chance to win amazing gifts.',
                      style: MyStyle.tx18Black.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: const Color(0xff6B7280)),
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    Text(
                      'Got a promo code? Tab submit to enter',
                      style: MyStyle.tx18Black.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: const Color(0xff6B7280)),
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return Theme(
                                data: Theme.of(context),
                                child: Builder(builder: (context) {
                                  return Material(
                                    type: MaterialType.transparency,
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      height: 593,
                                      padding: EdgeInsets.fromLTRB(
                                        0,
                                        20,
                                        0,
                                        MediaQuery.viewInsetsOf(context).bottom,
                                      ),
                                      decoration: const BoxDecoration(
                                        color: MyColor.lightGreenColor,
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(16)),
                                      ),
                                      child: Stack(
                                        alignment: Alignment.topCenter,
                                        children: [
                                          Positioned(
                                              top: -70,
                                              right: 0,
                                              left: 0,
                                              child: Image.asset(
                                                  'assets/images/box.png')),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              width: double.infinity,
                                              padding: const EdgeInsets.all(30),
                                              height: 345,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          topRight:
                                                              Radius.circular(
                                                                  10)),
                                                  color:
                                                      themeProvider.isDarkMode()
                                                          ? Colors.black
                                                          : MyColor.splashBtn),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'Claim a prize worth of 1million naira',
                                                    style: MyStyle.tx20Grey
                                                        .copyWith(
                                                            color: MyColor
                                                                .mainWhiteColor),
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Text(
                                                    'Earn a limited- time reward by just making transaction with us!',
                                                    style: MyStyle.tx20Grey
                                                        .copyWith(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: MyColor
                                                                .mainWhiteColor),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  const SizedBox(
                                                    height: 25,
                                                  ),
                                                  TextFormField(
                                                    // controller: _emailController,
                                                    decoration: NewStyle
                                                        .authInputDecoration
                                                        .copyWith(
                                                            fillColor: Colors
                                                                .transparent,
                                                            // fillColor: themeProvider
                                                            //         .isDarkMode()
                                                            //     ? Color(
                                                            //         0XFF33353C)
                                                            //     : MyColor
                                                            //         .textFieldFillColor,
                                                            hintText:
                                                                'Enter code'),
                                                  ),
                                                  const SizedBox(
                                                    height: 35,
                                                  ),
                                                  SizedBox(
                                                    width: double.infinity,
                                                    child: TextButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const SocialsScreen(),
                                                            ));
                                                      },
                                                      style:
                                                          TextButton.styleFrom(
                                                        backgroundColor:
                                                            MyColor.splashBtn,
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            vertical:
                                                                16), // Padding
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          side:
                                                              const BorderSide(
                                                            color: MyColor
                                                                .mainWhiteColor,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        "Submit",
                                                        style: MyStyle.tx16Green
                                                            .copyWith(
                                                                color: MyColor
                                                                    .mainWhiteColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              );
                            },
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: MyColor.greenColor,
                          padding: const EdgeInsets.symmetric(
                              vertical: 16), // Padding
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text(
                          "Enter Code",
                          style: MyStyle.tx16White,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
