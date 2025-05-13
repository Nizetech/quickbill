import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/giftCard/cards_option_screen.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:provider/provider.dart';

class BuyGiftCardScreen extends StatefulWidget {
  const BuyGiftCardScreen({super.key});

  @override
  State<BuyGiftCardScreen> createState() => _BuyGiftCardScreenState();
}

class _BuyGiftCardScreenState extends State<BuyGiftCardScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
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
                      'Buy Gift Cards',
                      style:
                          MyStyle.tx18Black.copyWith(color: themedata.tertiary),
                    ),
                  ),
                  const Spacer(), // Adds flexible space after the text
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                decoration: NewStyle.authInputDecoration.copyWith(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: themeProvider.isDarkMode()
                          ? const Color(0XFF33353C)
                          : MyColor.borderColor,
                    )),
                    hintText: 'Enter card name to filter',
                    fillColor: themeProvider.isDarkMode()
                        ? const Color(0XFF33353C)
                        : MyColor.textFieldFillColor,
                    suffixIcon: Image.asset(
                      'assets/images/search.png',
                      color: themedata.tertiary,
                    )),
              ),
              const SizedBox(
                height: 12,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 32.h,
                      ),
                      Text(
                        'Select Country',
                        style: MyStyle.tx14Black.copyWith(
                            color: themedata.tertiary,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      TextFormField(
                        enabled: false,
                        initialValue: 'United State',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: themedata.tertiary,
                          fontFamily: 'SF Pro Rounded',
                        ),
                        decoration: NewStyle.authInputDecoration.copyWith(
                            // hintText: 'Enter category to search',
                            fillColor: themeProvider.isDarkMode()
                                ? const Color(0XFF33353C)
                                : MyColor.textFieldFillColor,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset(
                                'assets/images/usa.png',
                                height: 8.r,
                                width: 10.r,
                              ),
                            ),
                            suffixIcon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: themedata.tertiary,
                            )),
                      ),
                      SizedBox(
                        height: 37.h,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: GridView.builder(
                          shrinkWrap: true,
                          // physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: (150.w) / (134.h),
                                  crossAxisSpacing: 20.w,
                                  mainAxisSpacing: 12.h,
                                  crossAxisCount: 2),
                          itemCount: 11,

                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const CardsOptionScreen(),
                                  ));
                                },
                                child: const CardsWidget());
                          },
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CardsWidget extends StatelessWidget {
  const CardsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Container(
      height: 134.h,
      width: 150.w,
      decoration: BoxDecoration(
          border: Border.all(
            color: themeProvider.isDarkMode()
                ? MyColor.borderDarkColor
                : MyColor.borderColor,
          ),
          borderRadius: BorderRadius.circular(15.r),
          color: Theme.of(context).scaffoldBackgroundColor),
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/amazon.png',
            height: 72.h,
            width: 110.w,
          ),
          SizedBox(
            height: 7.h,
          ),
          Text(
            'Amazon Us',
            style: MyStyle.tx18Black.copyWith(
                color: themeProvider.isDarkMode()
                    ? const Color(0XFFCBD2EB)
                    : const Color(0xff30333A)),
          ),
        ],
      ),
    );
  }
}
