import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Models/gift_card_model.dart';
import 'package:jost_pay_wallet/Provider/service_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/giftCard/cards_option_screen.dart';
import 'package:jost_pay_wallet/Ui/giftCard/widget/card_country_sheet.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:jost_pay_wallet/Models/country_model.dart';
import 'package:jost_pay_wallet/utils/toast.dart';
import 'package:provider/provider.dart';

class BuyGiftCardScreen extends StatefulWidget {
  const BuyGiftCardScreen({super.key});

  @override
  State<BuyGiftCardScreen> createState() => _BuyGiftCardScreenState();
}

class _BuyGiftCardScreenState extends State<BuyGiftCardScreen> {
  @override
  void initState() {
    super.initState();
    final model = Provider.of<ServiceProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (model.carTypeModel == null) {
        await model.getCardCountries();
      } else {
        await model.getCardCountries(isLoading: false);
      }
      await model.getGiftCard('US');
      selectedCountry = model.countryModel!.countries!
          .where((element) => element.countryCode!.toLowerCase() == 'us')
          .first;
      giftCards = model.giftCardsModel!.giftCards;
      setState(() {});
    });
  }

  Country? selectedCountry;
  List<GiftCard>? giftCards = [];
  final controller = TextEditingController(text: 'United States');
  final search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Consumer<ServiceProvider>(builder: (context, model, _) {
        return SafeArea(
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
                        style: MyStyle.tx18Black
                            .copyWith(color: themedata.tertiary),
                      ),
                    ),
                    const Spacer(), // Adds flexible space after the text
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: selectedCountry == null
                      ? () => fancyToast('Select Country')
                      : () {},
                  child: TextFormField(
                    enabled: selectedCountry != null,
                    controller: search,
                    onChanged: (val) {
                      if (val.isEmpty) {
                        setState(() {
                          giftCards = model.giftCardsModel!.giftCards;
                        });
                      } else {
                        setState(() {
                          giftCards = model.giftCardsModel!.giftCards!
                              .where(
                                (element) =>
                                    element.name!.toLowerCase().contains(
                                          val.toLowerCase(),
                                        ),
                              )
                              .toList();
                        });
                      }
                    },
                    style: MyStyle.tx14Black.copyWith(
                        color: themeProvider.isDarkMode()
                            ? MyColor.whiteColor
                            : MyColor.dark01Color,
                        decoration: TextDecoration.none),
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
                ),
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(
                        //   height: 32.h,
                        // ),
                        Text(
                          'Select Country',
                          style: MyStyle.tx14Black.copyWith(
                              color: themedata.tertiary,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            cardCountrySheet(
                                themeProvider: themeProvider,
                                countries: model.countryModel!.countries,
                                onSelect: (country) async {
                                  setState(() {
                                    selectedCountry = country;
                                    controller.text = country.countryName!;
                                  });

                                  await model.getGiftCard(
                                      selectedCountry!.countryCode!);
                                  giftCards = model.giftCardsModel!.giftCards;
                                });
                          },
                          child: TextFormField(
                            enabled: false,
                            controller: controller,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: themedata.tertiary,
                              fontFamily: 'SF Pro Rounded',
                            ),
                            decoration: NewStyle.authInputDecoration.copyWith(
                                hintText: 'Select Country',
                                fillColor: themeProvider.isDarkMode()
                                    ? const Color(0XFF33353C)
                                    : MyColor.textFieldFillColor,
                                prefixIcon: selectedCountry != null
                                    ? Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              selectedCountry!.countryFlag!,
                                          height: 20,
                                          width: 20,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              SizedBox.shrink(),
                                          errorWidget: (context, url, error) =>
                                              SizedBox.shrink(),
                                        ),
                                      )
                                    : null,
                                suffixIcon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: themedata.tertiary,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 37.h,
                        ),
                        if (model.giftCardsModel != null)
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.6,
                            child: GridView.builder(
                              shrinkWrap: true,
                              // physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: .8,
                                      crossAxisSpacing: 20.w,
                                      mainAxisSpacing: 12.h,
                                      crossAxisCount: 2),
                              itemCount: giftCards!.length,

                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      model.getCard(
                                          giftCards![index].id!.toString());
                                    },
                                    child: CardsWidget(
                                      card: giftCards![index],
                                    ));
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
        );
      }),
    );
  }
}

class CardsWidget extends StatelessWidget {
  final GiftCard card;
  const CardsWidget({
    super.key,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Container(
      // height: 134.h,
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
          // Image.asset(
          //   'assets/images/amazon.png',
          //   height: 72.h,
          //   width: 110.w,
          // ),
          CachedNetworkImage(
              imageUrl: card.image!.first,
              height: 72.h,
              width: 110.w,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(),
              errorWidget: (context, url, error) => Container()),
          SizedBox(
            height: 7.h,
          ),
          Text(
            card.name!,
            maxLines: 4,
            style: MyStyle.tx16Black.copyWith(
                overflow: TextOverflow.ellipsis,
                color: themeProvider.isDarkMode()
                    ? const Color(0XFFCBD2EB)
                    : const Color(0xff30333A)),
          ),
        ],
      ),
    );
  }
}
